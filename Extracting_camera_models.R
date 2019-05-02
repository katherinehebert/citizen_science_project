library(exif)
library(rinat)

get_inat_obs()
get_inat_obs_id()
test <- get_inat_obs_user("ccbelknap")
get_inat_user_stats(uid = "ccbelknap")

file <- system.file("/home/eliane/Documents/Cours/ecole_ete_bios2/inat_test.jpg", package="exif")
file_metadata <- read_exif(file)

# Scraping tests

library(rvest)

#login to inaturalist
url <- "https://www.inaturalist.org/login" # url of the login page

session <- html_session(url) # simulate a session in a htlm browser

form <- html_form(read_html(url))[[1]] # parse forms in the page

#form <- jump_to(session, https://www.inaturalist.org/login)

filled_form <- set_values(form,
                          'user[email]' = "eliane.duche@gmail.com",
                          'user[password]' = "cambriovoleuse") # Set values to complete the form (email and password)

submit_form(session, filled_form)

# une fois connectée, utiliser jump to to get the right url

url1 <- jump_to(session, "https://www.inaturalist.org/photos/37527142")
url1 <- jump_to(session, "view-source:https://www.inaturalist.org/photos/10790036")




#one_page <-  read_html("https://www.inaturalist.org/photos/37527142") 
one_page_signin <-  read_html(url1)



one_page %>%  
  html_node("table") %>% 
  html_text()


  html_table(one_page, fill = TRUE)
