library(data.table)
library(tidyverse)
library(SportsAnalytics)
library(stringr)
library(magick)
library(shinydashboard)
library(plotly)

players_list_since1950 <- fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv", data.table = FALSE)
players_list_since1950 <- players_list_since1950 %>% select(-V1)

## Profile Picture 
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


####----------------
players_season_stats <- fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
players_season_stats <- players_season_stats %>% select(-V1)

players_season_stats <- players_season_stats %>% 
  select(-contains("WS"), -contains("STL%"), -contains("RB%"),-blanl,
         -contains("BPM"), -contains("eFG%"), -contains("AST%"), -contains("BLK%"), 
         -contains("TOV%"), -contains("USG%"), -blank2, -contains("TS%"), 
         -contains("3PAr"), -VORP, -GS)

players_season_stats <- as.data.frame(players_season_stats)
career_summary_stats <- 
  players_season_stats %>% 
  group_by(Player) %>% 
  mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G)) %>% 
  select(Player, PPG:SPG) %>% 
  distinct(Player, .keep_all = TRUE)
career_summary_stats <- as.data.frame(career_summary_stats)

#####----------PLOT------------
stats_advanced <- players_season_stats %>% 
  mutate(PPG = PTS/G, RPG = TRB/G, APG = AST/G, SPG = STL/G)

#####----------Cumulative stats
career_cumulative_stats <- 
  players_season_stats %>% 
  group_by(Player) %>% 
  mutate(Career_PTS = cumsum(PTS), Career_TRB = cumsum(TRB), 
         Career_AST = cumsum(AST), Career_STL = cumsum(STL), 
         Career_BLK = cumsum(BLK))

career_cumulative_stats <- 
  career_cumulative_stats %>% 
  select(Year, Player, TRB:Career_BLK)

####------------nth

career_cumulative_stats_nth <- career_cumulative_stats %>% 
  group_by(Player) %>% 
  mutate(nth = Year - min(Year) + 1)

