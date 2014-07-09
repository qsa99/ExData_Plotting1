library(dplyr)

## Download data
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Dataset.zip")
unzip("Dataset.zip")

## Read in Data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                   colClasses = c("character", "character", "numeric", 
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"), 
                   nrows=2075259, na.strings="?",
                   comment.char = "")

## Select data from between 2/1/2007 and 2/2/2007
data$Date <- as.POSIXct(data$Date, tz="", format="%d/%m/%Y")
beginDate <- as.POSIXct("2/1/2007", tz="", format="%m/%d/%Y")
endDate <- as.POSIXct("2/2/2007", tz="", format="%m/%d/%Y")
data <- filter(data, Date >= beginDate & Date <= endDate)
data$datetime <- paste(data$Date, data$Time)
data$datetime <- as.POSIXct(data$datetime, tz="", format="%Y-%m-%d %H:%M:%S")

## Prepare Plot-----------------------------------------------------------------
png(filename="plot1.png", width=480, height=480, units = "px")
par(bg=NA)
hist(data$Global_active_power,
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     col = "red")
dev.off()