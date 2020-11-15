# Uine Kailamäki 15/11/2020 file for the IODS course

# Data source #1: Human Development Index (HDI) by United Nations Development Programme
# Data source #2: Gender Inequality Index (GII) by United Nations Development Programme
# Technical notes: hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# Accessing libraries
library(dplyr); library(ggplot2)

# Setting working directory
setwd("~/R/IODS-project/data/")

# Reading “Human development” and “Gender inequality” datas
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Exploring dimensions and structure

dim(hd)
str(hd)
glimpse(hd)

# hd: 195 rows, 8 columns with following column names:
# [1] "HDI.Rank"                               "Country"                               
# [3] "Human.Development.Index..HDI."          "Life.Expectancy.at.Birth"              
# [5] "Expected.Years.of.Education"            "Mean.Years.of.Education"               
# [7] "Gross.National.Income..GNI..per.Capita" "GNI.per.Capita.Rank.Minus.HDI.Rank"

dim(gii)
str(gii)
glimpse(gii)

# gii: 195 rows, 10 columns with following column names:
# [1] "GII.Rank"                                      "Country"                                     
# [3] "Gender.Inequality.Index..GII."                 "Maternal.Mortality.Ratio"                    
# [5] "Adolescent.Birth.Rate"                         "Percent.Representation.in.Parliament"        
# [7] "Population.with.Secondary.Education..Female."  "Population.with.Secondary.Education..Male."  
# [9] "Labour.Force.Participation.Rate..Female."      "Labour.Force.Participation.Rate..Male."  

# Creating summaries of the variables:
summary(hd)
summary(gii)

# Changing column names to shorter ones
colnames(hd)
colnames(hd)[1] <- "HDI_rank"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life"
colnames(hd)[5] <- "Edu"
colnames(hd)[6] <- "Edu_mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI-HDI"

colnames(gii)
colnames(hd)[1] <- "GII_rank"
colnames(hd)[3] <- "GII"
colnames(hd)[4] <- "Maternal_mort"
colnames(hd)[5] <- ""
colnames(hd)[6] <- ""
colnames(hd)[7] <- ""
colnames(hd)[8] <- ""
colnames(hd)[9] <- ""
colnames(hd)[10] <- ""