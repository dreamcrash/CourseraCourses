rankhospital <- function(state, outcome, num = "best"){
        
        ## Read outcome data
        ## Check that state and outcome are valid
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        valid_outcomes <- c("heart attack","heart failure","pneumonia")
        
        
        # Check if the outcome is a valid one
        if(outcome %in% valid_outcomes)
        {
                file <- read.csv(file="outcome-of-care-measures.csv",colClasses = "character")
                filterData <- file[c(2, 7, 11, 17, 23)]
                # 2  -> Hospital Name
                # 7  -> State abv.
                # 11 -> outcome = Heart Attack
                # 17 -> outcome = Heart Failure
                # 23 -> outcome = Pneumonia
                # set readable col names
                #http://www.dummies.com/how-to/content/how-to-sort-data-frames-in-r.html
                names(filterData) <- c("name","state","heart attack","heart failure","pneumonia")
                
                #Check if valid state
                if (state %in% filterData[,"state"]) 
                {       # get where the valid rows with the information about the given state       
                        dFrameFilter <- filterData[filterData$state==state & filterData[outcome] != "Not Available", ]
                        
                        if(is.numeric(num) & nrow(dFrameFilter) <= num) 
                        {
                                NA
                        }
                        else
                        {       #getting correct order first by rate. In case of ties the name is use.
                                index <- order(dFrameFilter$name) # order by name
                                dFrameFilter <- dFrameFilter[index,]
                                index <- order(as.numeric(dFrameFilter[,outcome])) # order by outcome
                                
                                if(is.numeric(num))     dFrameFilter[index,][,"name"][num]
                                else if(num == "best")  dFrameFilter[index,][,"name"][1]
                                else                    tail(dFrameFilter[index,], n=1)[,"name"] # worst
                        }
                }
                else stop("invalid state")   
        }
        else stop("invalid outcome")   
}
