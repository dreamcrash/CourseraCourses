#Loading packages
if (!("ggplot2" %in% rownames(installed.packages())))
        install.packages("ggplot2")

library(ggplot2)
library(grid)

if (!("gridExtra" %in% rownames(installed.packages())))
        install.packages("gridExtra")

library(gridExtra)




# Download and load data
loadData <- function()
{
        URL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
        destfile <- "dataset.csv.bz2"
        
        if (!file.exists(destfile))                             # Check if the file already exists
        {
                download.file(URL, destfile,"curl")             # Download data
        }
        data <- read.csv(destfile)                              # load the data
}
#Load the data
data <- loadData()

#Some information about the data loaded
names(data)

#Number of rows
nrow(data)

###Across the United States, which types of events 
# (as indicated in the EVTYPE variable) are most harmful 
# with respect to population health?



#Aggregating the total of FATALITIES by type of events
fatalities <- aggregate(FATALITIES ~ EVTYPE, data = data, FUN = sum)

#Aggregating the total of injuries by type of events
injuries   <- aggregate(INJURIES ~ EVTYPE, data = data, FUN = sum)

# Sorting by number of Fatalities
sortedFatalities <- fatalities[ order(-fatalities[,2]), ]

# Sorting by number of injuries
sortedInjuries <- injuries[ order(-injuries[,2]), ]

# Top 10 Fatalities that are most harmful with respect to population health
top10Fatal <- head(sortedFatalities,10)

# Top 10 injuries that are most harmful with respect to population health
top10Injur <- head(sortedInjuries, 10)

# Relevel the FATALITIES by EVTYPE, so that the plot starts with the lower fatalities
# bars and ends with the higher ones.
top10Fatal$EVTYPE <- factor(top10Fatal$EVTYPE, levels=top10Fatal[order(top10Fatal$FATALITIES),"EVTYPE"])

top10Injur$EVTYPE <- factor(top10Injur$EVTYPE, levels=top10Injur[order(top10Injur$INJURIES),"EVTYPE"])

# Draw the plots
fatalPlot <- ggplot(data=top10Fatal, aes(x=EVTYPE, y=FATALITIES, fill=EVTYPE)) + 
             geom_bar(colour="black", fill="#DD8888", width=.7,stat="identity") + 
             guides(fill=FALSE) +
             xlab("Types of events") + ylab("Total of fatalities") +
             ggtitle("Top 10 : Most Fatal events to population health") + coord_flip()


injurPlot <- ggplot(data=top10Injur, aes(x=EVTYPE, y=INJURIES, fill=EVTYPE)) + 
                geom_bar(colour="black", fill="#DD8888", width=.7,stat="identity") + 
                guides(fill=FALSE) +
                xlab("Types of events") + ylab("Total of Injurie") +
                ggtitle("Top 10 : Most Injure events to population health") + coord_flip()

grid.arrange(fatalPlot, injurPlot, nrow=2)



# 2) Across the United States, which types of events have the 
# greatest economic consequences?

#We need to check:
# 1 - PROPDMG Damage. Property damage estimates should be entered as actual dollar amounts, if a 
# reasonably accurate estimate from an insurance company or other qualified individual is 
# available.
# 2 - CROPDMG. Crop Damage Data. Crop damage information may be obtained from reliable sources
# 3 - PROPDMGEXP and  CROPDMGEXP are orders of magnitude, and I am understanding them as 10^EXP


x <- data[c("EVTYPE","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")]


# unique(x$PROPDMGEXP)
# K M   B m + 0 5 6 ? 4 2 3 h 7 H - 1 8
# + - ? replace by 0
# unique(x$CROPDMGEXP)
# M K m B ? 0 k 2
# H or h = 2 (hundred = 10^2)
# K or k = 3 (thousand = 10^3)
# M or m = 6 (million = 10^6)
# B or b = 9 (billion = 10^9)

# The crop damage by an event can then be calculated as crop_damage =  CROPDMG*10^(CROPDMGEXP).

transfData <- function(col)
{
        replace <- c("2","3","6","9","0")
        regex   <- c("[Hh]","[Kk]","[Mm]","[Bb]","[+-/?]")
        size <- length(replace)
        for (i in 1:size)
        {
                col <- sub(regex[i], replace[i],col)
        }
        col[col == ""] <- "0" # Removing empty space
        col <- as.numeric(col) # Converting col values into numeric ones
        col
}

#Removing simbols for values
x$PROPDMGEXP = transfData(x$PROPDMGEXP)

# New values
unique(x$PROPDMGEXP)
# "3" "6" "0" "9" "5" "4" "2" "7" "1" "8""

#blabla
unique(x$CROPDMGEXP)


#[1]   M K m B ? 0 k 2
#Levels:  ? 0 2 B k K m M

#Removing simbols for values
x$CROPDMGEXP= transfData(x$CROPDMGEXP)

# New values
unique(x$CROPDMGEXP)

#[1] "0" "6" "3" "9" "2"

#Formula :
# PROPDMG * 10 ^ PROPDMGEXP + CROPDMG * 10 ^ CROPDMGEXP
y <- x
y$EconomicLoss <- y$PROPDMG * 10 ^ y$PROPDMGEXP + y$CROPDMG * 10 ^ y$CROPDMGEXP

economicLoss <- aggregate(EconomicLoss ~ EVTYPE, data = y, FUN = sum)

top10EconomicLoss <- head(economicLoss[ order(-economicLoss[,2]), ],10)

top10EconomicLoss$EVTYPE <- factor(top10EconomicLoss$EVTYPE, levels=top10EconomicLoss[order(top10EconomicLoss$EconomicLoss),"EVTYPE"])

ggplot(data=top10EconomicLoss, aes(x=EVTYPE, y=EconomicLoss, fill=EVTYPE)) + 
        geom_bar(colour="black", fill="#DD8888", width=.7,stat="identity") + 
        guides(fill=FALSE) +
        xlab("Types of events") + ylab("Dollars lost) +
        ggtitle("Top 10 : Events with more losses to the economy) + coord_flip()

