library(xlsx)
quiz1 <- function (){
 
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        destfile <- "data1.csv"
        download.file(URL, destfile,"curl")
        MyData <- read.csv(file=destfile, header=TRUE, sep=",")
        
        #Column Val gives us the property value and 24 code means ".$1000000+"
        # Get the number of property with value > $1000000
        code = 24
      
        # three ways of solving this problem
        #   1) sum(x[!is.na(x$VAL),]$VAL == code)
        #   2) length(x$VAL[!is.na(x$VAL) & x$VAL==code])
      
       sum(x$VAL==24, na.rm=T) # 3)
}

quiz3 <- function(){
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
        destfile <- "data2.xlsx"
        download.file(URL, destfile,mode="w","curl")
    
        dat <- read.xlsx(file=destfile,sheetIndex = 1,colIndex=7:15,startRow=18,endRow=23, header=TRUE)
        sum(dat$Zip*dat$Ext,na.rm=T)
}

quiz4 <- function(){
        
        URL <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
        data <- xmlTreeParse(file=URL,useInternal=TRUE)
        topLevel <- xmlRoot(data)                              #Get the top-level XML node.
        zipCodes <- xpathSApply(topLevel,"//zipcode",xmlValue) #Extracting the zipCodes
        sum(zipcode[] == 21231)                                #Get the number of zipcode equal to 21231
}

quiz5 <- function(){
        # need to load library(data.table)
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
        destfile <- "data5.csv"
        download.file(URL, destfile,"curl")
        DT <- fread(input=destfile, sep=",")
}

quiz5timer <- function(DT){
        
        print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))                      
        print(system.time(mean(DT[DT$SEX==1,]$pwgtp15) + mean(DT[DT$SEX==2,]$pwgtp15)))
        print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
        print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
      #  print(system.time(rowMeans(DT)[DT$SEX==1] + rowMeans(DT)[DT$SEX==2]))
        print(system.time(DT[,mean(pwgtp15),by=SEX]))
}

