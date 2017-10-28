# scraping data and save as example.csv

library(tidyverse)
library(rvest)
library(stringr)

## get dates
URL <- "https://www.uni-muenchen.de/studium/studienangebot/lehrangebote/ringvorlesung/rv_17_18/index.html"
page <- read_html(URL)
df <- html_table(page, fill=TRUE)[[1]]
df <- df %>% rename(date = X1, text = X2)

# get link
links <- page %>% html_nodes(xpath = '//*[@id="content"]/div/table[1]/tbody/tr/td/a') %>% html_attr("href")
# first element without link
links <- append(links, "index.html", after = 0)
description <- paste0("Hörsaal B 101 ", "https://www.uni-muenchen.de/studium/studienangebot/lehrangebote/ringvorlesung/rv_17_18/", links)
description <- as.data.frame(description)

# add to df
df <- cbind(df, description)

# make date
df$date <- as.Date(df$date, "%d.%m.%Y")
df$date <- gsub("-", "", as.character(df$date))

# make time
df$starttime <- "19:15"
df$starttime <- gsub(":", "", df$starttime)
df$starttime <- paste0(df$date, "T", df$starttime, "00")
df$endtime <- "20:45"
df$endtime <- gsub(":", "", df$endtime)
df$endtime <- paste0(df$date, "T", df$endtime, "00")

# address
df$location <- "Geschwister-Scholl-Platz 1, 81669 München"

# title = summary
df$summary <- str_extract(df$text, "„.*“")
df$summary <- gsub("„", "", df$summary)
df$summary <- gsub("“", "", df$summary)

# create example data
df <- df %>% select(starttime, endtime, summary, description, location)
write.table(df, "input/example_data.csv", sep = "\t", row.names = F, quote = F)
