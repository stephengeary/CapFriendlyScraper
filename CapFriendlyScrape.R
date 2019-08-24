# Thank you to the CapFriendly team! They create a great resource, and this code is 
# a strain on their servers, so don't run carelessly

baseurl <- "https://www.capfriendly.com/teams/"
team <- list("bruins","sabres","redwings","panthers","canadiens","senators",
         "lightning","mapleleafs","hurricanes","bluejackets","devils","islanders",
         "rangers","flyers","penguins","capitals","blackhawks","avalanche",
         "stars","wild","predators","blues","jets","ducks","coyotes","flames",
         "sharks","oilers","kings","canucks","goldenknights")

# baseurl + team

library(selectr)
library(xml2)
library(rvest)
library(tidyverse)

url <- paste("https://www.capfriendly.com/teams/",team,sep = "")

dfList <- lapply(url, function(i) {
  webpage <- read_html(i)
  table0 <- html_nodes(webpage, xpath = '//*[@id="team"]')
  draft <- html_table(table0, fill = T)[[1]]
})

df <- do.call(rbind, dfList)

names(df)[1]<-"Player"
names(df)[2]<-"Player2"
names(df)[3]<-"YearsRemaining"
names(df)[5]<-"Position"
names(df)[4]<-"Terms"
names(df)[6]<-"Status"
names(df)[7]<-"Age"
names(df)[8]<-"2019-20"
names(df)[9]<-"2020-21"
names(df)[10]<-"2021-22"
names(df)[11]<-"2022-23"
names(df)[12]<-"2023-24"
names(df)[13]<-"2024-25"
names(df)[14]<-"2025-26"

finaldf <- df %>% 
  filter(Position != "POS") %>%
  filter(Position != "") %>% 
  filter(Player != "Statistics") %>% 
  select(-"Player2")

hit <-  function(x){
  any(str_detect(x,"^\\$"))
}

replace_hit <- function(x){
  (unlist(lapply(str_split(x, "\\$"), '[', 2)))
}

CapHitFinal <- finaldf %>% 
  mutate_if(hit, replace_hit)



