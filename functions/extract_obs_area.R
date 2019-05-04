# Separate observations by county or postal code

library(sf)

regions <-  read_sf("data/can_census_divisions_shp/gcd_000b11a_e.shp")


obs_sf <- st_as_sf(obs, coords = c("UTM_Easting", "UTM_Northing"), crs = 26717)

subset(census, PRNAME == )

for (i in 1:length(nids_spp)){
  nids_spp[[i]]$x <- nids_spp[[i]]$UTM_Easting
  nids_spp[[i]]$y <- nids_spp[[i]]$UTM_Northing
  species <- unique(nids_spp[[i]]$Species)
  file <- paste(species, species, sep = "/")  %>% paste("nids_zone", sep = "_")  %>% paste("csv", sep = ".")
  points_sf <- st_as_sf(nids_spp[[i]], coords = c("UTM_Easting", "UTM_Northing"), crs = 26717)
  nids_zone <- st_join(points_sf, zone_etude, join = st_intersects) %>% subset(id == 1)
  assign(paste("sfnids", species, sep = "_"), nids_zone)
  write.csv(nids_zone, file = file)
} 