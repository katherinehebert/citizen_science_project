# Extracting iNaturalist observations for birds in Canada

# load iNaturalist library
library(rinat)
library(maps)
library(mapdata)
library(mapproj)
library(ggmap)

# bounding box for Canada
CAN <- c(45,-78,62,-60)

iNat <- get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 50000)
         

inat_map(iNat, map="world",subregion = ".", plot = TRUE)

map("worldHires","Canada",xlim=c(-141,-53), ylim=c(40,85), col="gray90", fill=TRUE)


####Extract datas from Inat
CAN <- c(45,-78,62,-60)#Set boundaries
data1 <- get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
inat_datas <- write.csv(data1, file = "inat_datas.csv")

data2 <- get_inat_obs(taxon_name = "Aves",
                      year = 2018,
             bounds = CAN,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10)



 
inatmap <- function(grpid){
    CAN <- c(45,-78,62,-60)
  data1= get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
  data1=data1[which(!is.na(data1$latitude)),]
  map <-get_map(location =c(min(data1$longitude),
                            min(data1$latitude),
                            max(data1$longitude),
                            max(data1$latitude)),
                messaging = FALSE)
  p <-ggplot()
  p= ggmap(map)+geom_point(data=data1,
                           aes(x=as.numeric(longitude),
                               y=as.numeric(latitude)))
  p
}

map1 <- inatmap("piou")
dev.off()
head(data1)
