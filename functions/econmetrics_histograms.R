# Descriptive plots of economic metrics

# load package
library(tidyverse)

# import census economic metrics
qc_econ <- read.csv("data/canada_economic_metrics/censusdivisions_econmetrics.csv",
                     row.names = 1)

# vector of economic metric column names
metrics <- c("Average_Household_Income", "Median_Household_Income", 
             "Average_Ind_income", "Median_Ind_income")
# vector of cleaner metric names for plot labels
metrics.cln <- c("Average household income", "Median household income",
                 "Average individual income", "Median individual income")

# Base histograms of economic metrics

# split plot window into 4 panels
par(mfrow = c(2,2))

# sizes of labels and axes
lab <- 1.2
ax <- 1.2

# create histogram for each metric
for(i in 1:length(metrics)){
  # amount to adjust/extend x axis limits by 10% of its length
  adjust <- max(qc_econ[,metrics[i]])/10
  # histogram
  hist(qc_econ[,metrics[i]], col = "grey37", border = "white",
       xlab = metrics.cln[i], main = NA,
       cex.lab = lab, cex.axis = ax,
       xlim = c((min(qc_econ[,metrics[i]]) - adjust), 
                (max(qc_econ[,metrics[i]]) + adjust)))
}

