library(tidyverse)
library(ggplot2)
library(ggtext)
library(dplyr)
library(ggbeeswarm)

theme_set(theme_classic())

# Load the dataset
files <- fs::dir_ls(recurse = TRUE, glob = "data/allsosdata.csv")
merged_data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename")

# Load plot colors
plotColors <- source(file = 'parameters/plotColors.R')$value

# Filter data to specific date and conditions
filter_date <- c("2024-03-02")
filtered_data <- merged_data %>%
  filter(Date %in% filter_date,
         Condition %in% c("OA", "TA", "control"),
         Method %in% c("control", "P"),
         Concentration %in% c("4mM", "control"),
         Genotype %in% c("N2", "cest-2.1", "tbh-1")) %>%
  mutate(Genotype = fct_relevel(Genotype, "N2", "cest-2.1", "tbh-1"))

# Create a combined factor for Condition and Genotype
filtered_data <- filtered_data %>%
  mutate(Condition_Genotype = paste(Condition, Genotype, sep = "_"),
         Condition_Genotype = fct_relevel(Condition_Genotype,
                                          "control_N2", "control_cest-2.1", "control_tbh-1",
                                          "OA_N2", "OA_cest-2.1", "OA_tbh-1",
                                          "TA_N2", "TA_cest-2.1", "TA_tbh-1"))

# Plotting
OATA<-ggplot(filtered_data, aes(x = Condition_Genotype, y = Response.time)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition), width = 0.45, fun = "mean") +
  geom_quasirandom(alpha = 0.5, width = 0.2) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  scale_x_discrete(labels = c("Control", "М0А"))  +
  scale_y_continuous(expand = c(0, 0)) +
  annotate("text", x = 1, y = 20, label = "Stretch it", vjust = -1) +
  scale_fill_manual(values = plotColors) +
  scale_alpha_manual(values = c("control" = 1, "OA" = 0.55, "TA" = 0.15)) + 
  labs(x = "Condition and Genotype", y = "Time (sec)", fill = "Genotype", alpha = "Condition")


# Save the plot as a PDF file
pdf(file = "/Users/tiabrown/Documents/git/cest-2.1-Project/figures/4mMOATA.pdf", width = 8, height = 6)

# Print graph
print(OATA)

# Step 3: Close the graphics device to save the file
dev.off()
