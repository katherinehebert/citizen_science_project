# Extracting iNaturalist observations for birds in Canada

# load iNaturalist library
library(rinat)
library(maps)
library(mapdata)
library(mapproj)
library(ggmap)

####Extract datas from Inat per month for 2017
CAN <- c(45,-78,62,-60)#Set boundaries

datalist <- list()
for (i in 1:12) {
    data1<- get_inat_obs(taxon_name = "Aves",
             year = 2017,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
   datalist[[i]] <- data1
}
df_final1<- do.call(rbind, datalist)


####Extract datas from Inat per month for 2018
CAN <- c(45,-78,62,-60)#Set boundaries

datalist <- list()
for (i in 1:12) {
    data1<- get_inat_obs(taxon_name = "Aves",
             year = 2018,
             bounds = CAN,
             month = i,
             geo=TRUE, # exclude non-georeferenced observations
             maxresults = 10000)
   datalist[[i]] <- data1
}

df_final2<- do.call(rbind, datalist)

df_final <- rbind(df_final1,df_final2)
str(df_final)
inat_datas <- write.csv(df_final, file = "inat_datas_all.csv")

## Generate a map of all observations
inatmap <- function(grpid){
  data1=df_final[which(!is.na(df_final$latitude)),]
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

inatmap("piou")
dev.copy2pdf(file="Datas_Inat.pdf")
dev.off()
