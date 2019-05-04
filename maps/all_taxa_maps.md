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

data_files <- list.files(path = paste0(here::here(), '/data/citsci_metrics'), full.names = T)

for(i in 1:length(data_files)) {
  this_taxon = unlist(strsplit(data_files[i], split = "_"))[6]
  this_taxon = substr(this_taxon, 1, nchar(this_taxon) - 4)
  
  this_data <- read.csv(data_files[i], stringsAsFactors = F)
  
  this_can <- can %>%
    left_join(this_data, by = 'CDUID')
  
  # Make maps of summary stats from toy stats
  # Use viridis for color blind friendly colors.
  
  
  print(Sys.time())
  
  obspercap_plot <- ggplot(data = this_can) +
    geom_sf(aes(fill = obs_totalpop)) +
    scale_fill_viridis() +
    ggtitle(paste0('Observations per capita - ', this_taxon))
  
  print(obspercap_plot)
  print(Sys.time())
  
  indpercap_plot <- ggplot(data = this_can) +
    geom_sf(aes(fill = observer_totalpop)) +
    scale_fill_viridis() +
    ggtitle(paste0('Observers per capita - ', this_taxon))
  
  print(indpercap_plot)
  print(Sys.time())
  
  obsperind_plot <-  ggplot(data = this_can) +
    geom_sf(aes(fill = mean_obs_per_observer)) +
    scale_fill_viridis() +
    ggtitle(paste0('Observations per observer - ', this_taxon))
  
  print(obsperind_plot)
  print(Sys.time())
}
```

    ## [1] "2019-05-04 14:47:08 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-1.png)

    ## [1] "2019-05-04 14:48:21 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-2.png)

    ## [1] "2019-05-04 14:49:33 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-3.png)

    ## [1] "2019-05-04 14:50:49 EDT"
    ## [1] "2019-05-04 14:50:49 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-4.png)

    ## [1] "2019-05-04 14:52:02 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-5.png)

    ## [1] "2019-05-04 14:53:15 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-6.png)

    ## [1] "2019-05-04 14:54:28 EDT"
    ## [1] "2019-05-04 14:54:28 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-7.png)

    ## [1] "2019-05-04 14:55:41 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-8.png)

    ## [1] "2019-05-04 14:56:56 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-9.png)

    ## [1] "2019-05-04 14:58:09 EDT"
    ## [1] "2019-05-04 14:58:09 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-10.png)

    ## [1] "2019-05-04 14:59:22 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-11.png)

    ## [1] "2019-05-04 15:00:35 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-12.png)

    ## [1] "2019-05-04 15:01:54 EDT"
    ## [1] "2019-05-04 15:01:55 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-13.png)

    ## [1] "2019-05-04 15:03:10 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-14.png)

    ## [1] "2019-05-04 15:04:24 EDT"

![](all_taxa_maps_files/figure-markdown_github/handle%20data-15.png)

    ## [1] "2019-05-04 15:05:37 EDT"
