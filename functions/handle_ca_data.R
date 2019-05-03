library(dplyr)
library(sf)
handle_ca_data <- function(){
 
  nhs_qc <- read.csv('data/canada_economic_metrics/census_divisions/99-004-XWE2011001-701.csv', skip = 1, 
                     stringsAsFactors = F)
  
  nhs_qc_econ <- nhs_qc %>%
    filter(Prov_Name == 'Quebec') %>%
    filter(Topic == 'Income of individuals in 2010', 
           Characteristic %in% c('Total income in 2010 of population aged 15 years and over', '  Median income ($)',  '  Average income ($)')) %>%
    select(Geo_code, Prov_Name, CD_Name, Geo_Type, GNR, Characteristic, Total) %>% 
    group_by(Characteristic) %>%
    tidyr::spread(key = Characteristic, value = Total, fill = NA) %>%
    ungroup()
  
  colnames(nhs_qc_econ) <- c('Geo_Code',
                             'Prov_Name',
                             'CD_Name',
                             'Geo_Type',
                             'GNR',
                             'Average_income',
                             'Median_income',
                             'Total_income')
  
  write.csv(nhs_qc_econ, file = 'data/canada_economic_metrics/censusdivisions_econmetrics.csv')
  
  return(TRUE)
  
}

