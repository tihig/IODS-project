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
new_hd <- c("Rank", "Country", "HDI", "eYearsEdu", "expectedEDU", "meanEDU" , "GNI", "GNImHDI" )
new_gii <- c("Rank", "Country", "GII", "materMort", "adBirth", "reprParl", "secEdF", "secEdM", "labourF", "labourM")

colnames(hd) <-new_hd 
colnames(gii) <-new_gii  
colnames(hd)
colnames(gii)


library(dplyr); library(ggplot2)

gii <- mutate(gii, eduFM = (secEdF / secEdM))
gii <- mutate(gii, labourFM = (labourF / labourM))


?inner_join

human <- inner_join(hd, gii, by = c("Country"), suffix = c(".hd", ".gii"))
colnames(human)
dim(human)
?write.csv

write.csv(human, file="human.csv", row.names= FALSE)
