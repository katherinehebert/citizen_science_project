library(exif)
library(rinat)

file <- system.file("/home/eliane/Documents/Cours/ecole_ete_bios2/inat_test.jpg", package="exif")
file_metadata <- read_exif(file)

# Scraping tests

library(rvest)

#login to inaturalist
url <- "https://www.inaturalist.org/login" # url of the login page
session <- html_session(url) # simulate a session in a htlm browser
form <- html_form(read_html(url))[[1]] # parse forms in the page
form <- set_values(form,
                          'user[email]' = "eliane.duche@gmail.com",
                          'user[password]' = "cambriovoleuse",
                          'user[remember_me]' = 1) # Set values to complete the form (email and password)
session <- submit_form(session, form)
session <- jump_to(session, "https://www.inaturalist.org/photos/37527142")

# eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxNzEyMzE2LCJleHAiOjE1NTY5MzA0Mjh9.1f7lhWU6NmDt7DdZOglU1iLUViqZj0ag4ojOSln4FtXpvCEAUMjXkNx8gpYiACu0nEzYziwylwxffDoqCJMZvQ

headers = c("inaturalist-api-token" = "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxNzEyMzE2LCJleHAiOjE1NTY5MzA0Mjh9.1f7lhWU6NmDt7DdZOglU1iLUViqZj0ag4ojOSln4FtXpvCEAUMjXkNx8gpYiACu0nEzYziwylwxffDoqCJMZvQ")

httr::GET("https://www.inaturalist.org/photos/37745680", httr::add_headers(.headers = headers)) %>%
  read_html() %>%
  html_node("td table") %>% 
  html_text()

test <- session %>%
  read_html() %>%
  html_node("table table") %>% 
  html_text()

# une fois connectée, utiliser jump to to get the right url

url1 <- jump_to(session, "z")
#url2 <- jump_to(session, "https://www.inaturalist.org/photos/10790036")
#url1 <- jump_to(session, "view-source:https://www.inaturalist.org/photos/10790036")




#one_page <-  read_html("https://www.inaturalist.org/photos/37527142") 
one_page_signin <-  read_html(url1)
one_page_signin2 <- read_html(url2)

library(RCurl)
library(XML)

test <- (one_page_signin)

test <- one_page_signin %>%  
  html_node("table table") %>% 
  html_text()

write.table(test, file= "test.txt")

  html_table(one_page_signin, fill = TRUE)
