plotbargraph <- ggplot(filtered_data, aes(x = Genotype, y = Response.time)) +
  stat_summary(geom = "bar", aes(fill = Genotype), width = 0.5) +
  #geom_point(aes(fill = Genotype), color = "black", size = 1, alpha = 0.5, position = position_jitter(width = 0.2)) +
  ggbeeswarm::geom_quasirandom(alpha = 0.5, width=0.2) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = 0.2) +
  #labs(title = "OA SOS with N2, cest-2.1, and tbh-1 for 30% octanol avoidance") +
  scale_y_continuous(expand = c(0, 0)) +
  geom_text(aes(x = 1, y = 20, label = "Stretch it"), vjust = -1) +
  theme(legend.text = element_text(face = "italic")) +
  theme(axis.text = element_text(face = "italic")) +
  theme(text = element_text(size = 10)) +
  labs(y = "Time(sec)") 