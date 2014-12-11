quiz1 <- function (){
        # Question 1
        
        # The American Community Survey distributes downloadable 
        # data about United States communities. Download the 2006 
        # microdata survey about housing for the state of Idaho using download.file() 
        # from here: 
                # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
        
        #and load the data into R. The code book, describing the variable names is here: 
                # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

        # Apply strsplit() to split all the names of the data frame 
        # on the characters "wgtp". 
        # What is the value of the 123 element of the resulting list?

        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        destfile <- "data1.csv"
        download.file(URL, destfile,"curl")
        MyData <- read.csv(file=destfile, header=TRUE, sep=",")
        splitNames <- strsplit(names(x),"wgtp")
        splitNames[123]

        # Answer 
        # [[1]]
        # [1] ""   "15"        
}

quiz2 <- function (){
        # Question 2
        # Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
                # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
        # Remove the commas from the GDP numbers in millions 
        # of dollars and average them. What is the average? 
        # Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        destfile <- "data1.csv"
        download.file(URL, destfile,"curl")
        MyData <- read.csv(file=destfile_GDP, header=TRUE, skip = 4,nrows = 215)
        mean(as.numeric(gsub(",", "", x$X.4)), na.rm =T)
        # [1] 377652.4
        # Warning message:
         #       In mean(as.numeric(gsub(",", "", x$X.4)), na.rm = T) :
         #      NAs introduced by coercion
}

quiz3 <- function(){
        # Question 3
        # In the data set from Question 2 what is a regular expression
        # that would allow you to count the number of countries whose name 
        # begins with "United"? Assume that the variable with the country names 
        # in it is named countryNames. How many countries begin with United?
        
        # loading the data
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        destfile <- "data1.csv"
        download.file(URL, destfile,"curl")
        MyData <- read.csv(file=destfile_GDP, header=TRUE, skip = 4,nrows = 215)
        
        # Possible answers:
        # grep("United$",countryNames), 3 [Wrong]
        #       integer(0)
        #       Warning messages:
        #       (...)
        
        # grep("*United",countryNames), 5 [Wrong]
        # 1  6 32
        #       Warning messages:
        #       (...)
        
        # grep("^United",countryNames),3 [Correct]
        # 1  6 32
        #       > countryNames[c(1,6,32)]
        #       [1] United States        United Kingdom       United Arab Emirates
                
}

quiz4 <- function(){
        # Question 4
        # Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
        #       https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
        # Load the educational data from this data set: 
        #       https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
        # Match the data based on the country shortcode. Of the countries 
        # for which the end of the fiscal year is available, how many end in June?
        
        # Original data sources: 
        # http://data.worldbank.org/data-catalog/GDP-ranking-table 
        # http://data.worldbank.org/data-catalog/ed-stats
        
        #loading data
        
        RL_GDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
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
        
        length(grep("fiscal year end(.*)june", tolower(me$Special.Notes))
        # [1] 13
}

quiz5 <- function (){
        # Question 5
        # You can use the quantmod (http://www.quantmod.com/) package 
        # to get historical stock prices for publicly traded companies 
        # on the NASDAQ and NYSE. Use the following code to download
        # data on Amazon's stock price and get the times the data was sampled.
        
        library(quantmod)
        library(lubridate)
        amzn <- getSymbols("AMZN",auto.assign=FALSE)
        sampleTimes <- index(amzn)
        addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
        #        Friday Monday Thursday Tuesday Wednesday  Sum
        # 2007     51     48       51      50        51  251
        # 2008     50     48       50      52        53  253
        # 2009     49     48       51      52        52  252
        # 2010     50     47       51      52        52  252
        # 2011     51     46       51      52        52  252
        # 2012     51     47       51      50        51  250
        # 2013     51     48       50      52        51  252
        # 2014     31     30       33      33        33  160
        # Sum     384    362      388     393       395 1922
        
        # another solution
        sum(year(sampleTimes) == 2012) # 250
        sum(year(sampleTimes) == 2012 & weekdays (sampleTimes) == "Monday") # 47
        
}