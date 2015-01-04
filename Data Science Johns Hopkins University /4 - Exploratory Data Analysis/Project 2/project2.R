# Download and load data
loadData <- function()
{
        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        destfile <- "dataset.zip"
        
        if (!file.exists(destfile))                             # Check if the file already exists
        {
                download.file(URL, destfile,"curl")             # Download data
                file <- unzip(destfile)                         # Unzip the file
        }
}
        
# Read the data downloaded
NEI <- readRDS("summarySCC_PM25.rds")                   # File 1
SCC <- readRDS("Source_Classification_Code.rds")        # File 2

# Questions :

# You must address the following questions and tasks in your exploratory analysis. 
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.

# 1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

question1 <- function(NEI)
{        
        q1 <- aggregate(Emissions ~ year, data = NEI, FUN = sum)
        
        with(q1, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
                      col = "blue", ylab="PM2.5 Emissions", 
                      main="Total of PM2.5 Emissions by year", 
                      xlim = c(1999,2008))
             )
        axis(side = 1, at = q1$year) # Labeling the x axis
}

# 2) Have total emissions from PM2.5 decreased in the Baltimore City, 
#    Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.

question2 <- function(NEI)
{        
        q2 <- subset(NEI, fips == "24510", select = c(year,Emissions)) # Filtering the data
        q2 <- aggregate(Emissions ~ year, data = q2, FUN = sum)
        
        with(q2, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
                      col = "blue", ylab="PM2.5 Emissions", 
                      main="PM2.5 Emissions in the Baltimore City, Maryland", 
                      xlim = c(1999,2008))
        )
        axis(side = 1, at = q2$year) # Labeling the x axis
}
 
# 3) Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
        
question3 <- function(NEI)
{        
        q3 <- subset(NEI, fips == 24510, select = c(year,Emissions,type)) # Filtering the data
        agg <- aggregate(Emissions~year+type, data=q3, sum)
        qplot(year,Emissions,data=agg,color=type) + geom_line() + labs(y="PM2.5 Emissions") + labs(title = "PM2.5 Emissions in the Baltimore City, Maryland")
}        

# 4) Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
question4 <- function(NEI)
{
        # Select all codes of the coal combustion-related sources
        SCCcodes <- SCC$SCC[grepl("[C|c]oal",SCC$EI.Sector)]
        # Selecting the years and Emissions corresponding to the coal comb... codes.
        subSCC <- subset(NEI, SCC %in% SCCcodes, select = c(year,Emissions))
        # Aggregate the Total of Emissions by year
        q4 <- aggregate(Emissions ~ year, data = subSCC, FUN = sum)
        # drawing the plot
        with(q4, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
                      col = "blue", ylab="PM2.5 Emissions", 
                      main="PM2.5 Emissions of Coal Combustion-related sources", 
                      xlim = c(1999,2008))
             )
        axis(side = 1, at = q4$year) # Labeling the x axis
}



# 5) How have emissions from motor vehicle sources changed from 1999-2008 
# in Baltimore City?
question5 <- function(NEI)
{
        # Select all codes of the motor vehicle sources
        SCCcodes <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]
        # Selecting the years and Emissions corresponding to the motor vehicle codes 
        # in Baltimore City.
        subSCC <- subset(NEI, SCC %in% SCCcodes & fips == "24510", select = c(year,Emissions))
        # Aggregate the Total of Emissions by year
        q5 <- aggregate(Emissions ~ year, data = subSCC, FUN = sum)
        # drawing the plot
        with(q5, plot(year,Emissions,type="o",pch=19,xaxt = 'n',
                      col = "blue", ylab="PM2.5 Emissions", 
                      main="PM2.5 Emissions of Motor vehicles in Baltimore City", 
                      xlim = c(1999,2008))
        )
        axis(side = 1, at = q5$year) # Labeling the x axis
        
}

# 6) Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

question6 <- function(NEI)
{
        # Select all codes of the motor vehicle sources
        SCCcodes <- SCC$SCC[grepl("[m|M]obile",SCC$EI.Sector)]
        # Selecting the years and Emissions corresponding to the motor vehicle codes: 
        # in Baltimore City or Los Angeles County, California.
        subSCC <- subset(NEI, SCC %in% SCCcodes & (fips == "24510" | fips == "06037")
                         , select = c(year,Emissions,fips))
        
        # Aggregate the Total of Emissions by year of Baltimore City and Los Angeles
        q6 <- aggregate(Emissions ~ year + fips, data = subSCC, FUN = sum)  
        # label the names
        names(q6) <- c("Year", "County", "Emissions")
        #Changing numeric County codes for the actual County names
        q6$County<-rep(c("Los Angeles","Baltimore"),each=4)
        qplot(Year,Emissions,data=q6,color=County) + geom_line() + labs(y="PM2.5 Emissions") + labs(title = "Total of PM2.5 Emissions by year")
}

