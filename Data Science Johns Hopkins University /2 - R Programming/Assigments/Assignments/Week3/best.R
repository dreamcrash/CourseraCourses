best <- function(state, outcome) {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        
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
                names(filterData) <- c("name","state","heart attack","heart failure","pneumonia")
                
                #Check if valid state
                if (state %in% filterData[,"state"]) 
                {       # get where the valid rows with the information about the given state       
                        validData <- filterData[,"state"] == state   &   filterData[,outcome] != "Not Available"              
                        minPos <- which.min(filterData[,outcome][validData])   # give the position of the lower outcome rate
                        name <- filterData[,"name"][validData][minPos]         # get hospital name
                } else stop("invalid state")       
        }
        else stop("invalid outcome")
}
