Codebook
========

###About

This document is the codebook for the run_analysis.R script and all other information that is needed to get a clear information of what data is used, how the data has been modified and the reasons for the modifications that are made.

###Index

You will find the following sections in this CodeBook

	1. Raw data and the experimental design used to get this data
	2. Variables and units of the tidy data set created
	3. Analysis done by the scipt, the made choices and motivation for it does

###1: Raw data and the experimental design used to get this data

The dataset can be downloaded by clicking [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). (It is automatically downloaded when running run_analysis.R)

####Experimental Design used to get the raw data [(source)](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):
*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*

You may also want to check the [example video](http://www.youtube.com/watch?v=XOEN9W05_4A).

####Variables and units of original data:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

#####Notes:

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

###2: Variables and units of the tidy dataset

The variables are the same as for the original dataset (so you can find the information in README.txt, features.txt and features_info.txt in the original dataset), except for a few key differences:

- Only the means and the standard deviations of the features have been selected.
- The values of each replication are averaged, so there is only one value for every combination of subject and activity. In other words, all the values for subject '2' for activity 'WALKING' have been taken the mean of and only this mean is shown in the file tidy_data.txt.

Units are unchanged and are still the same as in the original dataset.

The factors have undergone some minor changes:
- Values for the variable 'activity' were integers in original dataset, here they are named (e.g. "1" is now "WALKING"). Names were taken from 'activity_labels.txt' from the original dataset.
- Because we combined the data for the 'test' and 'train' subjects, a new variable called 'type' was created. Subjects who were part of the test group are labeled "TEST" under this variable and subjects from the train group are labeled "TRAIN".

Information about how and why this dataset was created can be found in the next section.

###3: Analysis done by the scipt, the made choices and motivation for it

In this section, the script will be discussed globally. The script itself has many comments to explain what is done. For the codebook, the focus will mostly be on the significant decisions that were made and why (i.e. not every line of the code will be discussed). Parts of run_analysis.R will be quoted using backticks, so it is easy to find the line which is referred to in this section.

`#Transforming activities to factors instead of integers, with the correct names (= levels)`
`#Note that this is "Step 3"`

When working on the script I neglected the seperate steps and tried to get from starting to end point, because of this some steps are not in order. The advantage of making the factors look like they should before hand, is that the seperate data sets can also be used for statistics without having to make a new script.

`#To make thinks faster, we start using data.table instead of data.frame`

From the documentation: "data.table inherits from data.frame. It offers fast subset, fast grouping, fast update, fast ordered joins and list columns in a short and flexible syntax, for faster development. It is inspired by A[B] syntax in R where A is a matrix and B is a 2-column matrix. Since a data.table is a data.frame, it is compatible with R functions and packages that only accept data.frame."

`#Before we combine these two tables, we need a variable, called "type", so we know which observations`

The word 'type' was chosen for its ease in the script (only 4 characters) and being clear enough. The meaning should be clear from both the script, and the explenation in section 2 of this codebook.

`###"Step 2": Extract only the mean and sd values from the dataset`
`#We use dplyr's select function to get the factorial data ('subjects', 'activity' and 'type')`
`#and the mean and sd of the numerical data. We do this by looking for the string "-mean()" and "-std()"`

The assignment asks for both the standard deviation and the mean. However, in the dataset there are two kinds of means. The first 'mean' is one of the estimate variables of all the features. The other 'mean' directs to additional vectors made based on the angle variables.

To me it made most sense for this dataset to be used for statistical analysis and possible plotting by using the mean and sd variables (meaning you can do statistical comparisons with this). Since the other 'mean' variables are a different kind of data (based on the other vectors), I chose not to include these variables in the final dataset.

For the same reason "~meanFreq()" was not included.

`###"Step 4": Appropriately label the data set with descriptive variable names`
`#Note that this is done already. First 3 column names (subject, activity, type) were named`
`#The numerical data has been labeled at step 2. And the activities have been labeled appropriately`

The first 3 columns should be clear already from the script, or otherwise from section two from this codebook. However, the column names for the following columns are a bit more complicated. I made the choice not to change these variable names to not cause confusion when reading the original data files and when reading the README.xt, features.txt and features_info.txt of the original dataset. 
It would be possible to remove the brackets "()" and write Acc and Gyro in full, but readability is only slightly improved while losing compatibility with the original dataset.

`###"Step 5": Create a tidy data set with only the means for each numerical variable, by subjects and activity`

One note about the last step. I chose to order the dataset first by type (i.e. if the subject is part of the test group or not), and *then* by subject. Since these are the main groups you will likely compare with each other (i.e. if you would do a t-test), it is visually possible to get some idea. I still kept it as the last factor of the three, because if you look for a specific case you would more likely look for the subject and the activity first.
