# Calculate the ranks for the global participation index and calculate relative abundance of each taxa in each region 

library(tidyr)
library(dplyr)

# Import data
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

# Ranking function 
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

# Make a loop to apply function on all taxa
taxa <- list(birds, fungi, insects, plants, mammals)
for (i in 1:length(taxa)){
    r <- ranking(taxa[[i]])
    assign(paste(unique(taxa[[i]]$taxa), "ranking", sep = "_"), r)
  }

# Merge all species dataframes 
all_taxa_ranking <- rbind(birds_ranking, fungi_ranking, insects_ranking, mammals_ranking, plants_ranking) 

# Calculate relative abundance of each taxa
rel_abundance <- all_taxa_ranking %>% subset(select = c(Geo_Code, taxa, tot_nb_obs)) %>% spread('taxa', 'tot_nb_obs')

rel_abundance$sum <- apply(rel_abundance[,-1],1, sum)

for (i in 2:(ncol(rel_abundance)-1)){
  rel_abundance[,i] <- rel_abundance[,i]/test[,ncol(rel_abundance)]
}
rel_abundance[,c(-1, -ncol(rel_abundance))] <- apply(rel_abundance[,c(-1, -ncol(rel_abundance))], c(1,2), function(x) x*100)

write.csv(rel_abundance, file = "data/relative_taxa_abundance.csv")

write.csv(all_taxa_ranking, file = "data/citsci_metrics/all_taxa_ranking.csv")
