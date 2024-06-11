---
Date: "09/14/2022"
Title:#100% octanol with N2 and cest-2.1 on Providencia SOS
Author: TB
---

```{r}

library(tidyverse)
library(ggplot2)
theme_set(theme_classic())
####### select a file in the data folder ####
files <- fs::dir_ls(path = "Tia_Jub39/", recurse = TRUE, glob = "*prelim_SOS.csv")
#data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename"). only for a list of files
data <- readr::read_csv(files)

####### anova ####
lm(data = data, formula = Response.time ~ Genotype*Condition) %>%
  summary()

###### plot (9/14 Experiment) #####
  data%>%
  ggplot(aes(x = Condition, y = Response.time)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.40) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  labs(title = "100% octanol avoidance with N2 and cest-2.1 on OP50 vs Providencia") +
  facet_grid(~Genotype) +
  scale_x_discrete(labels = c("OP50","JUb39")) +
  scale_y_continuous(expand = c(0,0)) +
  geom_text(aes(x=1, y=12, label="Stretch it"), vjust=-1) +
  scale_fill_manual(values = c("blue","green")) +
  scale_color_manual(values = c("blue","green"))

```
