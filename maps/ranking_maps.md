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

ranking <- read.csv(paste0(here::here(), '/data/citsci_metrics/all_taxa_ranking.csv'), stringsAsFactors = F)

ranking <- ranking %>%
  select(-X) %>%
  rename(CDUID = Geo_Code)
  
   can <- can %>%
    left_join(ranking, by = 'CDUID')
  
  # Make maps of summary stats from toy stats
  # Use viridis for color blind friendly colors.
  ls_taxa = unique(can$taxa)
  
  for(i in 1:length(ls_taxa)) {
    this_taxon = ls_taxa[i]
  print(Sys.time())
  
  this_can <- can %>%
    filter(taxa == this_taxon)
  
 ranking_plot <- ggplot(data = this_can) +
    geom_sf(aes(fill = Rank)) +
    scale_fill_viridis() +
    ggtitle(paste0('Ranking - ', this_taxon))
  
  print(ranking_plot)
  print(Sys.time())
  
}
```

    ## [1] "2019-05-04 16:53:56 EDT"

![](ranking_maps_files/figure-markdown_github/handle%20data-1.png)

    ## [1] "2019-05-04 16:55:19 EDT"
    ## [1] "2019-05-04 16:55:19 EDT"

![](ranking_maps_files/figure-markdown_github/handle%20data-2.png)

    ## [1] "2019-05-04 16:56:38 EDT"
    ## [1] "2019-05-04 16:56:38 EDT"

![](ranking_maps_files/figure-markdown_github/handle%20data-3.png)

    ## [1] "2019-05-04 16:57:59 EDT"
    ## [1] "2019-05-04 16:57:59 EDT"

![](ranking_maps_files/figure-markdown_github/handle%20data-4.png)

    ## [1] "2019-05-04 16:59:18 EDT"
    ## [1] "2019-05-04 16:59:18 EDT"

![](ranking_maps_files/figure-markdown_github/handle%20data-5.png)

    ## [1] "2019-05-04 17:00:34 EDT"
