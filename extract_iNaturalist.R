# Extracting iNaturalist observations for birds in Canada

# load iNaturalist library
library(rinat)

# bounding box for Canada
CAN <- c(38.44047,-125,40.86652,-121.837)

# extract 10 results of birds in Canada bounding box
iNat <- get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             maxresults = 10) # extract 10 just to test function


