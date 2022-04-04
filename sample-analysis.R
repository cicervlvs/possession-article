library(dplyr)

dbaseBasic <- read.delim("dbase04042022.txt",
           encoding = "UTF-8")

dbaseOwn <- dbaseBasic %>%
  filter(.$NAME != "")
