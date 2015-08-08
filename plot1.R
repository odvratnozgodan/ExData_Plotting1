suppressPackageStartupMessages(library(dplyr))
destfile="./data/household_power_consumption.txt"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(destfile)) {
    temp <- tempfile()
    download.file(fileURL,temp, method="curl")
    unzip(temp, exdir = "./data")
    unlink(temp)
}
if(!exists("ex_data") || count(ex_data)!=2075259){
    ex_data <- data.frame(read.table(destfile, header=TRUE, sep=";", colClasses = c("character", "character",rep("numeric",7)), na.strings = "?"))
    ex_data <- mutate(ex_data, DateTime = paste(Date, Time, sep = '_'))
    ex_data$Date <- as.Date(ex_data$Date, format = '%d/%m/%Y')
    ex_data$DateTime <- as.POSIXct(ex_data$DateTime, format = '%d/%m/%Y_%H:%M:%S')
}
dateRange <- filter(ex_data, Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
hist(dateRange$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(dateRange$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()