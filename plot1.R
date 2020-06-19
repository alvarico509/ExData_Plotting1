#Load library, donwload files
library(lubridate)
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(data_url, destfile = "data.zip")
unzip("data.zip")
files <- list.files()

#Clean the data
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
processed_data <- subset(data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ])
dateTime <- paste(processed_data$Date, processed_data$Time)
dateTime <- ymd_hms(dateTime)
processed_data <- cbind(dateTime, processed_data)
processed_data <- subset(processed_data[, c(1, 4, 5, 6, 7, 8, 9, 10)])

#Create first plot
hist(as.numeric(processed_data$Global_active_power), breaks = 12, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()