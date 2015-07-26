## Getting and Cleaning Data Course 
## Project 2

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## First we read the files into the next variables: 

pfiles <- file.path("E://Getting and Cleaning data//Week 3" , "UCI HAR Dataset")
files<-list.files(pfiles, recursive=TRUE)


dActTest  = Activity Test 
dActTrain = Activity Train 
dSubTest = Subject Test
dSubTrain = Subject Train 
dFeaTest  = Feature Test 
dFeaTrain = Feature Train

## 1.	Merges the training and the test sets to create one data set.

## We concatenate b row 
dSub = Subject Train + Subject Test 
dAct = Activity Train+ Activity Test 
dFea = Feature Train+ Feature Test 

dComb = dSub + dAct
datav1 = dFea+ dComb #Our first data set 


## 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 

subdFeaName = Subset of features by  mean and standard deviation

selectedNames<-c(as.character(subdFeaNames), "subject", "activity" )
datav1 = rewrite datav1 by subset of selectedNAmes 

## 3.	Uses descriptive activity names to name the activities in the data set

activityLabels = Read the activity description from activity_labels 


## We add the names into the file datav1 as follows:
datav1$activity<-as.character(datav1$activity)
for (j in 1:length(activityLabels$V2)){
datav1$activity[datav1$activity == j]<-as.character(activityLabels[j,2])
}
datav1$activity<- as.factor(datav1$activity)


## 4.	Appropriately labels the data set with descriptive variable names. 


names(datav1)<-gsub("^t", "time", names(datav1))
names(datav1)<-gsub("^f", "frequency", names(datav1))
names(datav1)<-gsub("Acc", "Accelerometer", names(datav1))
names(datav1)<-gsub("Gyro", "Gyroscope", names(datav1))
names(datav1)<-gsub("Mag", "Magnitude", names(datav1))
names(datav1)<-gsub("BodyBody", "Body", names(datav1))



## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

datav2<-aggregate(. ~subject + activity, datav1, mean)
datav2 = We reorder the file by subject and activity
## we write the file tidydataHGO.txt
write.table(datav2, file = "tidydataHGO.txt",row.name=FALSE) 

## Finally we create the Codebook

library(knitr)
knit2html("codeBook.Rmd");
