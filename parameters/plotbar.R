library(ggplot2)
library(ggbeeswarm)

# Assuming `filtered_data` and `genotype_colors` are defined earlier in your script

# Create the bar graph
plotbargraph <- ggplot(filtered_data, aes(x = Genotype, y = Response.time)) +
  stat_summary(geom = "bar", aes(fill = Genotype), width = 0.45, fun = mean) +
  labs(fill = "Genotype") +
  ggbeeswarm::geom_quasirandom(alpha = 0.5, width = 0.2) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  scale_y_continuous(expand = c(0, 0)) +
  geom_text(aes(x = 1, y = 20, label = "Stretch it"), vjust = -1) +
  scale_fill_manual(values = genotype_colors) +
  scale_color_manual(values = genotype_colors) +
  scale_alpha_manual(values = c(0.5, 1)) +
  labs(y = "Time(sec)")

# Save the plot as a PDF file
pdf(file = "/Users/tiabrown/Documents/git/cest-2.1-Project/figures/tbh-1.pdf", width = 8, height = 6)

# Print graph
print(plotbargraph)

# Step 3: Close the graphics device to save the file
dev.off()


