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

bird_data <- read.csv(paste0(here(), '/data/citsci_metrics/citsci_metrics_birds.csv'), stringsAsFactors = F)

can <- can %>%
  left_join(bird_data, by = 'CDUID')
```

``` r
# Make maps of summary stats from toy stats
# Use viridis for color blind friendly colors.

can_short <- can[1:10, ]

print(Sys.time())
```

    ## [1] "2019-05-04 12:00:18 EDT"

``` r
obspercap_plot <- ggplot(data = can) +
  geom_sf(aes(fill = obs_totalpop)) +
  scale_fill_viridis() +
  ggtitle('Observations per capita - Birds')

print(obspercap_plot)
```

![](birds_maps_files/figure-markdown_github/make%20birds%20maps-1.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 12:01:31 EDT"

``` r
indpercap_plot <- ggplot(data = can) +
  geom_sf(aes(fill = observer_totalpop)) +
  scale_fill_viridis() +
  ggtitle('Observers per capita - Birds')

print(indpercap_plot)
```

![](birds_maps_files/figure-markdown_github/make%20birds%20maps-2.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 12:02:43 EDT"

``` r
obsperind_plot <-  ggplot(data = can) +
  geom_sf(aes(fill = mean_obs_per_observer)) +
  scale_fill_viridis() +
  ggtitle('Observations per observer - Birds')

print(obsperind_plot)
```

![](birds_maps_files/figure-markdown_github/make%20birds%20maps-3.png)

``` r
print(Sys.time())
```

    ## [1] "2019-05-04 12:03:55 EDT"
