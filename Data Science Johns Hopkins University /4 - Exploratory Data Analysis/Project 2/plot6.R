# Download and load data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "dataset.zip"

if (!file.exists(destfile))                             # Check if the file already exists
{
        download.file(URL, destfile,"curl")             # Download data
        file <- unzip(destfile)                         # Unzip the file
}

# Read the data downloaded
NEI <- readRDS("summarySCC_PM25.rds")                   # File 1
SCC <- readRDS("Source_Classification_Code.rds")        # File 2

# 6) Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# Select all codes of the motor vehicle sources

SCCcodes <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]
# Selecting the years and Emissions corresponding to the motor vehicle codes: 
# in Baltimore City or Los Angeles County, California.
subSCC <- subset(NEI, SCC %in% SCCcodes & (fips == "24510" | fips == "06037")
                 , select = c(year,Emissions,fips))

# Aggregate the Total of Emissions by year of Baltimore City and Los Angeles
emissionsBaltimoreAndLa <- aggregate(Emissions ~ year + fips, data = subSCC, FUN = sum)

# label the names
names(emissionsBaltimoreAndLa) <- c("Year", "County", "Emissions")

#Changing numeric County codes for the actual County names
emissionsBaltimoreAndLa$County<-rep(c("Los Angeles","Baltimore"),each=4)

#Create the plot
png(file = "plot6.png")
qplot(Year,Emissions,data=emissionsBaltimoreAndLa,color=County) + geom_line() + labs(y="PM2.5 Emissions") + labs(title = "Total of PM2.5 Emissions by year")

dev.off()

#Answer
# The motor vehicle sources in Baltimore City decreased from 2000 to 2002
# while in Los Angeles have increased. From 2002 to 2005 both baltimore and
# Los Angeles have face little changes in the total of emissions. However,
# from 2005 to 2008 the total of emissions in Los Angeles have decreased
# while in Baltimore have slightly increased.

