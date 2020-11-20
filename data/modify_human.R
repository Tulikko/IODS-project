# Uine Kailamäki 20/11/2020 file for the IODS course

# Data source #1: Human Development Index (HDI) by United Nations Development Programme
# Data source #2: Gender Inequality Index (GII) by United Nations Development Programme
# Technical notes: hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# Libraries & working directory
library(stringr); library(tidyr)
setwd("~/R/IODS-project/data/")

# Reading the previously wrangled txt file
h1 <- read.table("~/R/IODS-project/data/human1.txt")

# Exploring the data
colnames(h1)
dim(h1)
str(h1)

# The data consists of 195 observations with following  19 variables:
#[1] "HDI_rank"         (int) Human Development Index rank
#[2] "Country"          (chr) Name of the country
#[3] "HDI"              (num) Human Development Index
#[4] "Life"             (num) Life expectancy at birth
#[5] "Edu"              (num) Expected years of schooling
#[6] "Edu_mean"         (num) Mean years of schooling       
#[7] "GNI"              (chr) Gross National Income per capita
#[8] "GNI.HDI"          (int) GNI minus HDI rank
#[9] "GII_rank"         (int) Gender Inequality Index rank
#[10] "GII"             (num) Gender Inequality Index
#[11] "Maternal_mort"   (int) Maternal mortality ratio
#[12] "Adol_birth"      (num) Adolescent birth rate
#[13] "Representation"  (num) Percent of representation in parliament
#[14] "Edu_F"           (num) Female population with at least secondary education
#[15] "Edu_M"           (num) Male population with at least secondary education   
#[16] "Labour_F"        (num) Female labour force participation rate
#[17] "Labour_M"        (num) Male labour force participation rate
#[18] "Edu_ratio"       (num) Edu_F / Edu_M ratio
#[19] "Labour_ratio"    (num) Labour_F / Labour_M ratio

# Mutating GNI to numeric, + checking that the class is now numeric
GNI_n <- str_replace(h1$GNI, pattern=",", replace ="") %>% as.numeric()
h1 <- mutate(h1, "GNI" = GNI_n)

class(GNI)

# Excluding unnecessary variables, creating new dataset "human" with selected data
keep <- c("Country", "Edu_ratio", "Labour_ratio", "Edu", "Life", "GNI", "Maternal_mort", "Adol_birth", "Representation")
human <- dplyr::select(h1, one_of(keep))

str(human)

# Filtering out rows with NA values (= complete.cases(human) needs to be fullfilled)
human <- filter(human, complete.cases(human) == TRUE)

# Removing the observations that relate to regions, not countries
# Last 10 observations reveals that the last country in the list is Niger (#188), rest are larger areas
tail(human, 10)
# Choosing everything except the last 7 observations:
last <- nrow(human) - 7
human <- human[1:last, ]

# Countries as rownames + checking what is the result
rownames(human) <- human$Country
rownames(human)

# Removing the "Country" variable
human <- dplyr::select(human, -Country)

# Dimensions: [1] 155   8
dim(human)

# Write table:
write.table(human, file = "human.txt", sep="\t", row.names=TRUE)