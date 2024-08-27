#SOS with RNAseq candidates ugt-64 & sqv-7

library(tidyverse)
library(ggplot2)
library(ggtext)
theme_set(theme_classic())


files <- fs::dir_ls(recurse = TRUE, glob = "data/allsosdata.csv")
merged_data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename")

plotColors <- source(file = 'parameters/plotColors.R')


filter_date <- c("2023-05-24", 
"2023-06-19",
"2023-06-22",
"2023-06-23",
"2023-06-26",
"2023-06-29",
"2023-09-06",
"2023-09-06",
"2023-09-06")
filtered_data <- merged_data %>%
  filter(Date %in% filter_date,
         Condition %in% c( "control"),
         Method %in% c("control"),
         Concentration %in% c("control"),
         Genotype %in% c("N2", "cest-2.1", "sqv-7", "ugt-64")) %>%
  mutate(Genotype = fct_relevel(Genotype, "N2", "cest-2.1", "tbh-1"))



filtered_data$Genotype <- factor(filtered_data$Genotype, levels = c("N2", "cest-2.1", "sqv-7", "ugt-64")) 

# Save the plot as a PDF file
pdf(file = "/Users/tiabrown/Documents/git/cest-2.1-Project/figures/ugt-64-sqv-7.pdf", width = 8, height = 6)

# Print graph
print(plotbargraph)

# Step 3: Close the graphics device to save the file
dev.off()
