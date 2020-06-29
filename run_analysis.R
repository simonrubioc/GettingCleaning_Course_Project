#Dowloading and reading data sets
library(dplyr)
filename <- "Coursera_DS3_Final.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging existing data sets
x_frame <- rbind(x_train, x_test)
y_frame <- rbind(y_train, y_test)
mergedData <- cbind(subject, x_frame, y_frame)

#Renaming propperly the activities, by code
tidy_data <- mergedData %>% select(subject, code, contains("mean"), contains("std"))
tidy_data$code <- activities[tidy_data$code, 2]

#Labeling propperly and descriptively each variable
names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("+mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("+std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("+freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-sub("\\.", "", names(tidy_data))

#Creating a data frame with the means of each variable, by subject and activity
DATA <- tidy_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(DATA, "DATA.txt", row.name=FALSE)
