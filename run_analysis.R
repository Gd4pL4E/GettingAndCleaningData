##################################
#___________Assignment___________#
##################################

#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Data:
#Direct link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#Description of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##################################
#______________Code______________#
##################################

###First we need to download the .zip file and unzip it to be able to use its contents for this analysis
#There should now be a folder in the working directory called "UCI HAR Dataset" which contains all the files that were in the .zip file.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
unzip("dataset.zip")


###First, we need to create the datasets (they are currently seperates each in 3 .txt files)
#Make sure dplyr and tidyr are inistalled (and their dependencies)

#Reading the files for test. 'activity' is saved as a vector to edit in the next step
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity <- read.table("UCI HAR Dataset/test/y_test.txt")[,1]
dataset <- read.table("UCI HAR Dataset/test/X_test.txt")

#Transforming activities to factors instead of integers, with the correct names (= levels)
activity <- as.factor(activity)
levels(activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
activity <- as.data.frame(activity)

#Coming the three data frames into one
library(dplyr)
test.df <- bind_cols(subjects, activity, dataset)

#Doing the last 3 staps for the train files
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
activity <- read.table("UCI HAR Dataset/train/y_train.txt")[,1]
dataset <- read.table("UCI HAR Dataset/train/X_train.txt")

activity <- as.factor(activity)
levels(activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
activity <- as.data.frame(activity)

library(dplyr)
train.df <- bind_cols(subjects, activity, dataset)
