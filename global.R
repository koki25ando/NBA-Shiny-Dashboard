library(data.table)
library(tidyverse)
library(SportsAnalytics)
library(stringr)
library(magick)

players_list_since1950 <- fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv", data.table = FALSE)
players_list_since1950 <- players_list_since1950 %>% select(-V1)

## key setting
players_list_since1950 <- players_list_since1950 %>% 
  separate(Player, sep = " ", 
           into = c("given_name", "family_name"),
           remove = FALSE)
players_list_since1950$given_name <- str_to_lower(players_list_since1950$given_name)
players_list_since1950$family_name <- str_to_lower(players_list_since1950$family_name)
players_list_since1950$given_name_key <- players_list_since1950$given_name %>% 
  str_sub(1,2)
players_list_since1950$family_name_key <- players_list_since1950$family_name %>% 
  str_sub(1,5)

players_list_since1950 <- players_list_since1950 %>% 
  unite(family_name_key, given_name_key, sep="", col = "key")

players_list_since1950 <- players_list_since1950 %>% 
  mutate(img_url = 
           paste0("https://d2cwpp38twqe55.cloudfront.net/req/201804182/images/players/", key, "01.jpg"))




