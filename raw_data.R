#install.packages("stringr")
#install.packages("tidyr")
#install.packages("hms")
#install.packages('corrplot')
library(stringr)
library(tidyr)
library(hms)
library(corrplot)
library(ggplot2)

#
raw_data <- read.csv("../Pecan_70_Houses_2017.csv", header = TRUE, sep = ",")
#
str(raw_data)

#
unique(raw_data$dataid)
#
raw_data$dataid <- str_remove(raw_data$dataid, "ï»¿")
#
unique(raw_data$dataid)
#
which(raw_data$dataid == "")            #8808547
#
raw_data$dataid[c(8808546, 8808548)]
#
dataid_levels <- unique(raw_data$dataid)
i=0
for(i in dataid_levels){
  print(length(which(raw_data$dataid == i)))
  i = dataid_levels["i+1"]
}

#
raw_data <- raw_data[-which(raw_data$dataid == ""), ]

#
unique(raw_data$dataid)
length(unique(raw_data$dataid))         #
raw_data$dataid <- as.integer(raw_data$dataid)

length(unique(raw_data$dataid[which(raw_data$car1 != 0)]))

length(unique(raw_data$dataid[which(raw_data$gen != 0)]))

raw_data[is.na(raw_data)] <- 0

class(raw_data$localminute)
library(tidyr)
raw_data = separate(raw_data,localminute,into=c("date","time"),sep=" ") 
tail(raw_data)

raw_data$date = as.character(raw_data$date)
a <- as.Date(raw_data$date,format="%Y-%m-%d") # Produces NA when format is not "%Y-%m-%d"
b <- as.Date(raw_data$date,format="%m/%d/%Y") # Produces NA when format is not "%m/%d/%Y"
a[is.na(a)] <- b[!is.na(b)] # Combine both while keeping their ranks
raw_data$date <- a # Put it back in your dataframe
class(raw_data$date)
head(raw_data$date)

#
time <- raw_data$time
time = as.character(time)
time = substr(time,1,5)
time = paste(time,"00", sep=":")

#
raw_data$time <- as_hms(time)
class(raw_data$time)
head(raw_data$time)

#
clean_data <- raw_data

#
write.csv(clean_data,file='../clean_data.csv')


head(clean_data$time)


colnames(clean_data)

c <-subset(clean_data, select = c(car1, gen, grid, use))
correlation <- cor(c)
corrplot(correlation, method = "number")


x <- subset(clean_data, car1 != 0 & gen != 0, select = c(gen, car1))
head(x)
summary(x)
str(x)
c <- cor(x)
corrplot(c, method = "number")



jpeg(filename = "car1_gen_cor.jpeg")
ggplot(x, aes(gen, car1))+
  geom_smooth(method = "lm")
dev.off()

jpeg(filename = "car1_clean_boxplot.jpeg")
boxplot(clean_data$car1, ylab = "Electric Vehicle eGauge (car1)", main = "Boxplot of Electric Vehicle eGauge")
dev.off()

jpeg(filename = "gen_clean_boxplot.jpeg")
boxplot(clean_data$gen, ylab = "Solar Generated eGauge (gen)", main = "Boxplot of Solar generated eGauge")
dev.off()

clean_data <- clean_data[-which(clean_data$car1 == max(clean_data$car1)), ]
summary(clean_data$car1)

clean_data <- clean_data[-which(clean_data$gen == max(clean_data$gen)), ]
summary(clean_data$gen)


y <- subset(clean_data, car1 != 0 | gen != 0, select = c(gen, car1))
summary(y)
jpeg(filename = "car1_gen_cor2.jpeg")
ggplot(y, aes(gen, car1))+
  geom_smooth(method = "lm")
dev.off()

d <- cor(x)
corrplot(d, method = "number")
