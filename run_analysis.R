library(tidyverse)
library(lubridate)

#data access
metadata <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#load data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")            

#test data 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")


#train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")


#Combine data separate to keep order
test  <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)


#Combine all data in single file
data <- rbind(test, train)

#creates an object with variables names in order
variablesnames <- c("subject", "activity", as.character(features$V2))


#finds and creates an object with mean and std positions
meanStdColumns <- grep("subject|activity|[Mm]ean|std", variablesnames, value = FALSE)#return the columns with given values

#subsets data with positions created before
reducedSet <- data[ ,meanStdColumns]


#indexing to apply activity names to corresponding activity number
names(activity_labels) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activity_labels$activityName[reducedSet$V1.1]


#Substitution to clean data
reducedNames <- variablesnames[meanStdColumns]
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames   # Apply new names to dataframe

#Create tidy data set
tidyDataset <- reducedSet %>% group_by(activity, subject) %>% 
  summarise_all(funs(mean))
