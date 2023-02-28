# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)



# Data Import and Cleaning
week7_tbl = read_csv("../data/week3.csv", show_col_types  = FALSE) %>%  # Using a single series of pipes or a single pipe?
  mutate(timeStart = ymd_hms(timeStart),
         condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")),
         gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>% 
  filter(q6 != 1) %>% # Need to figure out a way to do it in "one single pipe"
  select(-q6) %>% 
  mutate(timeSpent = difftime(week7_tbl$timeEnd,week7_tbl$timeStart))





# Visualization