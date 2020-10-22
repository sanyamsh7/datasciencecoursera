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
png(file = "plot2.png", height = 480, width = 480)

#plot of type :l (lines)
global_active_power <- as.numeric(data$Global_active_power)
plot(datetime, global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

print(dev.cur())
# closing graphic device 
dev.off()