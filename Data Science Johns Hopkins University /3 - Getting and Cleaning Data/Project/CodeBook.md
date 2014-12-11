##CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

### Describing the data and variables:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

### Data detail Information:
> activity_labels.txt
- nrow(activityNames) = 6
- ncol(activityNames) = 2
- No column names on the file.
- Size = 4 KB

> features.txt
- nrow(featureData) = 561
- ncol(featureData) = 2
- No column names on the file.
- Size = 16 KB

> subject_train.txt
- nrow(subTrain) = 7352;
- ncol(subTrain) = 1;
- No column names on the file.
- Size = 20 KB

> subject_test.txt
- nrow(subTest) = 2947;
- ncol(subTest) = 1;
- No column names on the file.
- Size = 8k

> Y_train.txt
- nrow(yTrain) = 7352
- ncol(yTrain) = 1
- No column names on the file.
- Size = 16 KB

> Y_test.txt
- nrow(yTest) = 2947
- ncol(yTest) = 1
- No column names on the file.
- Size = 8 k

> X_train.txt
- nrow(xTrain) = 7352
- ncol(xTrain) = 561
- No column names on the file.
- Size = 66 MB

> X_test.txt
- nrow(xTest) = 2947
- col(mergeX) = 561
- No column names on the file.
- Size = 26.5 MB

### Transformations
- Download data from the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip;
- Loading subject_train.txt and subject_test.txt with data.table(..) function with the name "subTrain" and "subTest", respectively:
	- nrow(subTrain) = 7352;
	- ncol(subTrain) = 1;
	- ColName = V1
	- nrow(subTest) = 2947;
	- ncol(subTest) = 1;
	- ColName = V1
- Mergin subTrain and subTest into mergeSub:
	- nrow(mergeSub) = 10299;
	- ncol(mergeSub) = 1;
        - ColName = V1
- Changing Column name of table mergeSub from "V1" to "mergeSub".
- Loading Y_train.txt and Y_test.txt with data.table(..) function with the name "yTrain" and "yTest", respectively:
	- nrow(yTrain) = 7352
	- ncol(yTrain) = 1
	- ColName = V1
	- nrow(yTest) = 2947
	- ncol(yTest) = 1
        - ColName = V1
- Mergin yTrain and yTest into mergeY:
	- nrow(mergeY) = 10229
	- ncol(mergeY) = 1
	- ColName = V1
- Changing Column name of table mergeY from "V1" to "mergeY"
- Loading X_train.txt and X_test.txt with data.table(..) function with the name "xTrain" and "xTest", respectively:
	- nrow(xTrain) = 7352
	- ncol(xTrain) = 561
	- ColName = From "V1" to "V561"
	- nrow(xTest) = 2947
	- ncol(xTest) = 561
	- ColName = From "V1" to "V561"
- Mergin xTrain and xTest into mergeX:
	- nrow(mergeX) = 10229
	- ncol(mergeX) = 561
        - ColName = From "V1" to "V561" 
- Changing Column name of table mergeX from "V1" to "mergeX"
- Merging all 3 tables together mergeSub + mergeY + mergeX with the name allData:
	- nrow(allMerge) = 10299
	- ncol(allMerge) = 563 
	- ColName = "mergeSub" + "mergeY" + "mergeX" + From "V2" to "V561"
- Extracts only the measurements on the mean and standard deviation for each measurement:
- First loading the colnames from features.txt with the name featureData;
- Selecting all colnames from featureData with the string "mean" or "std" on it. Constructing
a vector "posMeanStd" with the position of the colnames selected.
- Subsetting "allData" using the vector "posMeanStd", including also the first two column of "allData". Naming this
subset as "meanAndStd"
- 	- nrow(meanAndStd) = 10299
	- ncol(meanAndStd) = 81
	- names(meanAndStd) = 
 [1] "mergeSub" "mergeY"   "mergeX"   "V2"       "V3"       "V4"       "V5"       "V6"      
 [9] "V41"      "V42"      "V43"      "V44"      "V45"      "V46"      "V81"      "V82"     
[17] "V83"      "V84"      "V85"      "V86"      "V121"     "V122"     "V123"     "V124"    
[25] "V125"     "V126"     "V161"     "V162"     "V163"     "V164"     "V165"     "V166"    
[33] "V201"     "V202"     "V214"     "V215"     "V227"     "V228"     "V240"     "V241"    
[41] "V253"     "V254"     "V266"     "V267"     "V268"     "V269"     "V270"     "V271"    
[49] "V294"     "V295"     "V296"     "V345"     "V346"     "V347"     "V348"     "V349"    
[57] "V350"     "V373"     "V374"     "V375"     "V424"     "V425"     "V426"     "V427"    
[65] "V428"     "V429"     "V452"     "V453"     "V454"     "V503"     "V504"     "V513"    
[73] "V516"     "V517"     "V526"     "V529"     "V530"     "V539"     "V542"     "V543"    
[81] "V552" 

- Uses descriptive activity names to name the activities in the data set:
- Loading labels from activity_labels.txt with the name activityNames.
	- nrow(activityNames) = 6
	- ncol(activityNames) = 2
	- names(activityNames) = "V1" "V2"
