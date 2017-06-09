# load required library
library(plyr)
library(dplyr)
library(data.table)

# download file
if(!file.exists("./data")){dir.create("./data")}
fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./data/Dataset.zip")


#Unzip file
unzip("./data/Dataset.zip")

#Set Datafile pat
setwd("C:/Users/Patil/Data_Science")
filepath <- file.path("./Data","UCI HAR Dataset")
filelist <- list.files(filepath,recursive = TRUE)

# Read Result Data files
testactivityresult <- read.table(file.path(filepath,"test","X_test.txt"),header = FALSE)
trainactivityresult <- read.table(file.path(filepath,"train","X_train.txt"),header = FALSE)


# Read activity file
testactivity <- read.table(file.path(filepath,"test","Y_test.txt"),header = FALSE)
trainactivity <- read.table(file.path(filepath,"train","Y_train.txt"),header = FALSE)

# Read volunteers  data
testvolunteersdata <- read.table(file.path(filepath,"test","subject_test.txt"),header = FALSE)
trainvolunteersdata <- read.table(file.path(filepath,"train","subject_train.txt"),header = FALSE)

# Mergeing data horizontal
activityresult<- rbind(testactivityresult,trainactivityresult)
activity <- rbind(testactivity,trainactivity)
volunteersdata <- rbind(testvolunteersdata,trainvolunteersdata)

# Give header
#colnames(activity) <- "activity"
#colnames(volunteersdata) <- "subject"
features <- read.table(file.path(filepath,"features.txt"),header = FALSE)

combinedata <- cbind(volunteersdata,activity)
combinedata <- cbind(combinedata,activityresult)

# Tranpose features and table only header
tranposefeatures <- t(features)
tranposefeatures <- tranposefeatures[2,]
tranposefeatures <- c(c("subject","activity"),tranposefeatures)
combinedata <- setNames(combinedata,tranposefeatures)

# read activities
activitylable <- read.table(file.path(filepath,"activity_labels.txt"),header = FALSE)

colnames(activitylable) <- c("activity","activities")

combinedata <- join(activitylable, combinedata,by="activity")

combinedata$activity <- NULL

combinedata$activities <- as.factor(combinedata$activities)

# Change names to Appropriately activity names  and subject names
names(combinedata) <- gsub("^f","frequence",names(combinedata))
names(combinedata) <- gsub("^t","time",names(combinedata))
names(combinedata) <- gsub("Acc","Accelerometer",names(combinedata))
names(combinedata) <- gsub("Gyro","Gyroscope",names(combinedata))
names(combinedata) <- gsub("Mag","Magnitude",names(combinedata))

combinedata$subject <- as.character(combinedata$subject)
combinedata$subject <- paste("subject", combinedata$subject)

# Extract only Mean and Std 
meanrange <- grep("mean()", names(combinedata), value = FALSE, fixed = TRUE)
Meandatset <- combinedata[meanrange]

stdrange <- grep("std()", names(combinedata), value = FALSE, fixed = TRUE)
Stddatset <- combinedata[stdrange]


# Create Tidy Data Set

TidyData <- data.table(combinedata)
TidyData <- TidyData[,lapply(.SD,mean),by = "subject,activities"]
write.table(TidyData, file = "TidyDataSet.txt", row.names = FALSE)
