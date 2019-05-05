# Function to extract citize science metrics 

extract_obs_area <- function(obs, regions, census, taxaname) {

library(sf)
library(dplyr)

# Separate observations by regions
  
# Import shapefile of census regions and subset it to keep quebec regions
regions$PRNAME <- gsub("Quebec / Qu\xe9bec", "Quebec", regions$PRNAME)
regions_qc <- subset(regions, PRNAME == "Quebec")
# Reproject layer to wgs84
regions_qc <- st_transform(regions_qc, crs = 4326) %>%  subset(select = c("CDUID", "geometry"))

# Import observations csv and transform to spatial points 
obs_sf <- st_as_sf(obs, coords = c("longitude", "latitude"), crs = 4326) %>% subset(select = c("X", "scientific_name", "datetime", "user_login","id", "geometry")) 

# Get observations that fall in each different census region (the output dataframe has each association associated with the right census id)
obs_region <- data.frame()
for (i in 1:nrow(regions_qc)){
  census_region <- regions_qc[i, ]
  ID <- census_region$CDUID
  obs <- st_join(census_region, obs_sf, join = st_intersects)
  obs <- st_set_geometry(obs, NULL)
  obs_region <- rbind(obs_region, obs)
}

# Calculate metrics that we want to explain with our models

# Calculate total numer of observers by region 
tot_obs <- obs_region %>% group_by(CDUID) %>% summarise(tot_nb_obs = n())

## 1. Mean observations by observer = mean observer effort

mean_observer_effort <- obs_region %>% 
  group_by(CDUID, user_login) %>% 
  summarise(nb_obs = n()) %>% 
  group_by(CDUID) %>% 
  summarise(mean_obs_per_observer = mean(nb_obs), 
            nb_observer = n(),
            stderror = sd(nb_obs)/sqrt(n()))


## 2. Observations per capita (#obs/total_pop)

# calculate number of observations per census division
obs_cduid <- obs_region %>%
                group_by(CDUID) %>%
                tally()

# calculate # obs per total population
obs_totalpop <- obs_cduid %>%
  mutate(obs_totalpop = (n/qc_econ$Total_pop))


## 3. Participants %

participants <- mean_observer_effort %>%
  mutate(observer_totalpop = nb_observer/qc_econ$Total_pop)
  
# assemble the metrics into a table
citsci_metrics <- full_join(obs_totalpop,
                            participants,
                            by = "CDUID")

citsci_metrics <- full_join(citsci_metrics,
                            tot_obs,
                            by = "CDUID")

# remove columns that aren't needed
citsci_metrics <- subset(citsci_metrics, select = -c(n, nb_observer))


# add taxa name column
citsci_metrics <- citsci_metrics %>%
  mutate(taxa = taxaname)


# write file
write.csv(citsci_metrics, paste0("data/citsci_metrics/citsci_metrics_",taxaname,".csv"), row.names = FALSE)
}
