# Extract citizen science metrics for all taxa

# import census regions
regions <- read_sf("can_census_divisions_shp/gcd_000b11a_e.shp")

# import census metrics
qc_econ <- read.csv("canada_economic_metrics/censusdivisions_econmetrics.csv")
# change name of census ID column to match obs_region
colnames(qc_econ)[1] <- "CDUID"

# import all iNaturalist observation datasets in data folder
setwd("inat/")
taxafiles <- list.files(pattern = ".csv")
obs <- lapply(taxafiles, read.csv)

# create taxanames vector by cleaning taxa files names
taxanames <- gsub("inat_data_", "", taxafiles)
taxanames <- gsub(".csv", "", taxanames)

setwd
# load function to create citizen science metrics
source('~/Documents/Cours/ecole_ete_bios2/citizen_science_project/functions/FUN_extract_obs_area.R', echo=TRUE)

# reset working directory
setwd("~/Documents/Cours/ecole_ete_bios2/citizen_science_project/")
# run for all iNaturalist datasets
for(i in 1:length(obs)){
  extract_obs_area(obs = obs[[i]],
                   regions = regions,
                   census = qc_econ,
                   taxaname = taxanames[i])
}