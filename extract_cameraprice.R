# Extract camera prices from Amazon pages

# load library for scraping
library(rvest)

# set webpage to scrape
camera <- read_html("https://www.amazon.ca/Nikon-COOLPIX-Digital-Camera-Black/dp/B01CNPEGGI/ref=sr_1_1_sspa?crid=3UKSQQLXIMHY1&keywords=canon+camera&qid=1556826749&s=gateway&sprefix=canon+%2Caps%2C248&sr=8-1-spons&psc=1") 

# extract camera price on webpage
price <- camera %>%
          html_node("#priceblock_ourprice") %>% # position of price information
          html_text() %>% # convert to text
          readr::parse_number(.) # extract number from text