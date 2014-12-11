quiz1 <- function(){
        # From the slides Reading from API's
        # I had to install jackage rjson 
                #install.packages("rjson")
        #library(rjson)
        
        # 1. Find OAuth settings for github:
        #    http://developer.github.com/v3/oauth/
        oauth_endpoints("github")
        
        # 2. Register an application at https://github.com/settings/applications
        #    Insert your values below - if secret is omitted, it will look it up in
        #    the GITHUB_CONSUMER_SECRET environmental variable.
        #
        #    Use http://localhost:1410 as the callback url
        myapp <- oauth_app("github", "b0766d11e93549bf8a77")
        
        # 3. Get OAuth credentials
        github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
        
        # 4. Use API
        gtoken <- config(token = github_token)
        req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
        stop_for_status(req)
        content(req)
        
#        json1  <- content(homeTL)
#        json2  <- jsonlite::fromJSON(toJSON(json1))
}





quiz2 <- function (){
        # For this problem I had to:
        # install the packges data.table and sqldf:
                #packages <- c("data.table", "sqldf")
                #sapply(packages, require, character.only=TRUE, quietly=TRUE)
        # loeaded the following libraries:
                # library(RMySQL)
                # library(sqldf)
        # Then I was getting the following error:
                # Error in mysqlNewConnection(drv, ...) : RS-DBI driver: 
                # (Failed to connect to database: Error: Can't connect to local 
                # MySQL server through socket '/tmp/mysql.sock' (2) 
        #Solved using stackoverflow -> http://stackoverflow.com/questions/8219747/sqldf-package-in-r-querying-a-data-frame
                # Running command options(sqldf.driver = "SQLite")
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
        destfile <- "data2.csv"
        download.file(URL, destfile,"curl")
        acs <- data.table(read.csv(destfile))
}

quiz2Queries <- function (acs){
        print (head (sqldf("select * from acs where AGEP < 50 and pwgtp1")))
        print(head(sqldf("select * from acs")))
        print(head(sqldf("select pwgtp1 from acs")))
        print(head(sqldf("select pwgtp1 from acs where AGEP < 50")))
}

quiz3 <- function (acs){
        aux <- unique(acs$AGEP)
  #     print(identical(sqldf("select unique * from acs"),aux)) 
                # Error in sqliteExecStatement(con, statement, bind.data) : 
                # RS-DBI driver: (error in statement: near "unique": syntax error
        print(identical(sqldf("select distinct pwgtp1 from acs")[,],aux))
       
      # print(identical(sqldf("select AGEP where unique from acs"),aux))
                # Error in sqliteExecStatement(con, statement, bind.data) : 
                # RS-DBI driver: (error in statement: near "unique": syntax error        
        print(identical(sqldf("select distinct AGEP from acs")[,],aux))
}

quiz4 <- function (){
        
        con <- url("http://biostat.jhsph.edu/~jleek/contact.html") # get connection
        htmlCode <- readLines(con)                                 # read data
        close(con)                                                 # close connection
        print(nchar(htmlCode[10]))
        print(nchar(htmlCode[20]))
        print(nchar(htmlCode[30]))
        print(nchar(htmlCode[100]))
}

quiz5 <- function (){
        
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
        destfile <- "data5.for"                 # destination file name
        download.file(URL, destfile,"curl")     # download file
        # con <- file(destfile)                   # open connection
        # data <- readLines(con)                  # read content 
        #  close(con)                              # close the connection
        # data
        # I use the above commented lines to look at the data and determine
        # the widths vector and the number of lines to skip
        
        x <- read.fwf("data5.for", widths = c(12,7,4,9,7,6,4,9,4), skip = 4)
        sum(x[4])
}
