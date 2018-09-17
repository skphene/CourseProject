### run_analysis.R and UCIHARDataset

### Read in data from UCIHARDataset into R and Merge into single table 
features : Description(label) of each variables in X_test and X_train

activity_labels : Description of activity IDs in y_test and y_train

subject_train : subject IDs for train

X_train : values of variables in train

y_train : activity ID in train

subject_test : subject IDs for test

X_test : values of variables in test

y_test : activity ID in test

train_data : bind of y_train, subject_train, X_train data sets

test_data : bind of y_test, subject_test, X_test data sets

final_data : bind of test and train data sets

### Extract only measurements on the mean and standard deviation
data_mean_std : subset of final_data, only including measurements on the mean and standard deviation for each variable

### Uses descriptive activity names to name the activities in the data set
Merge data_mean_std with activity_labels to include each observation's activity type

### Appropriately label the data set with descriptive variable names
Clean up column (variable) names using gsub() function

### Create tidy data set with the average of each variable for each activity and each subject
avg_mean_std : Means of each variable by subject and activity using ddply function

Write out avg_mean_std table as a .txt file called tidydata.txt


