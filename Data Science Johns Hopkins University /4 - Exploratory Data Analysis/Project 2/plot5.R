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

# 5) How have emissions from motor vehicle sources changed from 1999-2008 
# in Baltimore City?

# Select all codes of the motor vehicle sources
SCCcodes <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]

# Selecting the years and Emissions corresponding to the motor vehicle codes 
# in Baltimore City.
subSCC <- subset(NEI, SCC %in% SCCcodes & fips == "24510", select = c(year,Emissions))

# Aggregate the Total of Emissions by year
emissionsBaltimoreMotor <- aggregate(Emissions ~ year, data = subSCC, FUN = sum)

#Create the plot
png(file = "plot5.png")
with(emissionsBaltimoreMotor, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
              col = "blue", ylab="PM2.5 Emissions", 
              main="PM2.5 Emissions of Motor vehicles in Baltimore City",
              xlab="Year",
              xlim = c(1999,2008))
)
axis(side = 1, at = emissionsBaltimoreMotor$year) # Labeling the x axis

dev.off()

#Answer
# The emissions from motor vehicle sources from 1999 to 2002 
# in Baltimore City decreased, but from increased 2002 until 2008.
