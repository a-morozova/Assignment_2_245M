rm(list=ls()) # clear the environment
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
#-------Import necessary packages here-------------------#
# Note: Using other packages than the ones listed below can break the autograder
library(tidyverse) # importing a package
#------ Uploading PERMID --------------------------------#
PERMID <- "7214760" #Type your PERMID within the quotation marks
PERMID <- as.numeric(gsub("\\D", "", PERMID)) #Don't touch
set.seed(PERMID) #Don't touch
#------ Answer ------------------------------------------#

## 1. set up
library(tidyverse)
# load data
airbnb <- read_csv("airbnb_data.csv")
# rename "neighbourhood"
airbnb <- airbnb %>% 
  rename("neighborhood" = "neighbourhood")

## 2. piping
# a. top 20 neighborhoods 
neighborhoods <- airbnb %>% 
  count(neighborhood) %>% #count frequency
  filter(!is.na(neighborhood)) %>% #filter out NA
  arrange(desc(n)) %>% #sort frequency descending
  head(20) #top 20

# b. aribnb in top neighborhoods
airbnb_top_neighborhoods <- airbnb %>% 
  filter(neighborhood %in% neighborhoods$neighborhood)

# c. summary statistics for top neighborhoods
summary_stats_top_neighborhoods <- airbnb_top_neighborhoods %>% 
  group_by(neighborhood) %>%
  summarize(avg_square_feet=mean(square_feet, na.rm=T),
            avg_price=mean(price, na.rm=T),
            sd_price=sd(price, na.rm=T),
            max_price=max(price, na.rm=T),
            min_price=min(price, na.rm=T)) %>% 
  arrange(desc(avg_square_feet)) #sort avg_square_feet desc
#plot(summary_stats_top_neighborhoods$avg_square_feet,summary_stats_top_neighborhoods$avg_price)
# Square footage is not the only input to price.

# d. extract highest avg_square_feet
highest_avg_square_ft <- summary_stats_top_neighborhoods %>% 
  arrange(desc(avg_square_feet)) %>% #sort desc
  slice(1) %>% #1st row
  pull(avg_square_feet)

# e. extract second highest avg_price
second_avg_price <- summary_stats_top_neighborhoods %>% 
  arrange(desc(avg_price)) %>% #sort desc
  slice(2) %>% #2nd row
  pull(avg_price)