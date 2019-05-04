# Create shapefiles containing all informations about census info and participation metrics to make maps on qgis

library(sf)
library(dplyr)

# Import census regions shapefile
census_region <- st_read("data/can_census_divisions_shp/quebec_census_regions.shp")
colnames(census_region)[1] <- "Geo_Code"
census_region <- mutate_at(census_region, vars(Geo_Code), list(as.character))

obs <- read.csv(file="data/citsci_metrics/all_taxa_ranking.csv")
obs <- mutate_at(obs, vars(Geo_Code), list(as.character))
taxa <- c("birds", "fungi", "insects", "mammals", "plants")
obs_taxa <- list()
for (i in 1:length(taxa)){
o <- subset(obs, taxa == taxa[i])
obs_taxa[[i]] <- assign(paste("obs", taxa[i], sep = "_"), o) 
}

census_metrics <- read.csv("data/canada_economic_metrics/censusdivisions_econmetrics.csv")
census_metrics <- mutate_at(census_metrics, vars(Geo_Code), list(as.character))

census_metrics_spatial <- full_join(census_region, census_metrics, by = "Geo_Code")

for (i in 1:length(taxa)){
file <- paste(taxa[i], "census.shp", sep = "_")
 tb <- full_join(census_metrics_spatial, obs_taxa[[i]], by = "Geo_Code")
 st_write(tb, file)
}

