# getdata-006
# run_analysis.R
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# load library plyr for looping logic to calculate averages in step 5 above
library(plyr)

# read the training data sets
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# read the test data sets
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# 1. Merges the training and the test sets to create one data set.
X_merged <- rbind(X_train, X_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

# Name the columns for activity and subject appropriately, the columns for X (feature variables will be named later)
colnames(y_merged) <- "activity"
colnames(subject_merged) <- "subject"

merged <- list(X = X_merged, y = y_merged, subject = subject_merged)

# Extract mean and standard deviations only
# There are a total of 561 measurements of which quite a few are mean's and std's
# To programmatically get these measurements we use the features.txt to get the list of means and stds
# First read the full set of feature variable names from features.txt
features <- read.table("UCI HAR Dataset/features.txt")

# Name the feature variable columns (X_merged) appropriately, 
# this was deferred earlier when we named the y_merged and subject_merged columns
colnames(features) <- c("feature_no", "feature_name")
names(merged$X) <- features$feature_name

# Get only the mean variables
mean_features <- grep("mean", features$feature_name, value=TRUE)

# Get only the std variables
std_features <- grep("std", features$feature_name, value=TRUE)

# Get only the means and stds from the merged X data set
X_mean <- merged$X[mean_features]
X_std <- merged$X[std_features]

# Get the list of activities and replace the numbers to labels in the merged$y data 
# This is from the activity_labels.txt
merged$y[merged$y$activity == 1,] <- "WALKING"
merged$y[merged$y$activity == 2,] <- "WALKING_UPSTAIRS"
merged$y[merged$y$activity == 3,] <- "WALKING_DOWNSTAIRS"
merged$y[merged$y$activity == 4,] <- "SITTING"
merged$y[merged$y$activity == 5,] <- "STANDING"
merged$y[merged$y$activity == 6,] <- "LAYING"

# Create the first version of the tidy_data
tidy_data <- cbind(X_mean, X_std, merged$y, merged$subject)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_data_avg <- ddply(tidy_data, .(subject, activity), function(x) colMeans(x[,1:79]))
# Write this to a CSV file
write.csv(tidy_data_avg, "UCI HAR Dataset/UCI_HAR_tidy_avg_data.csv", row.names=FALSE)
