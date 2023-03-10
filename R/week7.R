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
  filter(q6 == 1) %>% 
  select(-q6) %>% 
  mutate(timeSpent = as.numeric(timeEnd - timeStart))





# Visualization
(week7_tbl %>% select(starts_with("q")) %>% 
  ggpairs()) %>% 
  ggsave(filename = "../figs/fig0.png")
(week7_tbl %>% ggplot(aes(x = timeStart, y = q1)) +  
  geom_point()  + 
  labs(x = "Date of Experiment", y = "Q1 Score") + 
  theme(aspect.ratio = 6/10)) %>% # Doing it this way will actually create white space
  ggsave(filename = "../figs/fig1_try.png")

(week7_tbl %>% ggplot(aes(x = q1, y = q2, color = gender)) +  
  geom_point(position = "jitter") + 
  labs(color = "Participant Gender") + 
  theme(aspect.ratio = 7/10)) %>% 
 ggsave(filename = "../figs/fig2.png")
(week7_tbl %>% ggplot(aes(x = q1, y = q2)) +  
  geom_point(position = "jitter") + 
  facet_grid(cols = vars(gender), scales = "free") + # Forgot to remove "free" 
  labs(x = "Score on Q1", y = "Score on Q2") + 
  theme(aspect.ratio = 1)) %>% 
  ggsave(filename = "../figs/fig3.png")

(week7_tbl %>% ggplot(aes(x = gender, y = timeSpent)) +  
  geom_boxplot() + 
  labs(x = "Gender", y = "Time Elapsed (mins)") + 
  theme(aspect.ratio = 3/5)) %>% 
  ggsave(filename = "../figs/fig4.png")

(week7_tbl %>% ggplot(aes(x = q5, y = q7, color = condition, fill = condition)) + 
  geom_point(position = "jitter") + 
  geom_smooth(method = "lm", se = FALSE) + 
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition", fill = "Experimental Condition") + 
  theme(legend.position ="bottom",
        legend.background = element_rect(color = "#DFDFDF", fill = "#DFDFDF"),
        aspect.ratio = 3/7)) %>% 
  ggsave(filename = "../figs/fig5.png")









(week7_tbl %>% ggplot(aes(x = q1, y = q2, color = gender)) +  
    geom_point(position = "jitter") + 
    labs(color = "Participant Gender")) %>% 
  ggsave(filename = "../figs/fig2_answer.png", units = "px", width = 1920, height = 1080)



