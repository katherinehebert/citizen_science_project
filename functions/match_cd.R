library(sf)
library(dplyr)

can <- read_sf('data/can_census_divisions_shp/gcd_000b11a_e.shp')

qu <- unique(can$PRNAME)[6]

can_data <- can %>%
  filter(PRNAME == qu) %>%
  as.data.frame() %>%
  select(-geometry)

nhs_data <- read.csv('data/canada_economic_metrics/censusdivisions_econmetrics.csv', stringsAsFactors = F)

