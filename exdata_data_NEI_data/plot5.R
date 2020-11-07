# plot
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

#reading data if not exists
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)

# subsetting NEI data for baltimore and type == ON-ROAD
balti_onroad<- NEI[NEI$type=="ON-ROAD" & NEI$fips=="24510", ]

aggr_by_year <- aggregate(Emissions ~ year, balti_onroad, sum)

png("plot5.png", width=840, height=640)
g <- ggplot(aggr_by_year, aes(factor(year), Emissions))
# geom_col() uses stat == "identity it leaves the data as is.
g <- g + geom_col() +
  xlab("YEAR") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions (source-motor vehicle, type = ON-ROAD)) Baltimore City, MD(1999 to 2008)')
print(g)
dev.off()