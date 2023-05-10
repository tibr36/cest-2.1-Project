Date: "09/27/2022"
100% octanol with N2 and cest-2.1 Providencia SOS
---

library(tidyverse)
library(ggplot2)
theme_set(theme_classic())
####### select a file in the data folder ####
files <- fs::dir_ls(recurse = TRUE, glob = "Tia_Jub39/2022-08-31_cest-2.1*.csv")
data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename")

####### anova ####
lm(data = data, formula = Response_Latency ~ Genotype*Condition) %>%
  summary()

###### plot #####
data %>% ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  coord_cartesian( ylim=c(0,10), expand = FALSE) +  
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue", "green"))

###### plot (with space between x axis and N2/cest-2.1) #####
  data %>% ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) + 
  coord_cartesian( ylim=c(0,10), expand = FALSE)
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green")) 
  

###### plot (Most recent experiment day) #####
  subset(data, Date== "2022-10-13")%>%
  ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% SOS with N2 and cest-2.1 on OP50 vs Providencia 10/13 TB") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green"))

######Plotting by Experimenter

data %>%
  ggplot(aes(x = Experimenter, y = Response_Latency)) +
  geom_boxplot(aes(fill = Genotype)) +
  labs(title = "Via Experiementer") +
  scale_fill_manual(values = c("blue", "grey", "blue", "red"))

data %>%
ggplot(aes(x = Experimenter, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% SOS with N2 and cest-2.1 on OP50 vs Providencia(2022-09-27)") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green", "red", "purple")) +
  scale_color_manual(values = c("blue","green", "red", "purple"))
  
###### plot (with space between x axis and N2/cest-2.1) #####
  
data %>% ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green")) +
  facet_grid(Genotype~Experimenter)
  
 subset(data, Date== "2022-10-13")%>%
  ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  coord_cartesian( ylim=c(0,10)) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green")) +
  facet_grid(Experimenter~Genotype)
  
   facet_grid(Genotype~Experimenter)
   
  data %>% ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green")) +
  facet_grid(Date~Experimenter~Genotype)

