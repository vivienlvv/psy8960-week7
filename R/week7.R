# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)
library(ggplot2)

# Data Import and Cleaning
week7_tbl = read_csv("../data/week3.csv", show_col_types  = FALSE) %>%  # Using a single series of pipes or a single pipe?
  mutate(timeStart = ymd_hms(timeStart),
         condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")),
         gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>% 
  filter(q6 == 1) %>% # I think the instructions meant keep people who responded to "1"
  select(-q6) %>% # Need to figure out a way to do it in "one single pipe"
  mutate(timeSpent = difftime(timeEnd,timeStart))





# Visualization- Need to add in ggsave() pipe
week7_tbl %>% select(starts_with("q")) %>% 
  ggpairs(aes(position = "jitter"))  
  
# Figure 1 
week7_tbl %>% ggplot(aes(x = timeStart, y = q1)) + 
  geom_point() + 
  labs(x = "Date of Experiment", y = "Q1 Score") 


# Figure 2 
week7_tbl %>% ggplot(aes(x = q1, y = q2, color = gender)) +
  geom_point(position = "jitter") + 
  labs(color = "Participant Gender")

# Figure 3 
week7_tbl %>% ggplot(aes(x = q1, y = q2)) + 
  geom_point(position = "jitter") + 
  facet_grid(cols = vars(gender)) + 
  labs(x = "Score on Q1", y = "Score on Q2")


# Figure 4 
week7_tbl %>% ggplot(aes(x = gender, y = timeSpent)) + 
  geom_boxplot() + 
  labs(x = "Gender", y = "Time Elapsed (mins)")


# Figure 5 
week7_tbl %>% ggplot(aes(x = q5, y = q7, color = condition, fill = condition)) + 
  geom_point(position = "jitter") + 
  geom_smooth(method = "lm", se = FALSE) + 
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition", fill = "Experimental Condition") + 
  theme(legend.position ="bottom",
        legend.background = element_rect(color = "#DEDEDE", fill = "#DEDEDE"))


