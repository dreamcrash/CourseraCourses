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
        
        
        png(file = "plot2.png")
        
        # Correcting the data format
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")                  # Appropriate date format 
        newData <- within(data, Data_Time <- paste(data$Date, data$Time))     # create a new column with data and time joined
        newData$Data_Time <- strptime(newData$Data_Time, "%Y-%m-%d %H:%M:%S") # Appropriate time format
        
        #Making the plot
        plot(newData$Data_Time, newData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
        dev.off()
        sqldf() # close connection
}