- Changing activityNames col names from "V1" "V2" to "mergeY"     "Activities";
- Setting "mergeY" as key of the table "meanAndStd";
- Setting "mergeY" as key of the table "activityNames";
- Merging "meanAndStd" and "activityNames" by the key "mergeY". Adding a new col with the name "Activities" into "meanAndStd".
	- nrow(meanAndStd) = 10229
	- ncol(meanAndStd) = 82
- Appropriately labels the data set with descriptive variable names:
- Changing "meanAndStd" col names to:
 [1] "Activity_ID"                   "Subject"                      
 [3] "tBody_Acc_mean_X"              "tBody_Acc_mean_Y"             
 [5] "tBody_Acc_mean_Z"              "tBody_Acc_std_X"              
 [7] "tBody_Acc_std_Y"               "tBody_Acc_std_Z"              
 [9] "tGravity_Acc_mean_X"           "tGravity_Acc_mean_Y"          
[11] "tGravity_Acc_mean_Z"           "tGravity_Acc_std_X"           
[13] "tGravity_Acc_std_Y"            "tGravity_Acc_std_Z"           
[15] "tBody_Acc_Jerk_mean_X"         "tBody_Acc_Jerk_mean_Y"        
[17] "tBody_Acc_Jerk_mean_Z"         "tBody_Acc_Jerk_std_X"         
[19] "tBody_Acc_Jerk_std_Y"          "tBody_Acc_Jerk_std_Z"         
[21] "tBody_Gyro_mean_X"             "tBody_Gyro_mean_Y"            
[23] "tBody_Gyro_mean_Z"             "tBody_Gyro_std_X"             
[25] "tBody_Gyro_std_Y"              "tBody_Gyro_std_Z"             
[27] "tBody_Gyro_Jerk_mean_X"        "tBody_Gyro_Jerk_mean_Y"       
[29] "tBody_Gyro_Jerk_mean_Z"        "tBody_Gyro_Jerk_std_X"        
[31] "tBody_Gyro_Jerk_std_Y"         "tBody_Gyro_Jerk_std_Z"        
[33] "tBody_Acc_Mag_mean"            "tBody_Acc_Mag_std"            
[35] "tGravity_Acc_Mag_mean"         "tGravity_Acc_Mag_std"         
[37] "tBody_Acc_Jerk_Mag_mean"       "tBody_Acc_Jerk_Mag_std"       
[39] "tBody_Gyro_Mag_mean"           "tBody_Gyro_Mag_std"           
[41] "tBody_Gyro_Jerk_Mag_mean"      "tBody_Gyro_Jerk_Mag_std"      
[43] "fBody_Acc_mean_X"              "fBody_Acc_mean_Y"             
[45] "fBody_Acc_mean_Z"              "fBody_Acc_std_X"              
[47] "fBody_Acc_std_Y"               "fBody_Acc_std_Z"              
[49] "fBody_Acc_mean_Freq_X"         "fBody_Acc_mean_Freq_Y"        
[51] "fBody_Acc_mean_Freq_Z"         "fBody_Acc_Jerk_mean_X"        
[53] "fBody_Acc_Jerk_mean_Y"         "fBody_Acc_Jerk_mean_Z"        
[55] "fBody_Acc_Jerk_std_X"          "fBody_Acc_Jerk_std_Y"         
[57] "fBody_Acc_Jerk_std_Z"          "fBody_Acc_Jerk_mean_Freq_X"   
[59] "fBody_Acc_Jerk_mean_Freq_Y"    "fBody_Acc_Jerk_mean_Freq_Z"   
[61] "fBody_Gyro_mean_X"             "fBody_Gyro_mean_Y"            
[63] "fBody_Gyro_mean_Z"             "fBody_Gyro_std_X"             
[65] "fBody_Gyro_std_Y"              "fBody_Gyro_std_Z"             
[67] "fBody_Gyro_mean_Freq_X"        "fBody_Gyro_mean_Freq_Y"       
[69] "fBody_Gyro_mean_Freq_Z"        "fBody_Acc_Mag_mean"           
[71] "fBody_Acc_Mag_std"             "fBody_Acc_Mag_mean_Freq"      
[73] "fBody_Acc_Jerk_Mag_mean"       "fBody_Acc_Jerk_Mag_std"       
[75] "fBody_Acc_Jerk_Mag_mean_Freq"  "fBody_Gyro_Mag_mean"          
[77] "fBody_Gyro_Mag_std"            "fBody_Gyro_Mag_mean_Freq"     
[79] "fBody_Gyro_Jerk_Mag_mean"      "fBody_Gyro_Jerk_Mag_std"      
[81] "fBody_Gyro_Jerk_Mag_mean_Freq" "Activity_Name" 

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
- Set columns from 3 to penultimate as measure variables;
- Set columns "Subject","Activity_ID","Activity_Name" as Ids;
- Melting "meanAndStd" with the ids and measure variables defined. Creating "dataMelt" variable;
- CASTING "dataMelt" using the formula Subject + Activity_Name ~ variable and the agglomerate function mean.
	- nrow(tidyData) = 180
	- ncol(tidyData) = 81
