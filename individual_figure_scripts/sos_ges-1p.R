#Plotting via days with N2, cest-2.1, and MOY00022/ MOY00023--ges-1pcest-2.1 rescue

library(tidyverse)
library(ggplot2)
library(ggtext)
theme_set(theme_classic())


files <- fs::dir_ls(recurse = TRUE, glob = "data/allsosdata.csv")
merged_data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename")

plotColors <- source(file = 'parameters/plotColors.R')


# Filter Data to Date
filter_date <- c("2024-04-30", "2024-05-07", "2024-05-10")
filtered_data <- merged_data %>%
  filter(Date %in% filter_date, Genotype %in% c("N2", "cest-2.1", "TIBR1", "TIBR2"))

# Reorder Genotype 
filtered_data$Genotype <- factor(filtered_data$Genotype, levels = c("N2", "cest-2.1", "TIBR1", "TIBR2"))


plotbar <- source(file = 'parameters/plotbar.R')

print(plotbar$value) 