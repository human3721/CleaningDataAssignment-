temp<-tempfile()
# download the file
url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url1, temp)
# unzip the file
unzip(temp)
unlink(temp)

#load the dataset from txt files
## load the measurement features
features<-read.table("./UCI HAR Dataset/features.txt", sep=" ")
## load the activity labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")
## load the test data
test_set<-read.table("./UCI HAR Dataset/test/X_test.txt", header = F)
test_labels<-read.table("./UCI HAR Dataset/test/y_test.txt", sep=" ",header = F)
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt", sep=" ",header = F)
## load the training data
train_set<-read.table("./UCI HAR Dataset/train/X_train.txt", header = F)
train_labels<-read.table("./UCI HAR Dataset/train/y_train.txt", sep=" ",header = F)
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt", sep=" ",header = F)

test_set1<-test_set 
## label the column as different the measurment features
names(test_set1)<-features$V2
## add and label subject,activity, and group columns
test_set1$subject <- test_subject$V1
test_set1$activity <- test_labels$V1
test_set1$group<-rep("test",nrow(test_set1))
## bring the subject,activity, and group columns to the front
test_set1<-test_set1[,c(ncol(test_set1),(ncol(test_set1)-1),(ncol(test_set1)-2),1:(ncol(test_set1)-3))]

train_set1<-train_set
## lables the column as different the measurment features
names(train_set1)<-features$V2
## add and label subject,activity, and group columns
train_set1$subject <- train_subject$V1
train_set1$activity <- train_labels$V1
train_set1$group<-rep("train",nrow(train_set1))
## bring the subject,activity, and group columns to the front
train_set1<-train_set1[,c(ncol(train_set1),(ncol(train_set1)-1),(ncol(train_set1)-2),1:(ncol(train_set1)-3))]

# 1. Merges the training and the test sets to create one data set.
library(utils)
merged_data <- merge(train_set1,test_set1, all=TRUE) 
names(merged_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
row_names<-names(merged_data)
## select the columns with mean() or std() column names + the first 3 columns
selectred_row<-c("group","activity","subject",row_names[grepl("mean\\(|std\\(", row_names)])
merged_data2<-merged_data[selectred_row]
names(merged_data2)

# 3. Uses descriptive activity names to name the activities in the data set
## merge the activity labels with the pervious data frame 
merged_data3<- merge(activity_labels, merged_data2,by.x = "V1",by.y = "activity", all = TRUE)
## delete the original activity  column
merged_data3<- merged_data3[,-1]
## change the column name to "activity"
colnames(merged_data3)[1]<-"activity"
summary(merged_data3$activity)

# 4. Appropriately labels the data set with descriptive variable names.
merged_data4<-merged_data3
row_names2<-names(merged_data4)
## change the column names to be more meaningful (descriptive)
row_names2<-gsub("^tBody","time_body_",row_names2)
row_names2<-gsub("^(fBody|fBodyBody)","frequency_body_",row_names2)
row_names2<-gsub("^tGravity","time_gravity_",row_names2)
row_names2<-gsub("Acc","accelerometer_",row_names2)
row_names2<-gsub("Gyro","gyroscope_",row_names2)
row_names2<-gsub("Jerk","jerk_signal_",row_names2)
row_names2<-gsub("Mag","magnitude_",row_names2)
row_names2<-gsub("accelerometer_-mean\\(\\)","accelerometer_singnal_mean",row_names2)
row_names2<-gsub("accelerometer_-std\\(\\)","accelerometer_singnal_standard_deviation",row_names2)
row_names2<-gsub("gyroscope_-mean\\(\\)","gyroscope_singnal_mean",row_names2)
row_names2<-gsub("gyroscope_-std\\(\\)","gyroscope_singnal_standard_deviation",row_names2)
row_names2<-gsub("-mean\\(\\)","mean",row_names2)
row_names2<-gsub("-std\\(\\)","standard_deviation",row_names2)
# update the dataset column names
names(merged_data4)<-row_names2
names(merged_data4)

#5. From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.

## select the mean cloumns + acticity and subject columns
selectred_row2<-c("activity","subject",row_names2[grepl("mean", row_names2)])
merged_data5<-merged_data4[selectred_row2]

## stack all the measurement feature columns. names it "variable"   
library(reshape2)
data_melt<-melt(merged_data5,id=c("activity", "subject"),measure.vars = names(merged_data5)[-c(1,2)])
colnames(data_melt)[3]<-"variable" 

## tabulate the means of each variable for each activity and each subject
library(dplyr)
## Columns I want to group by
grp_cols<-names(data_melt)[-4]
## Convert character vector to list of symbols
dots <- lapply(grp_cols, as.symbol)
data_melt2<-group_by_(data_melt,.dots=dots)
## find the mean
final_table<-summarize(data_melt2, value=mean(value,na.rm=TRUE))
colnames(final_table)[4]<-"mean"
final_table
## explorting the data
write.csv(final_table,file="./final_mean_table.csv")
