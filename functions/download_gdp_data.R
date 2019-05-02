download_gdp <- function() {
  if(!require(WDI)){ install.packages("WDI") }  
gdp_names <- WDI::WDIsearch(string='gdp', field = 'name')
gdps <- gdp_names[c(10, 40), 1]

gdp_data <- WDI::WDI(country = 'all', indicator = gdps[1], start = NULL,end = NULL, extra = FALSE, cache = NULL)

gdp_percapita_data <- WDI::WDI(country = 'all', indicator = gdps[2], start = NULL,end = NULL, extra = FALSE, cache = NULL)

write.csv(gdp_data, 'data/global_economic_metrics/gdp__data.csv')
write.csv(gdp_percapita_data, 'data/global_economic_metrics/gdp_percapita_data.csv')
}
