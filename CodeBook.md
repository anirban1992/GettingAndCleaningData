Original data source: 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

The R script (run_analysis.R) performs the following tasks: 

* Merges the training and test sets to create one data set, namely
  train/X_train.txt and test/X_test.txt -> a 10299 x 561 data frame,
  train/y_train.txt with test/y_test.txt -> a 10299 x 1 data frame with activity IDs.
  train/subject_train.txt with test/subject_test.txt ->  a 10299 x 1 data frame with subject IDs

* Extracts only the measurements on the mean and standard deviation for each measurement.
  (with the help of features.txt)  
  The result is a 10299 x 66 data frame (as 66 attributes are based on mean and std)

* Applies descriptive activity names to name the activities in the data set.
  (with the help  of activity_labels.txt)

* Replaces the activity IDs with activity names, and merges the activity data, subject data and
  data obtained from step 2.
  (
	which results in a 10299 * 68 data frame,
	1st column shows subject ID,
	2nd column shows activity names,
	the rest 66 columns show measurements
  )
	 
* At last, the script creates a 2nd, independent tidy data set with the average
  of each measurement for each activity and each subject.
  The resultant data is saved as tidy_data.txt (a data frame of 180*68)
  
# To know more about the data, go to:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
