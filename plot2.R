# Coursera - John Hopkins University 
# Neil Salvador Sernande Villareal
# Course Project 1 - Exploratory Data Analysis
# Filename : plot2.R

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
plot(data$Global_active_power ~ data$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# save plot to file ------------
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()