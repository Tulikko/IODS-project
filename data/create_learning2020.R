# Uine Kailamäki 04/11/2020 file for the IODS course

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

# selecting which columns to keep
keep_c <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# Creating the analysis dataset with chosen columns
learning2020 <- select(lrn14, one_of(keep_c))

# Checking if everything is as it should. I have 183 observations instead of 166 like the instruction said I should have? But 7 variables like I should, so at least that's great.
str(learning2020)
