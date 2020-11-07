# plot
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#reading data if not exists
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)

# subsetting MD and LA data( tyep == ON-ROAD )
balti_MD <- NEI[NEI$type=="ON-ROAD" & NEI$fips=="24510", ]
losA_CA <- NEI[NEI$type=="ON-ROAD" & NEI$fips=="06037", ]

balti_MD$fips <- "Baltimore, MD"
losA_CA$fips <- "Los Angeles, CA"

# combining both the state data
data <- rbind(balti_MD, losA_CA)

aggrYearAndFips <- aggregate(Emissions ~ year + fips, data, sum)

png("plot6.png", width = 1080, height = 640)

p <- ggplot(aggrYearAndFips, aes(factor(year), Emissions))
p <- p + facet_grid(.~ fips) + geom_bar(stat = "identity") + 
  labs(title = 'Total Emissions (source-motor vehicle, type=ON-ROAD) in Baltimore City, MD vs Los Angeles, CA(1999-2008',
    x = "YEAR", y = expression('Total PM'[2.5]*" Emissions"))
print(p)

dev.off()