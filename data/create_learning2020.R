# Uine Kailamäki 04/11/2020 file for the IODS course

#library
library(dplyr)

# import data from web source, separator tab (\t), includes header
lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# read data
lrn14

# dimensions of data: [1] 183  60
dim(lrn14)

# structure of data: 'data.frame':	183 obs. of  60 variables + table
str(lrn14)

# selecting questions related to deep, surface and strategic learning
deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
stra_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surf_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

# selecting vectors, producing averages to new columns "deep", "stra" and "surf"
deep_c <- select(lrn14, one_of(deep_q))
lrn14$deep <- rowMeans(deep_c)

stra_c <- select(lrn14, one_of(stra_q))
lrn14$stra <- rowMeans(stra_c)

surf_c <- select(lrn14, one_of(surf_q))
lrn14$surf <- rowMeans(surf_c)

# creating column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# selecting which columns to keep
keep_c <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# Creating the analysis dataset with chosen columns
learning2020 <- select(lrn14, one_of(keep_c))

# Changing the name of the second column "Age" to "age"
colnames(learning2020)[2] <- "age"

# Select rows where points is greater than zero
learning2020 <- filter(learning2020, Points > 0)

# Checking if everything is as it should. Looks like it!
str(learning2020)

# Saving the analysis dataset to csv file and txt file
write.csv(learning2020, "learning2020.csv")
write.table(learning2020, "learning2020.txt")

# Checking the csv
read.csv("learning2020.csv")
str(read.csv("learning2020.csv"))
head(read.csv("learning2020.csv"))

# Checking the txt file
read.table("learning2020.txt")
str(read.table("learning2020.txt"))
head(read.table("learning2020.txt"))


