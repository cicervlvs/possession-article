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

# Making a map of our filled in languages
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

#Getting all languages in wals.100

wals100 <- read.delim("languoid.tab",
                      fileEncoding = "UTF-8")%>%
          filter(.$sample.100 == "True")


#Which are in the ideal sample?

prop.table(table(dbaseOwn$sample.200))
prop.table(table(dbaseOwn$sample.100))

#Export table of our languages and of the wals.100

write.table(wals100, "wals100.tab", sep = "\t")
write.table(dbaseOwn, "dbaseOwn.tab", sep = "\t")

#Take sample that was sent by Olga and add proportionally
#Take big WALS sample (original) and reduce it proportionally

dbasePropFam <- prop.table(table(dbaseBasic$family))

TabdbaseBasic <- table(dbaseBasic$family) %>%
  as.data.frame() %>%
  rename(family = Var1) %>%
  arrange(desc(Freq))
  
TabdbaseOwn <- table(dbaseOwn$family) %>%
  as.data.frame() %>%
  rename(family = Var1) %>%
  arrange(desc(Freq))

#TabdbaseComp <- TabdbaseBasic %>%
#                inner_join(TabdbaseOwn, by = as.character(.$family))

#Take sample 100 from wals and add proportionally

dbaseBasic100 <- dbaseBasic %>% filter(.$sample.100 == "TRUE")
dbaseOwn100 <- dbaseOwn %>% filter(.$sample.100 == "TRUE")
