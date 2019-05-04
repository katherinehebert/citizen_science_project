# Extract citizen science metrics for all taxa

# import census regions
regions <- read_sf("data/can_census_divisions_shp/gcd_000b11a_e.shp")

# import census metrics
qc_econ <- read.csv("data/canada_economic_metrics/censusdivisions_econmetrics.csv")
# change name of census ID column to match obs_region
colnames(qc_econ)[1] <- "CDUID"

# import all iNaturalist observation datasets in data folder
setwd("~/Documents/PhD/Courses/DDES2019/citizenscience/citizen_science_project/data/inat")
taxafiles <- list.files(pattern = ".csv")
obs <- lapply(taxafiles, read.csv)

# create taxanames vector by cleaning taxa files names
taxanames <- gsub("inat_data_", "", taxafiles)
taxanames <- gsub(".csv", "", taxanames)

# load function to create citizen science metrics
source('~/Documents/PhD/Courses/DDES2019/citizenscience/citizen_science_project/functions/FUN_extract_obs_area.R', echo=TRUE)

# run for all iNaturalist datasets
for(i in 1:length(obs)){
  extract_obs_area(obs = obs[[i]],
                   regions = regions,
                   census = qc_econ,
                   taxaname = taxanames[i])
}
