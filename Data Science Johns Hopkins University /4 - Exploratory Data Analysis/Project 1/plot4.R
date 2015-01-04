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
        
        png(file = "plot4.png")
        
        # Correcting the data format
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")                  # Appropriate date format 
        newData <- within(data, Data_Time <- paste(data$Date, data$Time))     # create a new column with data and time joined
        dataTime<- strptime(newData$Data_Time, "%Y-%m-%d %H:%M:%S") # Appropriate time format
        
        # Format space for all the plots
        par(mfrow = c(2,2))
        
        #Making the plots
        
        # Plot 1
        plot(dataTime, newData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power") 
        
        #Plot 2
        plot(dataTime, newData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        # Plot 3
        yLabel <- "Energy sub metering"
        plot  (dataTime, newData$Sub_metering_1, type = "l", xlab = "", ylab = yLabel, col = "Black")
        points(dataTime, newData$Sub_metering_2, type = "l", xlab = "", ylab = yLabel, col = "Red")
        points(dataTime, newData$Sub_metering_3, type = "l", xlab = "", ylab = yLabel, col = "Blue")
        plotColors <- c("black", "red", "blue")
        plotLegend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", lty = 1, col = plotColors, legend = plotLegend, bty = "n")
        
        # Plot 4
        plot(dataTime, newData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
        dev.off()
        sqldf() # close connection
}
