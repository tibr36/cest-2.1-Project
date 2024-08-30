#Plotting OA & Oglu SOS with N2, cest-2.1, and tbh-1

#4mM Figure


library(tidyverse)
library(ggplot2)
library(ggtext)
library(dplyr)
library(ggbeeswarm)

theme_set(theme_classic())
files <- fs::dir_ls(recurse = TRUE, glob = "data/allsosdata.csv")
merged_data <- files %>% purrr::map_df(., readr::read_csv, .id = "filename")


plotColors <- source(file = 'parameters/plotColors.R')


# Filter data to specific date and conditions
filter_date <- c( "2024-08-30" )
filtered_data <- merged_data %>%
  filter(Date %in% filter_date,
         Condition %in% c("OA", "oglu", "control"),
         Method %in% c("control", "T"),
         Concentration %in% c("40uM", "control"),
         Genotype %in% c("N2", "cest-2.1", "tbh-1")) %>%
  mutate(Genotype = fct_relevel(Genotype, "N2", "cest-2.1", "tbh-1"))


# Specific Genotype Order
#filtered_data$Genotype <- factor(filtered_data$Genotype, levels = c("N2", "cest-2.1", "tbh-1"))


OATA<-ggplot(filtered_data, aes(x = Condition, y = Response.time)) +
  stat_summary(geom = "bar", aes(fill = Genotype, alpha = Condition),width = 0.45, fun = "mean") +
  labs(fill = "Genotype") +
  ggbeeswarm::geom_quasirandom(alpha = 0.5, width=0.2) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  #labs(title = "OA SOS with N2, cest-2.1, and tbh-1 for 30% octanol avoidance") +
  facet_grid(~Genotype) +
  scale_x_discrete(labels = c("control", "OA", "oglu")) +
  scale_y_continuous(expand = c(0, 0)) +
  geom_text(aes(x = 1, y = 20, label = "Stretch it"), vjust = -1) +
  #scale_fill_manual(values = c("#999999", "#E69F00", "#D55E00")) +
  scale_fill_manual(values = plotColors$value) +
  scale_color_manual(values = plotColors$value) +
  scale_alpha_manual(values = c("control" = 1, "OA" = 0.55, "oglu" = 0.15)) + 
  labs(y = "Time(sec)")

# Save the plot as a PDF file
pdf(file = "/Users/tiabrown/Documents/git/cest-2.1-Project/figures/40uMOAOglu1day.pdf", width = 8, height = 6)

# Print graph
print(OATA)

# Step 3: Close the graphics device to save the file
dev.off()
