---
title: 'README: Getting and Cleaning data'
author: "Mussie Araya"
date: "2/25/2020"
output: html_document
---

# **Mission Statement of Project**. 
The R script submitted  called run_analysis.R downloads, unzips, reads a raw data and creates a tidy data set with the average of  observations (each activity performed by each subject) for each variable in the raw data. To produce a tidy data, the R script first merges the training and the test sets to create one data set. The script then extracts only the measurements on the mean and standard deviation for each measurement. The script assigns descriptive activity names to name the activities in the data set. The script also  labels the data set with descriptive variable names.

## Getting Raw and Associated Data Files, Production of Tidy Data and Writing Transformed Tidy Data

This script downloads the zip file stored at, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
in directory called Datasetzp. The directory is created if it does not exist in the working directory. The script unzips the downloaded data.  The script avoids unzipping if the file UCI HAR Dataset is already present in the current directory.

The downloaded data consists of training and test data sets with 2967and 7392 observations respectively. The data sets consist of 561 columns that include measured and computed variables. The data was collected from 30 subject performing one of 6 activities. The subject and activity information for each data sets are stored in separate files.

- The test and train raw data is located in **UCI HAR Dataset/test/X_test.txt** and **UCI HAR Dataset/train/X_train.txt**.  
- The names of the variables are stored in a file called **features.txt** located in the UCI HAR Dataset folder. The file had 561 entries that correspond to the 561 variables of the test and train data sets.  
- The subject files are found in **UCI HAR Dataset/train/subject_train.txt** and **UCI HAR Dataset/test/Subject_test.txt** respectively.  
- The names six activities and their corresponding numerical label are found in activity_labels.txt.   
- The activities performed during each observation are found in **UCI HAR Dataset/test/Y_test.txt** and **UCI HAR Dataset/train/Y_train.txt**. 

 
The script **run_analysis.R** reads the training and test data sets, as well as subject and activity files for each test and train data. The script also reads variable file and activity label file and, each is stored as data table.  The script run_analysis.R** looks in  **features.txt** file for indices of variable names using regular expression *grep()* that consists of "mean" or "std" followed by "()". The script ignores meanFreq variables.
	The indices are used to select the columns in the data set that correspond only the measurements on the mean and standard deviation for each measurement. The indices are also used to select the variable names of the mean and standard deviation of the measurements and appropriately labels the data set with descriptive variable names. The appropriet variable names are assiged to this new dataset using *colnames()* function. The subject and catagorized activity information of each observation are added to the extracted data set by column binding using *cbind()* function. **run_analysis** groups the data set selected mean and standard deviation of the measurements by the subjects and catagorized activity names of the observations and computes the mean using *summarize ()* function. **run_analysis** then writes the resulting tidy data to a text file called tidy_data.txt in the Datasetzp folder.


 
