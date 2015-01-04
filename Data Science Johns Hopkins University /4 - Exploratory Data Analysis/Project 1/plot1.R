loadDataMakePlot <- function()
{       # Read data from "household_power_consumption.txt" file of the
        # days 1/2/2007 and 2/2/2007
        # Install "install.packages("sqldf")" and 
        # Load library(sqldf) in order to use the read.cv2.sql function.
        
        sqldf() # open a connection
        
        #Reading filter data
        data <- read.csv2.sql(
                "household_power_consumption.txt", 
                sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'",
                na.strings = "?") 
        
        # Create the histogram with data
        png(file = "plot1.png")
        hist(data$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
        dev.off()
        sqldf() # close connection
}
