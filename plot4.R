# Coursera - John Hopkins University 
# Neil Salvador Sernande Villareal
# Course Project 1 - Exploratory Data Analysis
# Filename : plot4.R

rm(list = ls())

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "UCI Power Consumption Dataset.zip"

dataFileName <- "household_power_consumption.txt"

# for debugging: do not redownload the file if its already downloaded
if (!file.exists(dataFileName)) {
    download.file(fileURL, fileName, mode = "wb")
    unzip(fileName);
}


rm(fileURL, fileName, dataFileName) #remove variables in memory

# read data from semi-colon delimited file ----------------
data <- read.table("household_power_consumption.txt", header = T,
                   sep = ";", na.strings = "?")

data$Date <- as.Date(data$Date, format = "%d/%m/%Y") # convert the date variable to Date class

# extract the subset of data between 2007-02-01 to 2007-02-02 -------------
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# parse date and time -------------
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

# plot the data ------------
par(mfrow = c(2, 2))
attach(data)

#plot 1
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", xlab = "")

plot(Voltage ~ datetime, type = "l")

#plot 3
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(Global_reactive_power ~ datetime, type = "l")

# save plot to file ------------
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(data)