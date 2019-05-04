Maps
================
Renata Diaz
5/4/2019

``` r
can <- read_sf('data/can_census_divisions_shp/gcd_000b11a_e.shp')

qu <- unique(can$PRNAME)[6]

can<- can %>%
  filter(PRNAME == qu) %>%
  mutate(CDUID = as.integer(CDUID))

nhs_data <- read.csv('data/canada_economic_metrics/censusdivisions_econmetrics.csv', stringsAsFactors = F)

nhs_data <- nhs_data %>%
  select(-Prov_Name, -CD_Name, -Geo_Type, -GNR) %>%
  rename(CDUID = Geo_Code)

can <- can %>%
  left_join(nhs_data, by = 'CDUID')

# add toy variables
can <- can %>%
  mutate(nbobs = sample(x = c(50:100), size = nrow(can), replace = T), 
         nbind = sample(x = c(1:49), size = nrow(can), replace = T))

# stats to plot

can <- can %>%
  mutate(nbobs_per_pop = nbobs/Total_pop, 
         nbind_per_pop = nbind/Total_pop,
         nbobs_per_ind = nbobs/nbind)
```

``` r
# Make maps of summary stats from toy stats
# Use viridis for color blind friendly colors.

can_short <- can[1:10, ]

print(Sys.time())
```

    ## [1] "2019-05-04 11:01:34 EDT"

``` r
obspercap_plot <- ggplot(data = can) +
  geom_sf(aes(fill = nbobs_per_pop)) +
  scale_fill_viridis() +
  ggtitle('Observations per capita')

print(obspercap_plot)
```

![](maps_files/figure-markdown_github/make%20maps-1.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 11:02:55 EDT"

``` r
indpercap_plot <- ggplot(data = can) +
  geom_sf(aes(fill = nbind_per_pop)) +
  scale_fill_viridis() +
  ggtitle('Observers per capita')

print(indpercap_plot)
```

![](maps_files/figure-markdown_github/make%20maps-2.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 11:04:11 EDT"

``` r
obsperind_plot <-  ggplot(data = can) +
  geom_sf(aes(fill = nbobs_per_ind)) +
  scale_fill_viridis() +
  ggtitle('Observations per observer')

print(obsperind_plot)
```

![](maps_files/figure-markdown_github/make%20maps-3.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 11:05:26 EDT"
