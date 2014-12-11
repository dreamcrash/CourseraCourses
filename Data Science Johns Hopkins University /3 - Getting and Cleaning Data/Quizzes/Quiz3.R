quiz1 <- function (){
        #QUESTION 1
        
        # The American Community Survey distributes downloadable data about 
        # United States communities. Download the 2006 microdata survey about 
        # housing for the state of Idaho using download.file() from here:
        
        # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
        
       #  and load the data into R. The code book, describing the variable names is here:
                
           # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
        
        # Create a logical vector that identifies the households on greater than 
        # 10 acres who sold more than $10,000 worth of agriculture products. 
        # Assign that logical vector to the variable agricultureLogical. 
        # Apply the which() function like this to identify the rows of the 
        # data frame where the logical vector is TRUE. which(agricultureLogical) 
        # What are the first 3 values that result?
        
        
        #SOLUTION
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        destfile <- "data1.csv"
        download.file(URL, destfile,"curl")
        MyData <- read.csv(file=destfile, header=TRUE, sep=",")
        
        # Column AGS = Sales of Agriculture Products
                # cod 6 .$10000+ 
        # Column ACR = Lot size
                # cod 3 .House on ten or more acres
        agricultureLogical <- x$AGS == 6 & x$ACR == 3
        which(agricultureLogical)[1:3] # the first 3 values of agricultureLogical
}

quiz2 <- function(){
        # Question 2
        # Using the jpeg package read in the following picture of your instructor into R 
        
        # https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
        
        # Use the parameter native=TRUE. What are the 30th and 80th quantiles 
        # of the resulting data? (some Linux systems may produce an answer 638 
        # different for the 30th quantile)
        
        
        #SOLUTION
        # install.packages("jpeg") if needed
        # library(jpeg)
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
        destfile <- "data2.jpg"
        download.file(URL, destfile,"curl")
        MyData <- readJPEG(destfile, native = TRUE)
        quantile(MyData, c(0.3, 0.8))
}

quiz3 <-function(){
        # Question 3
        # Load the Gross Domestic Product data for the 190 
        # ranked countries in this data set: 
                
            # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
        
        # Load the educational data from this data set: 
                
            # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
        
        # Match the data based on the country shortcode. 
        # How many of the IDs match? Sort the data frame in descending order 
        # by GDP rank (so United States is last). 
        # What is the 13th country in the resulting data frame? 
        
        URL_GDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        URL_EDU <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
        destfile_GDP <- "gdp.csv"
        destfile_EDU <- "edu.csv"
        download.file(URL_GDP, destfile_GDP,"curl")
        download.file(URL_EDU, destfile_EDU,"curl")
        GDP <- read.csv(file=destfile_GDP, header=TRUE, skip = 4,nrows = 215)
        EDU <- read.csv(file=destfile_EDU, header=TRUE, sep=",")
        
        # X in GDP is the country id
        # X.2 in GDP is the GDP rank of the country
        
        GDP <- GDP[c(1,2,4,5)] # removing NA colummns
        # X.1 is now the GDP rank of the country
        me <- merge(GDP,EDU,by.x="X",by.y="CountryCode",all=TRUE) # merge the two "tables"
        # How many of the IDs match?
        print(sum(!is.na(unique(me$X.1))))
        #189
        print(me[order(me$X.1,decreasing = TRUE),3][13])
        #[1] St. Kitts and Nevis
}

quiz4 <- function(){
        # What is the average GDP ranking for the "High income: OECD" and 
        # "High income: nonOECD" group?
        # Using the merged data from quiz3 'me'
        tapply(me$X.1,me$Income.Group,mean,na.rm =TRUE)
        #          High income: nonOECD    High income: OECD    Low income 
        #  NaN             91.91304             32.96667         133.72973 
        # Lower middle income  Upper middle income 
        #   107.70370             92.13333 
}

quiz5 <- function(){
        #Question 5
        # Cut the GDP ranking into 5 separate quantile groups. 
        # Make a table versus Income.Group. How many countries are 
        # Lower middle income but among the 38 nations with highest GDP?
        
        
        breaks <- quantile(me$X.1, probs = seq(0,1,0.2), na.rm = TRUE) # Creating the quantiles
        me$GDPvsIncome <- cut(me$X.1, breaks = breaks)                 # Creating a new column with the quantiles
        table(me[me$Income.Group == "Lower middle income", ]$GDPvsIncome,useNA="ifany")
        # Answer
        # (1,38.8] (38.8,76.6]  (76.6,114]   (114,152]   (152,190]        <NA> 
        #    5          13          12           8          16             7 
        
        
        
}