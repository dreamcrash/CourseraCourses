loadData <- function()
{
        URL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
        destfile <- "dataset.zip"
        fileName <- "activity.csv"
        
        if (!file.exists(destfile))                             # Check if the file already exists
        {
                download.file(URL, destfile,"curl")             # Download data
                file <- unzip(destfile)                         # Unzip the file
        }
        
        data <- read.csv(file=fileName,head=TRUE,sep=",")
}

changeInterval <- function(data)
{
        size <- nrow(data)
        # 1440 is the number of minutes within an hour
        # Since the sequence starts with 0 it have to end on 1440 - 5.
        newIntervals <- seq(0,1435,5)
        newIntervalsSize <- length(newIntervals)
        j <- 1
        
        for(i in 1:size)
        {
                if (j > newIntervalsSize) # reset the iterator
                        j <- 1        
                
                data$interval[i] = newIntervals[j]
                j <- j + 1
        }
        data        
}



# What is mean total number of steps taken per day?
        # 1) Make a histogram of the total number of steps taken each day
        aggData <- aggregate(steps ~ date, data = data, FUN = sum) # aggregating by day, and summing the
        # number of steps for each day
        hist(aggData$step, xlab = "Total of Steps", main = "Total of steps per day")

        # 2) Calculate and report the mean and median total number of steps taken per day
        mean(aggData$step)      # mean of total number of steps taken per day
        median(aggData$step)    # median of total number of steps taken per day

# What is the average daily activity pattern?

        # Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) 
        # and the average number of steps taken, averaged across all days (y-axis)
        t <- aggregate(steps ~ interval, data = data, FUN = mean, na.rm = TRUE)
        plot(t$steps ~ t$interval,type = "l") # config eixos

        # Which 5-minute interval, on average across all the days in the dataset, 
        # tcontains the maximum number of steps?
        t$interval[which.max(t$steps)]

# Imputing missing values

        # 1) Calculate and report the total number of missing values in the dataset 
        # (i.e. the total number of rows with NAs)
        sum(is.na(data))

        # 2) Devise a strategy for filling in all of the missing values in the dataset. 
        # The strategy does not need to be sophisticated. For example, you could use 
        # the mean/median for that day, or the mean for that 5-minute interval, etc.
        fillingNA <- function(data, naSub)
        {
                size <- nrow(data)
                
                for(i in 1:size)
                {
                        if(is.na(data$steps[i]))
                        {
                                # Replacing the NA for the 5-minute interval mean
                                data$steps[i] = naSub$steps[naSub$interval == data$interval[i]]
                        }
                }
                data
        }

        # 3) Create a new dataset that is equal to the original dataset but with the 
        # missing data filled in.

        newDataSet <- fillingNA(data,t)

        # 4) Make a histogram of the total number of steps taken each day and Calculate 
        # and report the mean and median total number of steps taken per day. 
        # Do these values differ from the estimates from the first part of the assignment? 
        # What is the impact of imputing missing data on the estimates of the total daily 
        # number of steps?
        newDataSetaggData <- aggregate(steps ~ date, data = newDataSet, FUN = sum)
        
        hist(newDataSetaggData$step, xlab = "Total of Steps", main = "Total of steps per day")
        
        mean(newDataSetaggData$step)      # mean of total number of steps taken per day
        median(newDataSetaggData$step)    # median of total number of steps taken per day


transfWeekDays <- function(oldData)
{
        oldData$weekDays <- weekdays(as.Date(oldData$date))
        size <- nrow(oldData)
        
        for(i in 1:size)
        {
                if(oldData$weekDays[i] == "Saturday" | oldData$weekDays[i] == "Sunday")
                {
                        oldData$weekDays[i] <- "weekend"
                }
                else
                {
                        oldData$weekDays[i] <- "weekday"
                }
        }
        oldData              
}

newDataSet <- transfWeekDays(newDataSet)




