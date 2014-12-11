#Getting and Cleaning Data Project:

# You should create one R script called run_analysis.R that does the following. 
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 

# Function to download and extract the data
getDataFromNet <- function (URL, destfile)
{
        print("Download Data")
        if (!file.exists(destfile))                             # Check if the file already exists
        {
                download.file(URL, destfile,"curl")             # Download data
                file <- unzip(destfile)                         # Unzip the file
                folder <- unlist(strsplit(file[1],"/"))[2]      # Gets the folder's name of the unzipped file
        }
        else "UCI HAR Dataset"                                  # Returns the folder name
}

# 1- Merge all data together
mergeAllData <- function(folder){
        print("Merge all Data")
        #FROM THE README.TXT
        #        - 'README.txt'
        # - 'features_info.txt': Shows information about the variables used on the feature vector.
        # - 'features.txt': List of all features.
        # - 'activity_labels.txt': Links the class labels with their activity name.
        # - 'train/X_train.txt': Training set.
        # - 'train/y_train.txt': Training labels.
        # - 'test/X_test.txt': Test set.
        # - 'test/y_test.txt': Test labels.
        
        
        # Read subject data from train and test folders
        print("Merge subject_train.txt and subject_test.txt")
        trainDir  <- paste0(folder,"/train")               # Gets the train folder directory
        testDir   <- paste0(folder,"/test")                # Gets the test folder directory
        fileTrain <- paste0(trainDir,"/subject_train.txt") # Gets the path to the subject train file
        fileTest  <- paste0(testDir,"/subject_test.txt")   # Gets the path to the subject test  file
        subTrain  <- data.table(read.table(fileTrain))     # load the subject train data
        subTest   <- data.table(read.table(fileTest))      # load the subject test  data
        # merge rows subject data and set their names
        mergeSub  <- rbind(subTrain, subTest)              # join the two tables by rows
        setnames(mergeSub, "V1", "mergeSub")               # set names for the new table created
        # Read Y data from train and test folders
        print("Merge Y_train.txt and Y_test.txt")         
        fileTrain <- paste0(trainDir,"/Y_train.txt")       
        fileTest  <- paste0(testDir,"/Y_test.txt")
        yTrain  <- data.table(read.table(fileTrain))
        yTest   <- data.table(read.table(fileTest))
        # merge rows Y data and set their names
        mergeY <- rbind(yTrain, yTest)
        setnames(mergeY, "V1", "mergeY")
        # Read X data from train and test folders
        print("Merge X_train.txt and X_test.txt")
        fileTrain <- paste0(trainDir,"/X_train.txt")
        fileTest  <- paste0(testDir,"/X_test.txt")
        xTrain  <- data.table(read.table(fileTrain))
        xTest   <- data.table(read.table(fileTest))
        # merge rows Y data and set their names
        mergeX <- rbind(xTrain, xTest)
        setnames(mergeX, "V1", "mergeX")
        
        #merge Col of subject, X and Y data
        allMerge <- cbind(mergeSub,mergeY,mergeX)        # Merge the three new tables into a single one
}

# Function to sift right a vector of positions (integers)
siftRigth <- function(vecPos, sift){
        tmp <- c(1,2)
        for(pos in vecPos)
        {
                tmp <- append(tmp, c(pos + sift))        
        }
        tmp
}
# Cleaning labels
cleanLabels <- function (featureData,posMeanStd,meanAndStd){
        print("Cleaning Labels")
        featuresNames <- featureData$V2[posMeanStd]                   # Getting the correct labels
        featuresNames <- gsub("-","_",featuresNames)                  # Changing "-" for "_"
        featuresNames <- gsub("\\(\\)","",featuresNames)              # Removing ()
        featuresNames <- gsub("BodyBody","Body",featuresNames)        # Removing redudante Names
        featuresNames <- gsub("Acc","_Acc_",featuresNames) 
        featuresNames <- gsub("Body","Body_",featuresNames)
        featuresNames <- gsub("Gyro","Gyro_",featuresNames)
        featuresNames <- gsub("Jerk","Jerk_",featuresNames)
        featuresNames <- gsub("meanFreq","mean_Freq",featuresNames)
        featuresNames <- gsub("__","_",featuresNames)
        featuresNames <- append(c("Activity_ID","Subject"),featuresNames) 
        featuresNames <- append(featuresNames,"Activity_Name")
        names(meanAndStd) <- featuresNames                              # Setting more appropriately labels
        meanAndStd
}

#Function that load descriptive activity names
descripActivNames <- function (folder,meanAndStd){
        print("Applying descriptive names")
        activityFile <- paste0(folder,"/activity_labels.txt")         # Gets the path to the activity_labels file
        activityNames<- fread(activityFile)                           # load the file
        names(activityNames) <- c("mergeY", "Activities")             # Set col names
        setkey(meanAndStd,mergeY)                                     # Set a key
        setkey(activityNames,mergeY)                                  # Set a key
        meanAndStd <- merge(meanAndStd,activityNames)                 # Merge by the key of each data      
}
# Function to create tidy data
createTidyData <- function(meanAndStd)
{
        # Creates a second, independent tidy data set with the average of 
        # each variable for each activity and each subject.
        
        # To create the tidy data I used the information on 03_04_reshapingData.pdf
        # of week 3
        
        #MELTING DATA FRAME
        
        print("Creating Tidy Data")
        
        measureVars <- names(meanAndStd)[3:(length(meanAndStd)-1)] # Measure variable will be all columns except the first two and last one
        dataMelt    <- melt(meanAndStd, id = c("Subject","Activity_ID","Activity_Name"), measure.vars = measureVars)
        
        # CASTING DATA FRAME
        tidyData   <- dcast(dataMelt, Subject + Activity_Name ~ variable, mean)
}

# Function to load necessary libraries
loadNecessaryLibs <- function ()
{
        if (!require("data.table")) 
        {
                install.packages("data.table")
        }
        if (!require("reshape2")) 
        {
                install.packages("reshape2")
        }
        library("data.table")
        library("reshape2")
}


main <- function()
{  
        loadNecessaryLibs()
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        destfile <- "dataset.zip"
        
        # 1 - Merges the training and the test sets to create one data set.
        folder <- getDataFromNet(URL, destfile)          # Gets the list of files extracted
        allData <- mergeAllData(folder)                  # Merge all the data from train and test
        
        # 2 - Extracts only the measurements on the mean and standard deviation 
        # for each measurement.
        featureData  <- fread(paste0(folder,"/features.txt"))           # load the data from feature file
        posMeanStd   <- grep("mean|std",featureData$V2)                 # Get the position from the mean and standard deviation
        matchCol     <- siftRigth(posMeanStd, 2)                        # Match the position of mean and standard deviation with the merged data
        meanAndStd   <- subset(allData, select=matchCol,with=FALSE)     # Subsetting the merged data
        
        # 3 - Uses descriptive activity names to name the activities in the data set
        meanAndStd <- descripActivNames(folder,meanAndStd)
       
        # 4 - Appropriately labels the data set with descriptive variable names. 
        meanAndStd <- cleanLabels (featureData,posMeanStd,meanAndStd)

        # 5 - Creates a second, independent tidy data set with the average 
        # of each variable for each activity and each subject. 
        
        tidyData <- createTidyData(meanAndStd)
        write.table(tidyData, paste0(folder,"/tidyData.txt"),row.name=FALSE)
        tidyData
}