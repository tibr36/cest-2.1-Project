Date: "09/14/2022"
100% octanol with N2CGC,N2EA,and N2EA Providencia SOS
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

###### plot (9/14 Experiment) #####
  subset(data, Date==
           "2022-09-14")%>%
  ggplot(aes(x = Condition, y = Response_Latency)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green"))

