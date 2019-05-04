birds <- read.table("data/citsci_metrics/citsci_metrics_birds.csv",header = TRUE,sep=",")
colnames(birds)[1] <- "Geo_Code"

fungi <- read.table("data/citsci_metrics/citsci_metrics_fungi.csv",header = TRUE,sep=",")
colnames(fungi)[1] <- "Geo_Code"

insects <- read.table("data/citsci_metrics/citsci_metrics_insects.csv",header = TRUE,sep=",")
colnames(insects)[1] <- "Geo_Code"

plants <- read.table("data/citsci_metrics/citsci_metrics_plants.csv",header = TRUE,sep=",")
colnames(plants)[1] <- "Geo_Code"

mammals <- read.table("data/citsci_metrics/citsci_metrics_mammals.csv",header = TRUE,sep=",")
colnames(mammals)[1] <- "Geo_Code"

ranking <- function(data){
data <- data[order(data$obs_totalpop,decreasing=T),] 
data$totalpop_rank <- c(1:nrow(data))
data <- data[order(data$mean_obs_per_observer,decreasing=T),] 
data$totalpop_rank2 <- c(1:nrow(data))
data  <- data[order(data$observer_totalpop,decreasing=T),] 
data$totalpop_rank3 <- c(1:nrow(data))
data$Rank <- c(data$totalpop_rank + data$totalpop_rank2 + data$totalpop_rank3)
return(dataframe = data)
}
i=1
data <- taxa[[i]]

taxa <- list(birds, fungi, insects, plants, mammals)
for (i in 1:length(taxa)){
    r <- ranking(taxa[[i]])
    assign(paste(unique(taxa[[i]]$taxa), "ranking", sep = "_"), r)
  }

all_taxa_ranking <- rbind(birds_ranking, fungi_ranking, insects_ranking, mammals_ranking, plants_ranking) 

write.csv(all_taxa_ranking, file = "data/citsci_metrics/all_taxa_ranking.csv")
