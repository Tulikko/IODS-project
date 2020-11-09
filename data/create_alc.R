# Uine Kailamäki 09/11/2020 file for the IODS course

# Data source: UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/dataset)
# P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance.

# Accessing library
library(dplyr)

# Defining sources for paper and data + where to download them
paper <- "http://www3.dsi.uminho.pt/pcortez/student.pdf"
source <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip"
dest <- "~/R/IODS-project/data/student.zip"

# Loading data from the web and unzip it
setwd("~/IODS-project")
download.file(source,dest)
unzip(dest,exdir="~/R/IODS-project/data/student")

# Downloading paper in which data were originally used
download.file(paper,"~/IODS-project/data/student/student.pdf")

# Reading datasets to memory
por <- read.table("~/R/IODS-project/data/student/student-por.csv", sep = ";", header=TRUE)
math <- read.table("~/R/IODS-project/data/student/student-mat.csv", sep = ";", header=TRUE)

# Exploring dimensions and structure

# por: [1] 649  33
dim(por)
str(por)
# math: [1] 395  33
dim(math)
str(math)

# Column names of both data: 33 identical column names
colnames(math)
colnames(por)


# From Reijo Sund's example: joining the datasets succesfully

# Define own id for both datasets
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
#   NOTE! There are 370 students that belong to both datasets
#         Original joining/merging example is erroneous!
pormath <- por_id %>% 
  bind_rows(math_id) %>%
 
   # Aggregate data (more joining variables than in the example)  
  group_by(.dots=join_cols) %>%  
 
   # Calculating required variables from two obs  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     #  Rounded mean for numerical
    paid=first(paid),                   #    and first for chars
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  
  # Remove lines that do not have exactly one obs from both datasets
  #   There must be exactly 2 observations found in order to joining be succesful
  #   In addition, 2 obs to be joined must be 1 from por and 1 from math
  #     (id:s differ more than max within one dataset (649 here))

  filter(n==2, id.m-id.p>650) %>%  
  
  # Join original free fields, because rounded means or first values may not be relevant
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  
  # Calculate other required variables  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

# Save created data to folder 'data' as an Excel worksheet
library(openxlsx)
write.xlsx(pormath,file="~/R/IODS-project/data/pormath.xlsx")

# End of Reijo Sund's example


pormath <- read.xlsx("pormath.xlsx")

colnames(pormath)

# NEED TO REMOVE "DOUBLES" NEXT