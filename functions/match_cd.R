library(sf)
library(dplyr)

can <- read_sf('data/can_census_divisions_shp/gcd_000b11a_e.shp')

qu <- unique(can$PRNAME)[6]

can<- can %>%
  filter(PRNAME == qu) %>%
  mutate(CDUID = as.integer(CDUID))

nhs_data <- read.csv('data/canada_economic_metrics/censusdivisions_econmetrics.csv', stringsAsFactors = F)

nhs_data <- nhs_data %>%
  select(-Prov_Name, -CD_Name, -Geo_Type, -GNR) %>%
  rename(CDUID = Geo_Code)


