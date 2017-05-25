#This scrpit will merge the files from training and test data set into a single tidy file by measure interval
#And then create a second file with a summary by subject and activity

#Download Files if not exists

library(RCurl)

if (!file.exists('UCI HAR Dataset')) {
        dataFile <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
        # dir.create('UCI HAR Dataset')
        download.file(dataFile, 'UCI-HAR-dataset.zip', method='auto')
        unzip('./UCI-HAR-dataset.zip')
        file.remove("UCI-HAR-dataset.zip")
}



#load individual files into temporary tables
library(data.table)
x1<-data.table(read.table("./UCI HAR Dataset/train/X_train.txt"))
x2<-data.table(read.table("./UCI HAR Dataset/test/X_test.txt"))
y1<-data.table(read.table("./UCI HAR Dataset/train/y_train.txt"))
y2<-data.table(read.table("./UCI HAR Dataset/test/y_test.txt"))
subject1<-data.table(read.table("./UCI HAR Dataset/train/subject_train.txt"))
subject2<-data.table(read.table("./UCI HAR Dataset/test/subject_test.txt"))
features<-read.table("./UCI HAR Dataset/features.txt")
activitylbl<-read.table("./UCI HAR Dataset/activity_labels.txt")
subject1$type="train"
subject2$type="test"


#merge tables
x<-rbind(x1,x2)
y<-rbind(y1,y2)
subject<-rbind(subject1,subject2)

#set column names & filter columns
setnames(x,names(x),as.vector(features[,2]))
setnames(y,names(y),"Activity")
setnames(subject,names(subject),c("subject","type"))
ismean <- grepl("mean\\()", names(x))
issd<- grepl("std\\()", names(x))
x<-x[,ismean | issd , with=FALSE]
names(x)=gsub("\\()","",names(x))
y$Activity<-factor(y$Activity,levels=activitylbl[,1],labels=activitylbl[,2])


#merge into one single final data table
data<-cbind(subject,y,x)
data$id <- 1:nrow(data)

#remove temporary tables
rm(list=c("y1","y2","x1","x2","subject1","subject2","features","x","y","subject"))

#write file1
write.csv(data, file = "Tidydata1.csv")


#make summary table and file
library(dplyr)
my_group<-group_by(data,subject,Activity,type)
data_sum<-summarise_each(my_group,funs(mean))

#write file2
write.csv(data_sum, file = "Tidydata2.csv")

print("2 tidydata files created")
