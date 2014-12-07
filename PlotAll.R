## Plotting functions for Exploratory Data Analysis - Week 1
## This file contains all code to create all four PNG files for the project. Files plot1.R - plot4.R are 
## just subsets of this file (all the same through the download and data filtering steps, only difference is only
## the code for the specific PNG in included.)

# Advanced library functions 
library(dplyr)
library(tidyr)
library(lubridate)

# Location of the data
path2zip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download zip and store locally
download.file(path2zip, "power.zip", method = "curl")

#Unzip the text data into a table structure
allData <- read.csv2(unz("power.zip", "household_power_consumption.txt"), stringsAsFactors = FALSE, dec = ".", na.strings = "?")

# Change it into a data frame tbl for use with dplyr functions
allData <- tbl_df(allData)

#Combine data and time columns to new DateTime column in POSIXct POSIXt format
allData <- mutate(allData, DateTime = dmy_hms(paste(Date, Time)))

#Select only the columns to be used for plotting the graphs

plotCols <- select(allData, DateTime, Global_active_power:Sub_metering_3)

#Filter out the rows that are for Feb 1st & 2nd 2007
plotRows <- filter(plotCols, year(DateTime) == 2007, month(DateTime) == 2, day(DateTime) == 1 | day(DateTime) == 2)

#Open a PNG file handle and output plot1.png
png(file = "plot1.png")
hist(plotRows$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

#Open a PNG file handle and output plot2.png
png(file = "plot2.png")
#leave out the points (make them invisble by using blank spaces as the point char)
par(pch = " ") 
plot(plotRows$DateTime, plotRows$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)") 
#fill in the lines between the invisible points
lines(plotRows$DateTime, plotRows$Global_active_power)
dev.off()

#Open a PNG file handle and output plot3.png
png(file = "plot3.png")
par(pch = " ")
plot(plotRows$DateTime, plotRows$Sub_metering_1, xlab = "", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="-", col=c("black", "red", "blue"))
lines(plotRows$DateTime, plotRows$Sub_metering_1)
lines(plotRows$DateTime, plotRows$Sub_metering_2, col="red")
lines(plotRows$DateTime, plotRows$Sub_metering_3, col="blue")
dev.off()

#Code for Voltage versus datetime
par(pch = " ")
plot(plotRows$DateTime, plotRows$Voltage, xlab = "datetime", ylab = "Voltage")
lines(plotRows$DateTime, plotRows$Voltage)

#Code for Reactive Power versus datetime
par(pch = " ")
plot(plotRows$DateTime, plotRows$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power")
lines(plotRows$DateTime, plotRows$Global_reactive_power)

#Open a PNG file handle and output plot4.png
png(file = "plot4.png")
par(pch = " ", mfcol = c(2, 2))
plot(plotRows$DateTime, plotRows$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)") 
lines(plotRows$DateTime, plotRows$Global_active_power)

plot(plotRows$DateTime, plotRows$Sub_metering_1, xlab = "", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="-", col=c("black", "red", "blue"))
lines(plotRows$DateTime, plotRows$Sub_metering_1)
lines(plotRows$DateTime, plotRows$Sub_metering_2, col="red")
lines(plotRows$DateTime, plotRows$Sub_metering_3, col="blue")

plot(plotRows$DateTime, plotRows$Voltage, xlab = "datetime", ylab = "Voltage")
lines(plotRows$DateTime, plotRows$Voltage)

plot(plotRows$DateTime, plotRows$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power")
lines(plotRows$DateTime, plotRows$Global_reactive_power)
dev.off()



