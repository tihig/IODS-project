hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)


dim(hd)
dim(gii)

summary(hd)
summary(gii)

colnames(hd)

#named them with my own names

new_hd <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
new_gii <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

colnames(hd) <-new_hd 
colnames(gii) <-new_gii  
colnames(hd)
colnames(gii)


library(dplyr); library(ggplot2)

gii <- mutate(gii, Edu2.FM = (Edu2.F / Edu2.M))
gii <- mutate(gii, Labo.FM = (Labo.F / Labo.M))

colnames(gii)

human <- inner_join(hd, gii, by = c("Country"), suffix = c(".hd", ".gii"))
colnames(human)
dim(human)

write.csv(human, file="human.csv", row.names= FALSE)

# Chapter 5 begins here

colnames(human)

human <- mutate(human, as.numeric(GNI))
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

complete.cases(human)
human_ <- filter(human, complete.cases(human)== TRUE)


human$Country

last <- nrow(human_) - 7
human_ <- human_[1:last, ]

rownames(human_) <- human_$Country
human_ <- human_[ ,2:ncol(human_)]

dim(human_)
human <- human_

write.csv(human, file="human.csv", row.names= TRUE)

