# plot
# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008?

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
baltiAggregate <- aggregate(Emissions ~ year + type, baltimore, sum)

#opening graphic device
png("plot3.png", width = 1080, height = 640)

library(ggplot2)
#plotting 
p <- ggplot(baltiAggregate, aes(year, Emissions, color = type))
p <- p + geom_line() + xlab("YEAR") + ylab(expression('Total PM'[2.5]*" Emissions"))+
  ggtitle('Total Emissions in Baltimore City, MD 1999 to 2008')
print(p)

#closing graphic device
dev.off()