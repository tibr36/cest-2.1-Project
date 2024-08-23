library(tidyverse)
library(patchwork)
library(ggbeeswarm)
library(kableExtra)
library(magrittr)
library(viridis)
theme_set(theme_classic())
library("rstudioapi")  
setwd(dirname(getActiveDocumentContext()$path)) 

oct_avoid <- read_csv("./data/octanol_30pct_avoidance_ALLDATA.csv")

oct_avoid %>%
  group_by(date, genotype) %>%
  tally()

oct_avoid %>%
  filter(#experimenter == "TB"
    date == "2022-04-05") %>%
  mutate(genotype = fct_relevel(genotype, "N2")) %>%
  ggplot(aes(x = genotype, y = response.time, fill = genotype)) +
  stat_summary(geom = "bar", fun = "mean", width = 0.5) +
  # ggbeeswarm::geom_quasirandom(aes(group = genotype),
  #                              width = .1,
  #                              alpha = 0.3,
  #                              dodge.width = .75) +
  stat_summary(aes(),
               geom = "errorbar", 
               fun.data = "mean_se", 
               width = 0.1, 
               position = position_dodge(width = 1.6)) +
  scale_fill_manual(values = c("grey", "darkorchid4", "darkorchid1")) +
  labs(title = "",
       y = "response time (s)") +
  guides(fill = "none") #+
  facet_wrap(.~date+ experimenter)

library(rstanarm)
ncores = options(mc.cores = parallel::detectCores())
mod <- oct_avoid %>%
  filter(#experimenter == "TB",
    date == "2022-04-05") %>%
  mutate(genotype = fct_relevel(genotype, "N2")) %>%
  # lme4::lmer(data = ., 
  #             response.time ~ genotype + (1|date)) %>%
  rstanarm::stan_lmer(data = .,
                      formula = response.time ~ genotype + (1|experimenter)) #%>%
  mod %>% emmeans::ref_grid() %>%
  emmeans::contrast(method = "pairwise")
  
  oct_avoid %>%
    filter(#experimenter == "TB",
      date == "2022-04-05") %>%
    lm(data = ., response.time ~ genotype) %>%
    emmeans::ref_grid() %>%
    emmeans::contrast(method = "pairwise")
