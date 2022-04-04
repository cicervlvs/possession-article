library(ggplot2)
library(stringr)
library(dplyr)
library(maps)

# Importing current database (244 languages)
dbaseBasic <- read.delim("dbase04042022.txt",
           encoding = "UTF-8")

dbaseBasic$latitude <- str_replace_all(dbaseBasic$latitude, ",", ".")
dbaseBasic$longitude <- str_replace_all(dbaseBasic$longitude, ",", ".")

dbaseBasic$latitude <- as.numeric(dbaseBasic$latitude)
dbaseBasic$longitude <- as.numeric(dbaseBasic$longitude)

# Filtering out all but our languages
dbaseOwn <- dbaseBasic %>%
  filter(.$NAME != "")

world <- map_data("world")
background_map <- ggplot() +
  geom_polygon(data = world, aes(long, lat, group = group),
               fill = "white", color = "lightgrey") +
              theme(axis.text = element_blank(),
               axis.title = element_blank(),
               legend.title = element_blank())+
               labs(title = "Distribution of own sample (78 languages)")


plotted_map <- background_map +
  geom_point(data = dbaseOwn,
             aes(longitude, latitude,
             color = family))

plotted_map
