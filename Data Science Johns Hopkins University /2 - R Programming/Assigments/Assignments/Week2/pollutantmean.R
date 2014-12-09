pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        accum <- c() # Create an empty vector
        
        for(i in id)
        {
                file_name <- sprintf("%03d.csv", i)
                file_name <- paste0(directory,"/",file_name)
                                
                heisenberg <- read.csv(file=file_name,head=TRUE,sep=",")
                vec <- heisenberg[,pollutant] ## create a vector with the values only
                val <- vec[!is.na(vec)]       ## extract the values of the vector       
                accum <- c(accum,val)
        }
        mean(accum)
}
pollutantmean("specdata","sulfate")
