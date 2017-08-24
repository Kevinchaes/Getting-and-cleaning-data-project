# Coursera Data Science Specialization Course
# Getting and Cleanng Data
# Course Project
###########################################################################################
library(tidyverse)
library(lubridate)


today <- Sys.time()
ymd_hms(today)
mySystem <- sessionInfo()

# Data Description & Source File
dataDescription <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and Extract Zip Archive
download.file(dataUrl, destfile = "data.zip")
unzip("data.zip")

# Read the Raw Training and Test Sets
#train <- read.table("./UCI HAR Dataset/train/X_train.txt")
#test <- read.table("./UCI HAR Dataset/test/X_test.txt")
#train <- tbl_df(train)
#test  <- tbl_df(test)
