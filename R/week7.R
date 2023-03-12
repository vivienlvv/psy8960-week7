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
  mutate(timeSpent = as.numeric(timeEnd - timeStart))





# Visualization- Still need to follow line instruction
(week7_tbl %>% select(starts_with("q")) %>% 
  ggpairs()) %>% 
  ggsave(filename = "../figs/fig0.png", dpi = 300, width = 10, height = 8, unit = "in")

(week7_tbl %>% ggplot(aes(x = timeStart, y = q1)) + # Figure 1 
  geom_point()  + 
  labs(x = "Date of Experiment", y = "Q1 Score") + 
  theme(axis.title = element_text(face = "bold"))) %>%
  ggsave(filename = "../figs/fig1.png", dpi = 300, width = 10, height = 6, unit = "in")

(week7_tbl %>% ggplot(aes(x = q1, y = q2, color = gender)) + # Figure 2 
  geom_point(position = "jitter") + 
  labs(color = "Participant Gender") + 
  theme(axis.title =  element_text(face = "bold"), legend.text = element_text(face = "bold"), legend.title = element_text(face = "bold"))) %>% 
 ggsave(filename = "../figs/fig2.png", dpi = 300, width = 10, height = 5, unit = "in")

(week7_tbl %>% ggplot(aes(x = q1, y = q2)) + # Figure 3 
  geom_point(position = "jitter") + 
  facet_grid(cols = vars(gender), scales = "free") + 
  labs(x = "Score on Q1", y = "Score on Q2") + 
  theme(axis.title = element_text(face = "bold"))) %>% 
  ggsave(filename = "../figs/fig3.png", dpi = 300, width = 8, height = 5, unit = "in")

(week7_tbl %>% ggplot(aes(x = gender, y = timeSpent)) + # Figure 4 
  geom_boxplot() + 
  labs(x = "Gender", y = "Time Elapsed (mins)") + 
  theme(axis.title = element_text(face = "bold"))) %>% 
  ggsave(filename = "../figs/fig4.png", dpi = 300, width = 10, height = 5, unit = "in")

(week7_tbl %>% ggplot(aes(x = q5, y = q7, color = condition, fill = condition)) + # Figure 5 
  geom_point(position = "jitter") + 
  geom_smooth(method = "lm", se = FALSE) + 
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition", fill = "Experimental Condition") + 
  theme(legend.position ="bottom",
        legend.background = element_rect(color = "#DEDEDE", fill = "#DEDEDE"),
        axis.title = element_text(face = "bold"), legend.title = element_text(face = "bold"), legend.text = element_text(face = "bold"))) %>% 
  ggsave(filename = "../figs/fig5.png", dpi = 300, width = 7, height = 5, unit = "in")


