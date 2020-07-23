library(dplyr)

# test data

setwd("C:/Users/DEL/Downloads")
Test_X<- read.table("./UCI HAR Dataset/test/X_test.txt")
Test_Y<- read.table("./UCI HAR Dataset/test/Y_test.txt")
Text_sub<- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Train data

Train_X<- read.table("./UCI HAR Dataset/train/X_train.txt")
Train_Y<- read.table("./UCI HAR Dataset/train/Y_train.txt")
Train_sub<- read.table("./UCI HAR Dataset/train/subject_train.txt")

# data descriptions
features.list<- read.table("./UCI HAR Dataset/features.txt")

# activity labels
activity_label<- read.table("./UCI HAR Dataset/activity_labels.txt")

#Merges the training and the test sets to create one data set.
Total_x<- rbind(Test_X,Train_X)
Total_Y<- rbind(Test_Y,Train_Y)
Total_sub<- rbind(Text_sub,Train_sub)

#Extracts only the measurements on the mean and standard deviation for each measurement.

req_col<- grep("mean|std",features.list$V2)
req_X<- Total_x[,req_col]

# Uses descriptive activity names to name the activities in the data set and label the dataset

colnames(Total_Y)<- "activity"
Total_Y$activity <- factor(Total_Y$activity,labels = activity_label[,2])
colnames(Total_sub)<- "Subject"
Total_sub$Subject<- as.factor(Total_sub$Subject)

colnames(req_X)<-(features.list[req_col,2])
colnames(Total_sub)<- "Subject"

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

class(total_grp)
str(total_grp)
total<- cbind(Total_Y,Total_sub,req_X)
total_grp<- group_by(total,activity,Subject)
total_grp
total_mean<- summarize_each(total_grp,funs(mean))                     

read.table(total_mean,"./UCI HAR Dataset/final dataset.txt",row.names = F)

