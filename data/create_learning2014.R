# tihig, 26.1.2017, this is first script of chapter 2

# http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt 

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# structure looks pretty messy, there's loads of shortnings like SU01 or Aa. 
#In the end there's some readable columns, like Age and Gender 
structure(lrn14)

#has two numbers: 183 and 60 (objects and variables)
dim(lrn14)

install.packages("GGally")
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

learning2014 <- filter(learning2014, Points > 0)

dim(learning2014)
write.csv(learning2014, file = "learning2014.csv")
read.csv("learning2014.csv")

str(learning2014)

lrn14 <- read.csv("learning2014.csv")
