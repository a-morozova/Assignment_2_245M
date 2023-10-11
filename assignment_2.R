rm(list=ls()) # clear the environment 
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
#-------Import necessary packages here-------------------#
library(tidyverse) # importing a package
#------ Uploading PERMID --------------------------------#
PERMID <- "8276602" #Type your PERMID within the quotation marks 
PERMID <- as.numeric(gsub("\\D", "", PERMID)) #Don't touch 
set.seed(PERMID) #Don't touch
#------ Answer ------------------------------------------#
 airbnb <-read_csv("airbnb_data.csv")
 airbnb <- airbnb %>% rename(neighborhood=neighbourhood)
 neighborhoods <- airbnb %>% count(neighborhood) %>% filter(!is.na(neighborhood)) %>% arrange(desc(neighborhood)) %>% head(20)
 
 airbnb_top_neighborhoods <-airbnb %>% filter(neighborhood %in% neighborhoods$neighborhood)
 
 summary_stats_top_neighborhoods <- airbnb_top_neighborhoods %>% group_by(neighborhood) %>% summarize(square_feet, price) 
 