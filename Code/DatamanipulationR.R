
library(ggplot2)
library(ggthemes)
library(viridis)
library(shiny)
library(ggplot2)
library(ggthemes)
library(plotly)
library(ggrepel)
library(tidyverse)
library(shinythemes)
library(corrplot)
library(ExPanDaR)


##Wheat data
wheat <- read.csv("D:/ERS/data/milkdata.csv")
dim()
wheatd = wheat[ ,-c(1,2,3,5,7,8)]
#Economic variables Data
#wheatd = wheat
gdp0 <- read.csv('D:/ERS/data/gdp1948-1977.csv')
gdp1 <- read.csv("D:/ERS/Trade Paper (ERS)/data/Cube#2 Values Ctry-Ctry-Time_1978_1992.csv")
gdp2 <- read.csv("D:/ERS/Trade Paper (ERS)/data/Cube#2 Values Ctry-Ctry-Time_1993_2004.csv")
gdp3 <- read.csv("D:/ERS/Trade Paper (ERS)/data/Cube#2 Values Ctry-Ctry-Time_2005_2016.csv")

gdp = rbind(gdp0,gdp1,gdp2,gdp3)
rm(gdp0,gdp1,gdp2,gdp3)
gc()

#Renaming reporter name in wheat to country_d
colnames(wheatd)[1] <- "country_d"
colnames(wheatd)[2] = "country_o"

#preparing wheat data 
options(scipen = 99)
wheat = gather(wheatd,year,value,-country_o,-country_d)
wheat$year = substr(wheat$year,2,5)
wheat$year = as.integer(wheat$year)

#Joining both wheat and econmic var based on "country_o","country_d","year"
wheat_gdp <- wheat %>%
  inner_join(gdp, by = c("country_o","country_d","year")) 
wheat_gdp[is.na(wheat_gdp)] = 0

write.csv(wheat_gdp,"milktrade.csv")

