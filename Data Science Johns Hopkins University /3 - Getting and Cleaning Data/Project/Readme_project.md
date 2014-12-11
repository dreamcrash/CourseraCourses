## Project of Getting and Cleaning Data

> You should create one R script called run_analysis.R that does the following. 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation 
for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each 
 variable for each activity and each subject. 

### Run the script run_analysis.R

This script will first install the packages, in case the packages aren't already install on the system :
- data.table;
- reshape2.

The script will then load the following libraries:
- data.table
- reshape2.

Work done by the script:
> 1) Merges the training and the test sets to create one data set:
- The script will download and unzip the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
into the work directory.
- Will merge by rows the tables in the files subject_train.txt and subject_test.txt into one table;
- Will merge by rows the tables in the files Y_train.txt and Y_test.txt into one table;
- Will merge by rows the tables in the files X_train.txt and X_test.txt into one table;
- Finally, it will merge by columns the three above tables into one single table, called "allData".

> 2) Extracts only the measurements on the mean and standard deviation    
for each measurement:
- The script will load the table from features.txt;
- Will calculate a vector "posMeanStd" with the position which the columns names (of the table loaded from file features.txt) have "mean" or "std" on it;
- Will subset the "allData" table keeping the first two columns and the columns corresponding to the vector "posMeanStd". Creating a new table called "meanAndStd".

> 3)  Uses descriptive activity names to name the activities in the data set:
- Load the table from activity_labels.txt;
- Merge this table with the table "meanAndStd".

> 4) Appropriately labels the data set with descriptive variable names:
- The script will perform a series of modifications to the columns names of the table "meanAndStd":
	- Converte all "-" into "_";
	- Removing "()";
	- Removing redudante names (e.g BodyBody to Body);
	- Changing "Acc" to "Acc_";
	- Changing "Body" to "Body_";
	- Changing "Gyro" to "Gyro_";
	- Changing "Jerk" to "Jerk_";
	- Changing "meanFreq" to "mean_Freq";
	- Change the names of the first two columns to Activity_ID and Subject.

> 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- All the columns from "meanAndStd" table with the exception of the first two and the last one, will be considered measure Variables;
- Meting "meanAndStd" using the measure variables defined and as Id the columns "Subject", "Activity_ID" and "Activity_Name". Creating a new variable dataMelt.
- Then the script will Cast the "dataMelt" using the formula : Subject + Activity_Name ~ variable. And the aggregate function mean.
- Finally, the script will save the new tidy data into a file called tidyData.txt.
