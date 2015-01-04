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

# 3) Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Filtering the data (using only Baltimore City data)
baltimoreEmissions <- subset(NEI, fips == 24510, select = c(year,Emissions,type)) 

# Aggregate the Total of Emissions by year and type
totalEmissions <- aggregate(Emissions~year+type, data=baltimoreEmissions, sum)

#Create the plot
png(file = "plot3.png")
names(totalEmissions) <- c("Year","Type_Variable", "Emissions")
ggplot(totalEmissions, aes(Year, Emissions,color=Type_Variable)) + geom_line() + labs(y="PM2.5 Emissions") + labs(title = "PM2.5 Emissions in the Baltimore City, Maryland")

dev.off()

#Answer
# From 1999 to 2005 point have seen an increase, but from 2005 until 2008 it 
# have been decreasing. All the remaing sources have been decreasing from 1999
# to 2008

