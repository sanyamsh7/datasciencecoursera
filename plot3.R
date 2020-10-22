# reading data from household_power_consumption.txt in the working directory.
# required data is of date:  2007-02-01 and 2007-02-02
# data read is only of the above given dates

# data of given dates are from line: 66637 
# total rows to read for 2 given dates: 2880
data <- read.table("household_power_consumption.txt", skip = 66637, 
                   nrows = 2880, col.names = c("date", "time", "Global_active_power", 
                                               "Global_reactive_power", "Voltage", 
                                               "Global_intensity", "Sub_metering_1", 
                                               "Sub_metering_2", "Sub_metering_3"), 
                   sep = ";")

# combining date and time column and changing char class to datetime class.
datetime <- strptime(paste(data$date, data$time, sep=" "), 
                     "%d/%m/%Y %H:%M:%S")

# setting png graphic device
png(file = "plot3.png", height = 480, width = 480)

# changing classes as required
subM1 <- as.numeric(data$Sub_metering_1)
subM2 <- as.numeric(data$Sub_metering_2)
subM3 <- as.numeric(data$Sub_metering_3)

# plotting sub_metering_1
plot(datetime, subM1, xlab = "", ylab = "Energy sub metering", type = "l")

#adding line sub_metering_2
lines(datetime, subM2, type = "l", col = "red")
#adding line sub_metering_3
lines(datetime, subM3, type = "l", col = "blue")

#adding legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

#closing graphic device
dev.off()