#set working directory
setwd("~/Desktop/DataScienceSpecialization/Course3/CourseProject/UCIHARDataset/")

library(data.table)
library(plyr)
library(dplyr)

# 1 Merges the training and the test sets to create one data set
  #Reading Data files into R
features <- read.table("./features.txt", header = FALSE)
activity_labels <- read.table("./activity_labels.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header=FALSE)
x_test <- read.table("./test/X_test.txt", header=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE)
  #Add variable names to data
colnames(activity_labels) <- c("activityID", "activityType")
colnames(subject_train) <- "subID"
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_test) <- "subID"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
  #Merge data together
train_data <- cbind(y_train, subject_train, x_train)
test_data <- cbind(y_test, subject_test, x_test)
final_data <- rbind(train_data, test_data)

# 2 Extracts only the measurements on the mean and standard deviation for each measurement
data_mean_std <- final_data[, grepl("mean|std|subID|activityID", colnames(final_data))]

# 3 Uses descriptive activity names to name the activities in the data set
data_mean_std <- merge(data_mean_std, activity_labels, by = "activityID")
data_mean_std <- data_mean_std[,-1]
data_mean_std <- data_mean_std[,c(81,1:80)]

# 4 Appropriately labels the data set with descriptive variable names
names(data_mean_std) <- make.names(gsub("[()]", "", colnames(data_mean_std)))
names(data_mean_std) <- gsub("Acc", "Acceleration", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("mean", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "Std", names(data_mean_std))
names(data_mean_std) <- gsub("Freq", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))

# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
avg_mean_std <- ddply(data_mean_std, c("subID", "activityType"), numcolwise(mean))
setwd("~/Desktop/DataScienceSpecialization/Course3/CourseProject/")
write.table(avg_mean_std,file="tidydata.txt")





