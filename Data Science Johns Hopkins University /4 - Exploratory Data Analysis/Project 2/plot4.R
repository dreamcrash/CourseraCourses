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

# 4) Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# Selected all codes of the coal combustion-related sources
SCCcodes <- SCC$SCC[grepl("[C|c]oal",SCC$EI.Sector)]
# Selecting the years and Emissions corresponding to the coal comb... codes.
subSCC <- subset(NEI, SCC %in% SCCcodes, select = c(year,Emissions))
# Aggregate the Total of Emissions by year
emissionsUSACoal <- aggregate(Emissions ~ year, data = subSCC, FUN = sum)


#Create the plot
png(file = "plot4.png")
with(emissionsUSACoal, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
              col = "blue", ylab="PM2.5 Emissions", 
              main="PM2.5 Emissions of Coal Combustion-related sources",
              xlab="Year",
              xlim = c(1999,2008))
)
axis(side = 1, at = emissionsUSACoal$year) # Labeling the x axis

dev.off()

#Answer
# The emissions from coal combustion-related sources have been decreasing 
# from 1999-2008 across the United States.