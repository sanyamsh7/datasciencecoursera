# plot total emissions from years 1999, 2002, 2005, 2008
# both the data files should be in the working directory 

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# using aggregate function for effectively calculating the sum
# of year wise emissions
totByYear <- aggregate(Emissions~year, NEI, sum)

# setting up graphic device
png("plot1.png")
# using barplot 
barplot(height = totByYear$Emissions, names.arg = totByYear$year, col = "blue", 
       xlab = "YEARS", ylab = expression('total PM'[2.5]*' emission'), 
       main = expression('Total PM'[2.5]*'Emissions'))

# closing graphic device
dev.off()