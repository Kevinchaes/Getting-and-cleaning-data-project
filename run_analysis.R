# Coursera Data Science Specialization Course
# Getting and Cleanng Data
# Course Project
###########################################################################################
# Packages Used
library(tidyverse)
library(lubridate)

# Date & System Info
today <- Sys.time()
ymd_hms(today)
mySystem <- sessionInfo()

# Data Description & Source File URLs
dataDescription <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and Extract Zip Archive
download.file(dataUrl, destfile = "data.zip")
unzip("data.zip")

# Read Activity and Feature Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") #V2 contains label
features <- read.table("./UCI HAR Dataset/features.txt")               #V2 contains feature labels

# Read Test data 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Read Train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Combine subjects, activity labels, and features into test and train sets (Step 1)
test  <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)

# Combine test and train sets into full data set  (Step 1 - continued)
fullSet <- rbind(test, train)

# Subset to mean and standard deviation columns; keep subject, activity columns (Step 2)
allNames <- c("subject", "activity", as.character(features$V2))
meanStdColumns <- grep("[Mm]ean|std", allNames, value = FALSE)
reducedSet <- fullset[ ,c(1,2,meanStdColumns)]

# Uses descriptive activity names for activites in the data set: by indexing (Step 3)
names(activity_labels) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activity_labels$activityName[reducedset$V1.1]

# Appropriately Label the Dataset with Descriptive Variable Names (Step 4)
## Use series of substitutions to rename varaiables
reducedNames <- allNames[c(1,2,meanStdColumns)]    # Names after subsetting
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames   # Apply new names to dataframe

# Create tidy data set (Step 5)
tidyDataset <- reducedSet %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.table(tidyDataset, file = "tidyDataset.txt")

# Call to read in tidy data set produced
# validate <- read.table("tidyDataset.txt")

