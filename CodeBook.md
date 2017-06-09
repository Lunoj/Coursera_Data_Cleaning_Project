## CodeBook.md
 
## Introduction
 
run_analysis.R file  consist 5 step approach for Coursera Data Cleaning Project
 
## Step 1 
 
All similar dataset merged together with rbind statement. 
example x_test.txt merged with y_text.txt
 
## Step 2
Read features.txt file which include all activities and 
as all activities in this file in vertical format, need to transpose this into
columnar way.  After transpose this file has 561 columns.
Additional 2 columns added to this file to match our combinedata set which 
was created in step 1
and later extract only columns which has mean or std 
 
## Step 3
Activity data set has data for different activities and this merged to combine
data set to link activities no with activites name.
 
## Step 4 
Labels the data set with descriptive variable names
 
## Step 5 
TidyData set created with average of each variable for each activity and 
each subject. Later this is saved to TidyDataSet.txt
This file contains 180 rows ( for 30 observation and 6 activities = 180 rows)
 
 
# Variables
X_test.txt, y_test.txt,X_train.txt, y_train.txt,subject_test.txt,subject_train.txt  merged to combinedata
features.txt file contains column name for combinedata set.   
Similarly activity_labels.txt has list of all activities and this data join with combinedata ( by activity_no as joining key)
Extracted all column has mean and Std variable [Meandataset and Stddataset ]
later created TidyDataSet which was saved to TidyDataSet.txt file
 
