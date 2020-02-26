#Include neccessary libraries to utilize data tables and dplyr packages
library(data.table)
library(dplyr)


#Create a directory, download and unzip data
if(!file.exists("./Datasetzp")){
  dir.create("./Datasetzp")
  
  
  file.url <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  download.file(file.url,"Datasetzp.zip")
}
if(!file.exists("UCI HAR Dataset")){
  unzip("Datasetzp.zip")
}

#Read training and test data,activity label and subject indentification.
#Store data as data table

train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_label <-read.table("UCI HAR Dataset/train/y_train.txt")
train_sub <-read.table("UCI HAR Dataset/train/subject_train.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_label <-read.table("UCI HAR Dataset/test/y_test.txt")
test_sub <-read.table("UCI HAR Dataset/test/subject_test.txt")

#read variable labels
variables<-read.table("UCI HAR Dataset/features.txt")

#read activity names and associated numerical labels
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

#Merge data set by annexing training dataset below testing data set
data_set<-rbind(test_data,train_data)

#Merge subject indetification for each row/observation in training and test data
subjets<-rbind(test_sub,train_sub)

#Merge activity label for each row/observation in training and test data
data_label<-rbind(test_label,train_label)

#Extracts only the measurements on the mean and standard deviation for each measurement using regular expression.
#The regular expression function looks for mean or std followed by open-close parenthesis specifically to avoid including meanFreq variables.
#Use indecies for mean and standard deviation from variable labels of merged data set to extract the corresponding columns in the merged measurment data

indices<- grep(c("mean[()]|std[()]"),variables$V2)
data_set<-data_set[,indices]

#Use descriptive activity names to name the activities in the merged data label
#Catagorize the activity using the 6 activity names as labels for the factor levels
colnames(activity)= c("Class Label","Activity")
colnames(data_label) = c("Activity")
data_label$Activity<-factor(data_label$Activity,labels = activity$Activity)

#label columns of the data set with descriptive variable names.

colnames(data_set) = variables$V2[indices]
colnames(subjets) = "Subjects"
K<-cbind(subjets,data_label)
data_set<-cbind(K,data_set)

#create a second, independent tidy data set with the average of each variable for each activity and each subject.
#Group data by subjects first and then by activity, take the mean summary
#Write the summary to a text file

average_tidy_data<-summarize_all(group_by(data_set,Subjects,Activity),funs (mean))
write.table(average_tidy_data,file="./Datasetzp/tidy_data.txt",sep = " ", row.names = FALSE, col.names = TRUE,)
