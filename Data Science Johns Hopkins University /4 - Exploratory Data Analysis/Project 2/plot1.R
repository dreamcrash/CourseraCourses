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

# Questions :

# 1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Aggregate the Total of Emissions by year
totalEmissions <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

#Create the plot
png(file = "plot1.png")

with(totalEmissions, 
              plot(year,Emissions,type="o",pch=19,xaxt = 'n',
              col = "blue", ylab="PM2.5 Emissions",
              xlab="Year",
              main="Total of PM2.5 Emissions by year", 
              xlim = c(1999,2008))
)
axis(side = 1, at = totalEmissions$year) # Labeling the x axis

dev.off()

# Answer:
# As it can be seen on the plot, from 1999 to 2008 the total emissions 
# from PM2.5 decreased in the United States.
