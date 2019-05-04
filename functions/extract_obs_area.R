# Separate observations by regions

library(sf)
library(dplyr)

# Import shapefile of census regions and subset it to keep quebec regions
regions <-  read_sf("data/can_census_divisions_shp/gcd_000b11a_e.shp")
regions$PRNAME <- gsub("Quebec / Qu\xe9bec", "Quebec", regions$PRNAME)
regions_qc <- subset(regions, PRNAME == "Quebec")
# Reproject layer to wgs84
regions_qc <- st_transform(regions_qc, crs = 4326) %>%  subset(select = c("CDUID", "geometry"))

# Import observations csv and transform to spatial points 
obs <- read.csv(file = "data/inat/inat_data_birds.csv")
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


## 1. Mean observations by observer = mean observer effort

mean_observer_effort <- obs_region %>% 
  group_by(CDUID, user_login) %>% 
  summarise(nb_obs = n()) %>% 
  group_by(CDUID) %>% 
  summarise(mean_obs_per_observer = mean(nb_obs), nb_observer = n())

# import census metrics
qc_econ <- read.csv("data/canada_economic_metrics/censusdivisions_econmetrics.csv")
# change name of census ID column to match obs_region
colnames(qc_econ)[1] <- "CDUID"

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
# remove columns that aren't needed
citsci_metrics <- subset(citsci_metrics, select = -c(n, nb_observer))
# write file
write.csv(citsci_metrics, "data/citsci_metrics/citsci_metrics_birds.csv", row.names = FALSE)
