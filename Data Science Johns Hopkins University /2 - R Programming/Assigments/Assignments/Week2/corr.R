corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        id <- 1:332
        correl <- c()
        for(i in id)
        {
                file_name <- sprintf("%03d.csv", i)
                file_name <- paste0(directory,"/",file_name)
                
                heisenberg <- read.csv(file=file_name,head=TRUE,sep=",")
                valSul <- !is.na(heisenberg[,"sulfate"])  # Gets where are the values in the sulfate col
                valNut <- !is.na(heisenberg[,"nitrate"])  # Gets where are the values in the nitrade col
                completeVal <- valSul & valNut # Gets where both sulfate & nitrate have values
                # if the # of complete cases is equal or greater than the threshold
                if(sum(completeVal) >= threshold)
                {
                        sulfate <- heisenberg[,"sulfate"][completeVal] # Complete Values of sulfate
                        nitrade <- heisenberg[,"nitrate"][completeVal] # Complete Values of nitrate
                        correl <- c(correl, cor(sulfate,nitrade))
                }
        }
        correl
}
corr("specdata",150)
