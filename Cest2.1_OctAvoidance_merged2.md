---
title: "Cest_2.1_OctAvoid_merge"
author: "Tia"
date: "8/13/2021"
output: 
  html_document: 
    keep_md: yes
---
Analysis of the 30% octanol avoidance phenotypes of cest-2.1

```{r}
library(tidyverse)

oct_avoid <- read_csv("octanol_avoidance_merged.csv")
```

```{r}
oct_avoid %>% glimpse()
```

Plotted by Genotype
```{r}
oct_avoid %>%
  ggplot(aes(x = genotype, y = response.time)) +
  geom_boxplot(aes(fill = genotype)) +
  geom_point() +
  labs(title = "plot with colors") +
  scale_fill_manual(values = c("green", "grey"))
```

```{r}
Plotted by Experimenter
oct_avoid %>%
  ggplot(aes(x = experimenter, y = response.time)) +
  geom_boxplot(aes(fill = genotype)) +
  geom_point() +
  labs(title = "plot with colors") +
  scale_fill_manual(values = c("blue", "grey"))
```




