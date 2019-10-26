#install.packages("stringr")
#install.packages("tidyr")
#install.packages("hms")
library(stringr)
library(tidyr)
library(hms)

#
data <- read.csv("../Pecan_70_Houses_2017.csv", header = TRUE, sep = ",")
#
raw_data <- data
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
write.csv(raw_data,file='../clean_data.csv')


