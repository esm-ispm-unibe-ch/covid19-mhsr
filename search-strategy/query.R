# filter retrieved data and import into review redcap
library(RCurl)
library(dplyr)

#details on the reference database structure below:
#https://ispmbern.github.io/covid-19/living-review/datastructure.html

# retrieve all references (CTU redcap):

references<-read.csv(file="https://raw.githubusercontent.com/ZikaProject/COVID_references/master/current.csv", stringsAsFactors=F)

#######################
#                     # 
#   DEFINE SEARCH     #
#                     # 
#######################
#For keyword selection see protocol: https://www.crd.york.ac.uk/prospero/display_record.php?RecordID=180049

keywordlist=c( "mental"
             , "alcoho*"
             , "violen*"
             , "subst*"
             , "abuse"
             )

keywords = paste(c("(",paste(keywordlist,collapse = ")|("),")"),collapse="")

new_refs=references %>% 
  filter(grepl(keywords,paste(abstract,title), ignore.case = TRUE)) %>% # run search in title and abstract, case-indepdent
  filter(source %in% c(3,4)) # no preprints

filename=paste0(format(Sys.time(), "%Y%m%d_%H%M%S_"), "newrefs.csv")
write.csv2(file=filename,new_refs)

print(nrow(new_refs))
