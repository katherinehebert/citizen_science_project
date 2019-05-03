# Extracting iNaturalist observations for birds in Canada

# load iNaturalist library
library(rinat)

# bounding box for Canada
CAN <- c(45,-78,51,-64)

# extract 10 results of birds in Canada bounding box
iNat <- get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10) # extract 10 just to test function
iNat

inat_map(iNat, map = "can", subregion = ".", plot = TRUE)
