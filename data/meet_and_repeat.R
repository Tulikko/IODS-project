# Uine Kailamäki 20/11/2020 file for the IODS course

# Access libraries, set working directory
library(dplyr); library(tidyr)
setwd("~/R/IODS-project/data/")

# Read & explore the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

glimpse(BPRS)
summary(BPRS)
## BPRS dataset consists of 11 variables: "treatment", "subject", and "week0"-"week8" 
## It contains 40 observations, all with numerical values; "treatment" being 1 or 2,
## "subject" an ID between 1-20, "week" measurements ranging from 18 to 95.

## The data describes 40 test subjects who were assigned to two treatment groups
## and then rated on brief psychiatric rating scale (BPRS) meant to evaluate suspected
## schizophrenia. Evaluation was made before starting (week0) and on the following weeks.
## The data is in "wide" form - to convert it to "long" form, we need to rearrange
## it to variables "treatment", "subject", "week" and "BPRS" for each score.

glimpse(RATS)
summary(RATS)
## RATS consists of 13 variables: "ID", "Group", and "WD(X)", X being a number 
## It has 16 variables with numerical values, ID being a running number (1-16),
## "group" describing three classes (1, 2 or 3), and WD1-WD64 values ranging from 225 to 682.0

## The data describes how three different diets (groups 1-3) affected the body weight of rats 
## (differentiated with ID) during the following days (WD1-WD64).
## The data is in "wide" form - if we want it in "long" form for analysis, we need to differentiate
## the data to four (ID / group / time / weight) variables.


# Assign treatment & subject as factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

## Now we have 5 variables: treatment, subject, weeks, bprs and week
## Let's remove "weeks" to remove the overlap and only keep the numerical "week"
BPRSL <- subset(BPRSL, select = -c(weeks))


# Assign treatment & subject as factors
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form
RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)

# Extract the week number
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

# Remove character variable "WD" and only keep numerical "Time"
RATSL <- subset(RATSL, select = -c(WD))


# Analyzing the difference between wide and long datasets
glimpse(BPRSL)
glimpse(RATSL)

## In the wide form, these datasets treated time periods as variables with 
## information about bprs or rats' weight results. In a sense, we deconstructed
## the data to assign each individual result its own line, so that we can treat
## both the time and the corresponding result as *variables* that we can operate
## with in our following analysis.

## So, when in the original datasets we had weeks and days as variables that *included*
## data of the *results*, now we have only four variables in each dataset, and we can
## treat both the *results* and corresponding time periods as their *own* variables; 

# BPRSL:
# Rows: 360
# Columns: 4
# $ treatment <fct> 1, 1, 1,...
# $ subject   <fct> 1, 2, 3,...
# $ bprs      <int> 42, 58, 54,...
# $ week      <int> 0, 0, 0,...

# RATSL:
# Rows: 176
# Columns: 4
# $ ID     <fct> 1, 2, 3,...
# $ Group  <fct> 1, 1, 1,...
# $ Weight <int> 240, 225, 245,...
# $ Time   <int> 1, 1, 1,...

write.table(BPRSL, "bprs.txt")
write.table(RATSL, "rats.txt")