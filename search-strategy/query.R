# filter retrieved data and import into review redcap
library(RCurl)
library(dplyr)

#details on the reference database structure below:
#https://ispmbern.github.io/covid-19/living-review/datastructure.html

# retrieve all references (CTU redcap):

references1<-read.csv(file="https://raw.githubusercontent.com/ZikaProject/COVID_references/master/current_part1.csv", stringsAsFactors=FALSE)
references2<-read.csv(file="https://raw.githubusercontent.com/ZikaProject/COVID_references/master/current_part2.csv", stringsAsFactors=FALSE)

references = bind_rows (references1,references2)

#######################
#                     # 
#   DEFINE SEARCH     #
#                     # 
#######################
#For keyword selection see protocol: https://www.crd.york.ac.uk/prospero/display_record.php?RecordID=180049

keywords = "(((*behavi*)|(*affective*)|(*adjust*)|(*mood*)|(*eating*))&(*disorder*))|(*anorexi*)|(*bulimi*)|(*binge eating*)|(*neurosis*)|(*obsess*)|(*mania*)|(*schizophren*)|(*mental health*)|(*mental well*)|(*mental ill*)|(*mentally ill*)|(*resilien*)|(*anxiety*)|(*anxious*)|(*panic*)|(*phobi*)|(*schizo*)|(*delusion*)|(*stress*)|(*impuls control*)|(*compulsive*)|(*depressi*)|(*neurotic*)|(*neurosis*)|(*somatoform*)|(*hypochondria*)|(*hysteri*)|(*paranoid*)|(*psycho*)|(*dysthymic*)|(*dementia*)|(*alzheimer*)|(*addict*)|(*drug dependen*)|(*drug abus*)|(*drug use*)|(((*substance*)|(*alcohol*)|(*drink*))&((*abuse*)|(*misuse*)|(*dependen*)|(*behavi*)|(*consum*)))|(*aggress*)|(*anger*)|(*angry*)|(*assault*)|(*hostil*)|(*bully*)|(*bullie*)|(*violen*)|(*abus*)|(*batter*)|(*tortur*)|(*mutilat*)|(*molest*)|(*murder*)|(*parricid*)|(*suicide*)"

print(keywords)

new_refs=references %>% 
  filter(grepl(keywords,paste(abstract,title), ignore.case = TRUE)) %>% # run search in title and abstract, case-indepdent
  filter(source %in% c(3,4)) # no preprints

filename=paste0(format(Sys.time(), "%Y%m%d_%H%M%S_"), "newrefs.csv")
write.csv2(file=filename,new_refs)

print(nrow(new_refs))
