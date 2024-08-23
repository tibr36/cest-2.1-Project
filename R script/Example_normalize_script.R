library(tidyverse)
library(readxl)
library(magrittr)
data <- read_xlsx('data/octanol_30pct_avoidance_ALLDATA.xlsx') %>%
  mutate(logTime = log(Response.time))

N2means <- data %>%
  filter(Genotype == "N2") %>%
  group_by(Date) %>%
  summarise(mean_N2 = mean(Response.time, na.rm = TRUE),
            logMeanN2 = mean(logTime))

data <- full_join(data, N2means) %>%
  mutate(relResponseTime = Response.time - mean_N2,
         relLogtime = logTime - logMeanN2)

data %>%
  ggplot(aes(colour = Genotype, x = relLogtime)) +
  geom_boxplot()

glo1_dates <- data %>%
  filter(Genotype == "glo-1") %$%
  unique(Date)

data %>%
  filter(Date %in% glo1_dates,
         Genotype %in% c("N2", "glo-1")) %>%
  ggplot(aes(colour = Genotype, x = logTime)) +
  geom_boxplot() +
  facet_grid(Date~.)
  
