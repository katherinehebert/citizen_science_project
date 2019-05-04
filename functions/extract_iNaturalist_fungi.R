# Extracting iNaturalist observations for birds in Canada

# load iNaturalist library + map library
library(rinat)
library(maps)
library(mapdata)
library(ggmap)

####Extract datas from Inat per month for 2011 to 2018 per month.
CAN <- c(45,-78,62,-60)#Set boundaries

#2014
datalist <- list()
for (i in 1:12){
    data1<- get_inat_obs(taxon_name = "Fungi",
             year = 2014,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
    datalist[[i]] <- data1
}
d14<- do.call(rbind, datalist)

#2015
datalist <- list()
for (i in 1:12){
    data1<- get_inat_obs(taxon_name = "Fungi",
             year = 2015,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
    datalist[[i]] <- data1
}
d15<- do.call(rbind, datalist)
#2016
datalist <- list()
for (i in 1:12){
    data1<- get_inat_obs(taxon_name = "Fungi",
             year = 2016,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
    datalist[[i]] <- data1
}
d16<- do.call(rbind, datalist)
#2017
datalist <- list()
for (i in 1:12){
    data1<- get_inat_obs(taxon_name = "Fungi",
             year = 2017,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
    datalist[[i]] <- data1
}
d17<- do.call(rbind, datalist)
#2018
datalist <- list()
for (i in 1:12){
    data1<- get_inat_obs(taxon_name = "Fungi",
             year = 2018,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
    datalist[[i]] <- data1
}
d18<- do.call(rbind, datalist)
## Obtain a data frame from the list
df_final<- rbind(d14,d15,d16,d17,d18)
str(df_final)
df_final$datetime
inat_datas <- write.csv(df_final, file = "inat_datas_fungi.csv")