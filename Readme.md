## README 
## Getting and Cleaning Data Course 
## Project 2

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In order to run the script  "run_analysis.R" you need to download the data into your working directory and create a codeBook.rmd file that explain how the data set was created. The run_analysis.R script do what is indicated in the instructions of the Project: 

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data file created is called "tidydataHGO.txt" 

If you want to create a README file with an HTML or MD format run the followings instructions with the README.rmd file in your working directory:

library(knitr)
knit2html("Readme.Rmd");
