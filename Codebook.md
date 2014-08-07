# Introduction

This is the script `run_analysis.R`
- merges the training and test sets to create one data set
- appropriately labels the X data set columns (561) with descriptive names
- names the columns for activity and subject properly
- extracts only the mean measurements (features) for each measurement
- extracts only the std measurements (features) for each measurement
- replaces `activity` values in the dataset with descriptive activity names
- creates a second, independent tidy dataset with an average of each variable
  for each each acticity and subject i.e. group over activity and subject. 
- The second tidy data set is written to a csv file.
- The second tidy data set is written to standard output.
  
# The original data set

The original test and train data sets are loaded into the following variables
X_train, X_test
y_train, y_test
subject_train, subject_test

# Merging the train and test data sets

The above original sets and then merged into the following variables
X_merged
y_merged
subject_merged
These 3 are then collected into 1 list (merged) with 3 named elements (X, y, subject)

# Naming the features with the proper names from features.txt

features - Features from features.txt are loaded into this variable
mean_features - The features having the word "mean" are extracted into this variable
std_features - The features having the word "std" are extracted into this variable (standard deviations)

# Extract the means and standard deviations only from the merged dataset
Using the above mean_features and std_features variables, the measurements for these variables only are extracted from the 
merged X data set (merged$X) and populated into X_mean and X_std variables

# Replacing activity numbers by activity labels
The activity_labels.txt file contains the descriptions for the activity values. There are only 6 of them which are used to replace the
activity values in the merged dataset (X$activity)

# The first version of tidy_data 
The individual data sets are now combined column-wise (cbind) and populated into the variable tidy_data

# Compute the averages by subject and activity from above tidy data
The variable tidy_data_avg is now populated with the summarized data which is obtained using the ddply method of the plyr library which
is used to loop thru the tidy_data variable and apply the colMeans method to all columns in it except the subject and activity which are
used to group the data. 

# FInally the tidy_data_avg is printed to standard output
tidy_data_avg has 180 records (barring the header), 6 for each of the 30 subjects and 79 metrics for the means and standard deviations

