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
xrange <- seq(0, 2, length.out = length(dateRange$Sub_metering_1))
g_range <- range(0, dateRange$Sub_metering_1, dateRange$Sub_metering_2, dateRange$Sub_metering_3)
plot(xrange, dateRange$Sub_metering_1, type="l", col="black", ylim=g_range, axes=FALSE, xlab = "", ylab = "Energy sub metering")
lines(xrange, dateRange$Sub_metering_2, type="l", col="red")
lines(xrange, dateRange$Sub_metering_3, type="l", col="blue")
axis(1, at=0:2, lab=c("Thu","Fri","Sat"))
axis(2, las=1, at=10*0:g_range[2])
box()
legend("topright", g_range[2], c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.8, col=c("black","red","blue"), lty=c(1, 1, 1));


png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(xrange, dateRange$Sub_metering_1, type="l", col="black", ylim=g_range, axes=FALSE, xlab = "", ylab = "Energy sub metering")
lines(xrange, dateRange$Sub_metering_2, type="l", col="red")
lines(xrange, dateRange$Sub_metering_3, type="l", col="blue")
axis(1, at=0:2, lab=c("Thu","Fri","Sat"))
axis(2, las=1, at=10*0:g_range[2])
box()
legend("topright", g_range[2], c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.8, col=c("black","red","blue"), lty=c(1, 1, 1));
dev.off()

