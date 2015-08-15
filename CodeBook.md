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

The variables are the same as for the original dataset, except for a few key differences:

- Only the means and the standard deviations of the features have been selected.
- The values of each replication are averaged, so there is only one value for every combination of subject and activity. In other words, all the values for subject '2' for activity 'WALKING' have been taken the mean of and only this mean is shown in the file tidy_data.txt.

Units are unchanged and are still the same as in the original dataset.

The factors have undergone some minor changed:
- Values for the variable 'activity' were integers in original dataset, here they are named (e.g. "1" is now "WALKING"). Names were taken from 'activity_labels.txt' from the original dataset.
- Because we combined the data for the 'test' and 'train' subjects, a new variable called 'type' was created. Subjects who were part of the test group are labeled "TEST" under this variable and subjects from the train group are labeled "TRAIN".

Information about how and why this dataset was created can be found in the next section.

###3: Analysis done by the scipt, the made choices and motivation for it

...
