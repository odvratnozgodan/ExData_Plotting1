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
xrange <- c(0, 1, 2)
plot(seq(0, 2, length.out = length(dateRange$Global_active_power)), dateRange$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", axes = FALSE)
axis(1, at=0:2, lab=c("Thu","Fri","Sat"))
axis(2, las=1, at=2*0:8)
box()
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(seq(0, 2, length.out = length(dateRange$Global_active_power)), dateRange$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", axes = FALSE)
axis(1, at=0:2, lab=c("Thu","Fri","Sat"))
axis(2, las=1, at=2*0:8)
box()
dev.off()

