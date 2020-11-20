# Uine Kailamäki 20/11/2020 file for the IODS course

# Access libraries, set working directory
library(dplyr); library(tidyr)
setwd("~/R/IODS-project/data/")

# Read & explore the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

names(BPRS)
str(BPRS)
summary(BPRS)

names(RATS)
str(RATS)
summary(RATS)
