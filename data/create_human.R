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

