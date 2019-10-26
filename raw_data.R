#install.packages("stringr")
library(stringr)

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

range(raw_data$air1)
class(raw_data$dataid)
raw_data$dataid <- as.integer(raw_data$dataid)

length(unique(raw_data$dataid[which(raw_data$car1 != 0)]))
which(raw_data$dataid == "7024")

length(unique(raw_data$dataid[which(raw_data$gen != 0)]))

length(which(is.na(raw_data$car1)))

raw_data[is.na(raw_data)] <- 0

length(is.na(raw_data))


