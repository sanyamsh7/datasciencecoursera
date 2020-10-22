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

# changing classes as numeric
subM1 <- as.numeric(data$Sub_metering_1)
subM2 <- as.numeric(data$Sub_metering_2)
subM3 <- as.numeric(data$Sub_metering_3)
voltage <- as.numeric(data$Voltage)
global_active_power <- as.numeric(data$Global_active_power)
global_reactive_power <- as.numeric(data$Global_reactive_power)

# setting png graphic device
png(file = "plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2)) 

##plot 1
plot(datetime, global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")
##plot 2
plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##plot 3
plot(datetime, subM1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(datetime, subM2, type = "l", col = "red")
lines(datetime, subM3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
##plot 4
plot(datetime, global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

#closing graphic device
dev.off()