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

#Create fourth plot
par(mfrow = c(2, 2))
plot(processed_data$Global_active_power ~ processed_data$dateTime, type = "l", xlab = "",
     ylab = "Global Active Power")
plot(processed_data$Voltage ~ processed_data$dateTime, type = "l", xlab = "datetime", ylab = "voltage")
with(processed_data, plot(x = dateTime, y = Sub_metering_1, type = "l", lwd = "1", xlab = "", ylab = "Energy Sub Metering"))
lines(processed_data$Sub_metering_2 ~ dateTime, col = "red")
lines(processed_data$Sub_metering_3 ~ dateTime, col = "blue")
plot(processed_data$Global_reactive_power ~ processed_data$dateTime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()