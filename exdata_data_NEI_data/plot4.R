# plot
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

#reading data if not exists
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
if(!exists("mrgNS")){
  dataN <- data.frame(SCC = NEI$SCC, Emissions = NEI$Emissions, year = NEI$year)
  dataS <- data.frame(SCC = SCC$SCC, Short.Name = SCC$Short.Name)
  mrgNS <- merge(dataN, dataS, by = "SCC")
}

# logical vector for coal source
coalSrc <- grepl("coal", mrgNS$Short.Name, ignore.case = TRUE)
# subsetting coal data
sub_mrgNs <- mrgNS[coalSrc,]

totAggrgate <- aggregate(Emissions ~ year, sub_mrgNs, sum)

png("plot4.png")
#plotting
p <- ggplot(totAggrgate, aes(x = factor(year), y = Emissions)) + geom_col()
p <- p + xlab("YEAR") + ylab(expression('Total PM'[2.5]*' emissions')) +
  ggtitle(expression('PM'[2.5]*' Emission (Source- Coal) from 1999 to 2008'))
print(p)

dev.off()