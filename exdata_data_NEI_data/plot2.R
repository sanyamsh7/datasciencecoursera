# plot
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# fips == "24510" from 1999 to 2008?

#reading data if not exists
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# subsetting only baltimore data
baltimore <- subset(NEI, fips == "24510")

# baltimore aggregate of emissions
baltiAggregate <- aggregate(Emissions ~ year, baltimore, sum)

png("plot2.png")
#ploting 
barplot(baltiAggregate$Emissions, names.arg = baltiAggregate$year, 
        ylab = expression('PM'[2.5]*'emisions'), xlab = "YEARS", 
        main = expression('TOTAL PM'[2.5]*' EMISSIONS IN BALTIMORE, MD'), 
        col = "yellow")

# closing graphic device
dev.off()