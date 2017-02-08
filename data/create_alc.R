# tihig 7.2.2017 students alcohol consupmtion
#data source: https://archive.ics.uci.edu/ml/machine-learning-databases/00356/

mat <- read.csv("student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("student-por.csv", sep= ";", header = TRUE)

str(mat)
str(por)

dim(mat)
dim(por)

library(dplyr)


join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))


alc <- select(mat_por, one_of(join_by))


notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]


notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

write.csv(alc, "alc.csv", row.names = F)

