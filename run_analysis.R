#Read the data

pfiles <- file.path("E://Getting and Cleaning data//Week 3" , "UCI HAR Dataset")
files<-list.files(pfiles, recursive=TRUE)

dActTest  <- read.table(file.path(pfiles, "test" , "Y_test.txt" ),header = FALSE)
dActTrain <- read.table(file.path(pfiles, "train", "Y_train.txt"),header = FALSE)
dSubTrain <- read.table(file.path(pfiles, "train", "subject_train.txt"),header = FALSE)
dSubTest  <- read.table(file.path(pfiles, "test" , "subject_test.txt"),header = FALSE)
dFeaTest  <- read.table(file.path(pfiles, "test" , "X_test.txt" ),header = FALSE)
dFeaTrain <- read.table(file.path(pfiles, "train", "X_train.txt"),header = FALSE)


#1.- Merges the training and the test sets to create one data set.
dSub <- rbind(dSubTrain, dSubTest)
dAct<- rbind(dActTrain, dActTest)
dFea<- rbind(dFeaTrain, dFeaTest)
names(dSub)<-c("subject")
names(dAct)<- c("activity")
dFeaNames <- read.table(file.path(pfiles, "features.txt"),head=FALSE)
names(dFea)<- dFeaNames$V2
dComb <- cbind(dSub, dAct)
datav1 <- cbind(dFea, dComb)


#2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
subdFeaNames<-dFeaNames$V2[grep("mean\\(\\)|std\\(\\)", dFeaNames$V2)]
selectedNames<-c(as.character(subdFeaNames), "subject", "activity" )
datav1<-subset(datav1,select=selectedNames)

#3.	Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table(file.path(pfiles, "activity_labels.txt"),header = FALSE)

datav1$activity<-as.character(datav1$activity)
for (j in 1:length(activityLabels$V2)){
datav1$activity[datav1$activity == j]<-as.character(activityLabels[j,2])
}
datav1$activity<- as.factor(datav1$activity)

#4.	Appropriately labels the data set with descriptive variable names. 

names(datav1)<-gsub("^t", "time", names(datav1))
names(datav1)<-gsub("^f", "frequency", names(datav1))
names(datav1)<-gsub("Acc", "Accelerometer", names(datav1))
names(datav1)<-gsub("Gyro", "Gyroscope", names(datav1))
names(datav1)<-gsub("Mag", "Magnitude", names(datav1))
names(datav1)<-gsub("BodyBody", "Body", names(datav1))

#1.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
datav2<-aggregate(. ~subject + activity, datav1, mean)
datav2<-datav2[order(datav2$subject,datav2$activity),]
write.table(datav2, file = "tidydataHGO.txt",row.name=FALSE)

#Prouduce Codebook

library(knitr)
knit2html("codeBook.Rmd");