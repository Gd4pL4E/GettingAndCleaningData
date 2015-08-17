##################################
#___________Assignment___________#
##################################

#You should create one R script called run_analysis.R that does the following. 

#1: Merges the training and the test sets to create one data set.
#2: Extracts only the measurements on the mean and standard deviation for each measurement. 
#3: Uses descriptive activity names to name the activities in the data set
#4: Appropriately labels the data set with descriptive variable names. 
#5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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


###"Step 1": create the datasets (they are currently seperates each in 3 .txt files) and combine to one big dataset
#Make sure the packages dplyr, tidyr and data.table are inistalled (and their dependencies)

#Reading the files for test. 'activity' is saved as a vector to edit in the next step
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")[,1]
activity <- read.table("UCI HAR Dataset/test/y_test.txt")[,1]
dataset <- read.table("UCI HAR Dataset/test/X_test.txt")

#Making subjects a character string instead of an integer (the values aren't counts, just the ID of the subject)
#And making it a data.frame
subjects <- as.numeric(subjects)
subjects <- as.data.frame(subjects, stringsAsFactors = FALSE)

#Transforming activities to factors instead of integers, with the correct names (= levels)
#Note that this is "Step 3"
activity <- as.factor(activity)
levels(activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
activity <- as.data.frame(activity)

#The idea was to also at the labels at this point. However, because some column names are the same this will
#Be an issue when combining the two datasets at a later stage

#Combining the three data frames into one
library(dplyr)
test.df <- bind_cols(subjects, activity, dataset)

#Doing the last 3 staps for the train files
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")[,1]
activity <- read.table("UCI HAR Dataset/train/y_train.txt")[,1]
dataset <- read.table("UCI HAR Dataset/train/X_train.txt")

subjects <- as.numeric(subjects)
subjects <- as.data.frame(subjects, stringsAsFactors = FALSE)

activity <- as.factor(activity)
levels(activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
activity <- as.data.frame(activity)

#We skip setting 'labels' again, because the labels are the same for 'test' and 'train'
colnames(dataset) <- labels

library(dplyr)
train.df <- bind_cols(subjects, activity, dataset)

#To make thinks faster, we start using data.table instead of data.frame
#For more information see ?data.table after (down)loading the package
library(data.table)
test.dt <- data.table(test.df)
train.dt <- data.table(train.df)

#Before we combine these two tables, we need a variable, called "type", so we know which observations
#are from 'test' and which are from 'train', we also change the position of this variable so it comes
#before the numerical data
test.dt <- mutate(test.dt, type = "TEST") 
test.dt <- select(test.dt, subjects, activity, type, everything())
train.dt <- mutate(train.dt, type = "TRAIN")
train.dt <- select(train.dt, subjects, activity, type, everything())

#Now we can combine these two datasets, and make sure 'subjects' and 'type' are factors
complete.data <- bind_rows(list(test.dt, train.dt))
complete.data$subjects <- as.factor(complete.data$subjects)
complete.data$type <- as.factor(complete.data$type)

#And now we can also add the column names for the numerical data
#Note that the labels need to be made unique, because dplyr doesn't know what to do with duplicate
#column names
labels <- as.character(read.table("UCI HAR Dataset/features.txt")[,2])
labels <- make.unique(labels)
colnames(complete.data) <- c("subjects", "activity", "type", labels)

###"Step 2": Extract only the mean and sd values from the dataset
#We use dplyr's select function to get the factorial data ('subjects', 'activity' and 'type')
#and the mean and sd of the numerical data. We do this by looking for the string "-mean()" and "-std()"
selected.data <- select(complete.data, subjects:type, contains("-mean()"), contains("-std()"))

###"Step 3" is done at an earlier point, to already be complete from the start.
#You can use ctrl + f and look for "Step 3" to find it.

###"Step 4": Appropriately labels the data set with descriptive variable names
#Note that this is done already. First 3 column names (subject, activity, type) were named
#The numerical data has been labeled at step 2. And the activities have been labeled appropriately

###"Step 5": Create a tidy data set with only the means for each numerical variable, by subjects and activity
#First we group the factors, because we don't want these to be sumarised, i.e. taken the mean of
selected.data.means <- group_by(selected.data, subjects)
selected.data.means <- group_by(selected.data.means, activity, add = TRUE)
selected.data.means <- group_by(selected.data.means, type, add = TRUE)
#Then we summarize the data by only showing the means for the numerical values
tidy.data <- summarise_each(selected.data.means, funs(mean))

#Now we sort the data to make it look nice, we first ungroup the dataset, so arrange will work without interference
tidy.data2 <- ungroup(tidy.data)
tidy_data <- arrange(tidy.data2, type, subjects, activity)

#And finally, we write the table to a .txt file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
write.csv(tidy_data, "tidy_data.csv")
