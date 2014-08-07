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
  
# run_analysis.R

This is the R code that performs all the operations describe above. It loads the 'plyr' library initially which it uses later to perform the 
operation of calculation means/averages across the first tidy data set.

# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition is also split into three files that contain
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject

# Getting and cleaning data

The first step of the preprocessing is to merge the training and test
sets. Two sets combined, there are 10,299 instances where each
instance contains 561 features (560 measurements and subject identifier). After
the merge operation the resulting data, the table contains 562 columns (560
measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted
for further processing. Out of 560 measurement features, 46 mean and 33 standard
deviations features are extracted, yielding a data frame with 79 features
(additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 66 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 79 columns.
The tidy data set is exported to `UCI_HAR_tidy_data_avg.csv` where the first row is the
header containing the names for each column.
