Maps
================
Renata Diaz
5/4/2019

``` r
can <- read_sf(paste0(here(), '/data/can_census_divisions_shp/gcd_000b11a_e.shp'))

qu <- unique(can$PRNAME)[6]

can<- can %>%
  filter(PRNAME == qu) %>%
  mutate(CDUID = as.integer(CDUID))

nhs_data <- read.csv(paste0(here(), '/data/canada_economic_metrics/censusdivisions_econmetrics.csv'), stringsAsFactors = F)

nhs_data <- nhs_data %>%
  select(-Prov_Name, -CD_Name, -Geo_Type, -GNR) %>%
  rename(CDUID = Geo_Code)

can <- can %>%
  left_join(nhs_data, by = 'CDUID')
```

``` r
avg_h_income_plot <-  ggplot(data = can) +
  geom_sf(aes(fill = Average_Household_Income)) +
  scale_fill_viridis() +
  ggtitle('Average household income')

print(avg_h_income_plot)
```

![](economic_metrics_maps_files/figure-markdown_github/plot%20average%20household%20income-1.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 16:02:42 EDT"

``` r
avg_i_income_plot <-  ggplot(data = can) +
  geom_sf(aes(fill = Average_Ind_income)) +
  scale_fill_viridis() +
  ggtitle('Average individual income')

print(avg_i_income_plot)
```

![](economic_metrics_maps_files/figure-markdown_github/plot%20average%20ind%20income-1.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 16:05:03 EDT"

``` r
total_pop_plot <-  ggplot(data = can) +
  geom_sf(aes(fill = Total_pop)) +
  scale_fill_viridis() +
  ggtitle('Total population')

print(total_pop_plot)
```

![](economic_metrics_maps_files/figure-markdown_github/plot%20total%20population-1.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 16:07:35 EDT"
