#################################################
# Plotting human population growth rate
# Author: Robin Elahi
# Date: 151214
#################################################

##### LOAD PACKAGES, SOURCE DATA AND FUNCTIONS #####
# load packages
library(dplyr)
library(ggplot2)
library(tidyr)

# data from
# http://ourworldindata.org/data/population-growth-vital-statistics/world-population-growth/
dat <- read.csv("./data/Kremer_CSV_WorldPop_MillionYears.csv", skip = 1, header = TRUE)

names(dat)
# Wide to long format
datL <- gather(data = dat, key = "sourceData", value = "population_millions", 
               kremer.2:un_medium_projection) 
head(datL)

##### Plots #####
datL <- gather(data = dat, key = "sourceData", value = "population_millions", 
               kremer.2:us_census) 
names(datL)

theme_set(theme_bw(base_size = 16))

ggplot(datL, aes(year, population_millions/1000, color = sourceData)) + 
  geom_point(size = 2, alpha = 0.5) + 
  geom_smooth() +
  scale_x_continuous(limits = c(1500, 2100)) +
  xlab("Year") + ylab("Human population (billions)\n") + 
  theme(legend.position = "none") + 
  geom_vline(xintercept = c(1859, 2016), linetype = c(2, 4))
             
ggsave("./figs/popGrowth1.pdf", width = 3.5, height = 3.5)
