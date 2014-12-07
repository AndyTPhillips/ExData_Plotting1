## Plotting functions for Exploratory Data Analysis - Week 1

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
