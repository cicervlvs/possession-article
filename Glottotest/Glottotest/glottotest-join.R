library(glottospace)
library(dplyr)

addGlottocode <- function(db){
  
  db <- db %>%
    mutate_if(is.logical, as.character)
  
  nameColumn <- db$iso.code
  
  codeList <- list() 
  
  for (lang in nameColumn){
    
    glottoQ <-  glottosearch(search = lang,
                          columns = "isocode",
                          tolerance = 0)
    codeList[[length(codeList) + 1]] <- glottoQ$glottocode[1]
    
  }
  
  .GlobalEnv$db$penis <- as.character(codeList)
}

db <- glottoget("C:/Users/aleja/OneDrive - Universiteit Leiden/Estudis/MA Linguistics/TFM-Typo/database_proposal.xlsx")

addGlottocode(db)

db <- db %>% select(penis, everything())

dbjoin <- glottojoin(db, with = "glottobase", id = "penis")
