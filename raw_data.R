raw_data <- read.csv("../Pecan_70_Houses_2017.csv", header = TRUE, sep = ",")
str(raw_data)

head(raw_data)
tail(raw_data)

summary(raw_data)

nrow(is.na(raw_data$air2))
summary(raw_data$air2)
