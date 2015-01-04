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

# 2) Have total emissions from PM2.5 decreased in the Baltimore City, 
#    Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.

# Filtering the data (using only Baltimore City data)
baltimoreEmissions <- subset(NEI, fips == "24510", select = c(year,Emissions)) 

# Aggregate the Total of Emissions by year
totalEmissions <- aggregate(Emissions ~ year, data = baltimoreEmissions, FUN = sum)

#Create the plot
png(file = "plot2.png")

with(totalEmissions, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
              col = "blue", ylab="PM2.5 Emissions", 
              main="PM2.5 Emissions in the Baltimore City, Maryland",
              xlab="Year",
              xlim = c(1999,2008))
)
axis(side = 1, at = totalEmissions$year) # Labeling the x axis
dev.off()

# Answer:
# As it can be seen on the plot, the total emissions from PM2.5 in the Baltimore City
# as decresed from 1999 to 2002, followed by an incresing until 2005. From 2005 to
# 2008 as decresed reaching the lowest point at 2008.
