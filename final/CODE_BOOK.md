---
title: 'Codebook: Getting and Cleaning Data'
author: "Mussie Araya"
date: "2/25/2020"
output: html_document
---

# **Mission Statement**.

This code book describes the raw data, the variables of the raw data, transformations that were performed by my script **run_analysis.R** to clean up and summarize the raw data, tidy data produced and variables of the tidy data

# **The Raw Data**.

The raw data analyzed by **run_analysis.R** was collected from the accelerometers from the Samsung Galaxy S smartphone. The raw data was partioned to training and test data sets with 2967and 7392 observations respectively. The original data sets consisted 561 variables that include direct measurements and variables computed from the measurements. The tidy data produced consists of means of 66 selected variables from the 561 variables in the original raw data. The selected variables were the means and standard deviation of each measurement. 

# **The Variables**.
## Tidy Data Variables and Observations.

The variable names of the tidy data are subset of the variable names of the original raw data. Some of the variables in the raw data are described below and I briefly resummerize their definition as described in the features.txt file in the downloaded zip file. Please see **featur_info.txt** file in the downloaded zip file containing the raw data for full description. 

- tAcc-XYZ and tGyro-XYZ represent 3-axial raw signals from the accelerometer and gyroscope respectively. XYZ is used to denote 3-axial signals in the X, Y and Z directions. tGyro-XYZ only has body component.  The signals were recorded from 30 subjects while performing 1 of 6 activities. 
- tBodyAcc-XYZ and tGravityAcc-XYZ represent body and gravity components of tAcc-XYZ.  
- tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ represent Jerk signals obtained by differentiating the acceleration signals.
- tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag) represent the magnitude of the acceleration and jerk signals obtained by Euclidean norm of the 3 dimensional signals.
- fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag represent the acceleration and jerk signals in frequency domain obtained by Fourier transform of the signals in time domain. 
- The remainder variables in the raw data were obtained by applying various mathematical and statistical functions to the acceleration and jerk signals. 
- The variables of the tidy data are a subset of 561 variables of the raw data, corrsponding to mean and standard deviation are selected.  
- Each observation of the raw data correspond to 1 of 30 subjects performing 1 of 6 activities. Each observation of tidy data correspond to the mean of a given subject-activity observation in raw data. The subject and activity information for a given observation in the tidy data is stored in the first two column of the tidy data. 

## Temporary Variables Used By **run_analysis.R** During Transformation of Raw Data to Tidy Data.

The script **run_analysis.R** reads the training and test data sets, subject file, subject and activity files for each test and train data set. The script also reads variable file and activity label file. Data is stored as data table. The temporary new variables created to denote the data tables are:

- test_data:   test data set.  
- test_label:  activity label for each observation in test data set.  
- test_sub:    subjects of each observation of the test data set.  
- train_data:  training data set.  
- train_label: activity label for each observation in test data set.  
- train_sub:   subjects of each observation of the test data set
- variables:   variable names for each observation.  
- activity:    activity names and their associated numerical label.

The new variables created to store the merged data and transformed tidy data during computation.
	
- data_set:	  merged test and training data
- subjets:	 	merged subject identification for each row/observation in the merged data
- data_label:	merged activity label for each row/ observation data. 
- average_tidy_data: mean summary of the slelected raw data group by subject and activity


# **Transformation of the Raw data to Tidy Data**.

In summary, **run_analysis.R** combines the raw data consisted 561 total variables (separated in training and test sets with 7352 and 2967 observations) in to one data table of 10299 total observation. **run_analysis.R** extracts only the variables in the data representing the mean and standard deviation for each measurement using regular expressions. Means of frequency are not selected since they do not include direct measurments. This results in total of 66 columns extracted from the raw data. The data was collected from 30 subject performing one of 6 activities. The subjects are identified as subject 1-30. The activities reflect to the activity of the subject during measurement which include WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING, STANDING, LAYING. **run_analysis.R** appends two columns identifying the subject and activity performed during each observation to the extracted data. This gives a final tidy data of total 68 variables. **run_analysis.R** then summarizes data set by averaging each 66 variables for given activity and given subject. This gives 180 different independent observation. The script produces tidy data of 68 variables and 180 different subject-activity observations. Each step for producing tidy data is described in detail below.

## Merging of Training and Test Sets to Create One Data Set.
**run_analysis.R** merges the train and test data by performing row binding of the two data sets using *r_bind()* function. **run_analysis.R** similarly merges the subject and activity files. **run_analysis.R** reads the training and test data sets by looking for **X_test.txt** and **X_train.txt** files in the test and train folders respectively. Similarly the script reads he activity and subject files from train and test files and combines by performing row binding. The result is:  
- Single data table with 561 total variables and 10299 total observation.   
- Single activity table with 10299 elements that correspond to the observations in the merged data set.  
- Single subject table with 10299 elements that correspond to the observations in the merged data set.   
	 

## Extraction of Measurements on the Mean and Standard Deviation for Each Measurement.
**run_analysis.R** looks in the features file for indices of variable names using regular expression *grep()* that consists of "mean" or "std" followed by "()". The script ignores meanFreq variables.  

## Labeling the Columns of Data Set with Descriptive Variable Names.  
**run_analysis.R** selects descriptive variable names  (containing mean and standard deviation of the measurements) from variable data table using the indices used to extract the columns. The function *colnames()* was used to assign the names of the extracted columns.

	
##  Naming the Observations in Data Set Using Descriptive Subject and Activity Names. 
The **run_analysis.R** uses the *factor(,labels)* function to catagorize and encode the activities in the merged activity data (**y_train.txt** and **y_test.txt**) with descriptive activity names. Descriptive activity labels and their corresponding numerical orders in the **activity_labels.txt** was used as label parameter for the factor function. The subject information is numerical and catagorized by default. 
The subject and activity information of each observation are added to the extracted data set by column binding using *cbind()* function. 

## Summarized Tidy Data with Average of Each Variable for Each Activity and Each Subject.

**run_analysis.R** groups the data set by subjects and activity in tandem using *group_by()* function and calculates the mean of each group. The data was collected from 30 subject performing one of 6 activities. This results in 180 subject-activity pair constituting independent observations. The script produces a tidy data of 180 observation for the selected mean and standard deviation of each measurement.
	



