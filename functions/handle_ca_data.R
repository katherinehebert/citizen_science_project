library(dplyr)
handle_ca_data <- function(){
  
  nhs_qc <- read.csv('data/canada_economic_metrics/census_divisions/99-004-XWE2011001-701.csv', skip = 1, 
                     stringsAsFactors = F)
  
  nhs_qc_econ <- nhs_qc %>%
    filter(Prov_Name == 'Quebec') %>%
    filter(Topic %in% c('Income of individuals in 2010', 'Citizenship', 'Income of households in 2010'), 
           Characteristic %in% c('Total population in private households by citizenship',
                                 'Total income in 2010 of population aged 15 years and over', 
                                 '  Median income ($)',  
                                 '  Average income ($)', 
                                 'Household income in 2010 of private households',
                                 '  Median household total income ($)',
                                 '  Average household total income ($)')) %>%
    select(Geo_code, Prov_Name, CD_Name, Geo_Type, GNR, Characteristic, Total) %>% 
    group_by(Characteristic) %>%
    tidyr::spread(key = Characteristic, value = Total, fill = NA) %>%
    ungroup()
  
  colnames(nhs_qc_econ) <- c('Geo_Code',
                             'Prov_Name',
                             'CD_Name',
                             'Geo_Type',
                             'GNR',
                             'Average_Household_Income',
                             'Average_Ind_income',
                             'Median_Household_Income',
                             'Median_Ind_income',
                             'Total_Household_income',
                             'Total_Ind_income',
                             'Total_pop')
  
  write.csv(nhs_qc_econ, file = 'data/canada_economic_metrics/censusdivisions_econmetrics.csv', row.names = F)
  
  return(TRUE)
  
}

