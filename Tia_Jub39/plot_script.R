library(tidyverse)
theme_set(theme_classic())
####### select a file in the data folder ####
files <- fs::dir_ls(dirname(file.choose()), glob = "*.txt")
readfun <- function(x) { read_delim(x) %>%
    pivot_longer(cols = c(1:4), 
                 names_to = "Genotype", values_to = "Time")}

data <- map_df(files, readfun, .id = "path")

####### reorder variables ####
data <- data %>%
  mutate(path = basename(path)) %>%
  separate(path, into = c("date", "name"), sep = "_") %>%
  separate(genotype, into = c("Genotype", "food"), sep = c("_")) 

####### exclude 5-19 date ####
data <- data %>% filter(date != "5-19") %>%
  mutate(food = fct_relevel(food, "OP50"),
         genotype = fct_relevel(genotype, "N2"))

####### anova ####
lm(data = data, formula = Time ~ Genotype*food) %>%
  summary()

###### plot #####
  data %>% ggplot(aes(x = food, y = time)) +
  stat_summary(geom = "bar", aes(fill = genotype, alpha = food), width = 0.75) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  coord_cartesian( ylim=c(0,8), expand = FALSE) +  
  facet_grid(~genotype) +
  scale_fill_manual(values = c("grey", "green"))


###### plot #####
data %>% ggplot(aes(x = food, y = time)) +
  stat_summary(geom = "bar", aes(fill = genotype, alpha=  ), width = 0.70) +
  stat_summary(geom = "errorbar", fun.data = "mean_se", width = .2) +
  scale_y_continuous(expand = c(0,0)) +
  geom_text(aes(x=1, y=0,10, label="Stretch it"), vjust=-1) +
  facet_grid(~genotype) +
  scale_fill_manual(values = c("grey", "green"))
