library(tidyverse)
data <- read_csv('octanol_30pct_avoidance_ALLDATA.csv')

N2means <- data %>%
  filter(Genotype == "N2") %>%
  group_by(Date) %>%
  summarise(mean_N2 = median(Response.time, na.rm = TRUE))

full_join(data, N2means) %>%
  mutate(relResponseTime = Response.time - mean_N2) %>%
  ggplot(aes(colour = Genotype, x = relResponseTime)) +
  geom_density()
