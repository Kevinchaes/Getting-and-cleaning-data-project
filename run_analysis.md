Getting and Cleaning Data: Course Project
================
Mark Blackmore
2017-11-27

-   [Data Description & Source File URLs](#data-description-source-file-urls)
-   [Merge training and test sets to create one data set](#merge-training-and-test-sets-to-create-one-data-set)
-   [Extract only measurements on mean and standard deviation](#extract-only-measurements-on-mean-and-standard-deviation)
-   [Use descriptive activities names for activity measurements](#use-descriptive-activities-names-for-activity-measurements)
-   [Appropriately Label the Dataset with Descriptive Variable Names](#appropriately-label-the-dataset-with-descriptive-variable-names)
-   [Create tidy data set with average of each variable, by activity, by subject](#create-tidy-data-set-with-average-of-each-variable-by-activity-by-subject)
-   [Session info](#session-info)

Data Description & Source File URLs
-----------------------------------

``` r
dataDescription <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

Download and Extract Zip Archive

``` r
# download.file(dataUrl, destfile = "data.zip")
# unzip("data.zip")
```

Merge training and test sets to create one data set
---------------------------------------------------

Read Activity and Feature Labels

``` r
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") #V2 contains label
features <- read.table("./UCI HAR Dataset/features.txt")               #V2 contains feature labels
```

Read Test data

``` r
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
```

Read Train data

``` r
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
```

Combine subjects, activity labels, and features into test and train sets

``` r
test  <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
```

Combine test and train sets into full data set

``` r
fullSet <- rbind(test, train)
```

Extract only measurements on mean and standard deviation
--------------------------------------------------------

Subset, keeeping mean, std columns; also keep subject, activity columns

``` r
allNames <- c("subject", "activity", as.character(features$V2))
meanStdColumns <- grep("subject|activity|[Mm]ean|std", allNames, value = FALSE)
reducedSet <- fullSet[ ,meanStdColumns]
```

Use descriptive activities names for activity measurements
----------------------------------------------------------

Use indexing to apply activity names to corresponding activity number

``` r
names(activity_labels) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activity_labels$activityName[reducedSet$V1.1]
```

Appropriately Label the Dataset with Descriptive Variable Names
---------------------------------------------------------------

Use series of substitutions to rename varaiables

``` r
reducedNames <- allNames[meanStdColumns]    # Names after subsetting
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames   # Apply new names to dataframe
```

Create tidy data set with average of each variable, by activity, by subject
---------------------------------------------------------------------------

Create tidy data set

``` r
tidyDataset <- reducedSet %>% group_by(activity, subject) %>% 
  summarise_all(funs(mean))
```

Write tidy data to ouput file

``` r
write.table(tidyDataset, file = "tidyDataset.txt", row.names = FALSE)

# Call to read in tidy data set produced and validate steps
# validate <- read.table("tidyDataset.txt")
# View(validate)
```

------------------------------------------------------------------------

Session info
------------

``` r
sessionInfo()
```

    ## R version 3.4.2 (2017-09-28)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 15063)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.1252 
    ## [2] LC_CTYPE=English_United States.1252   
    ## [3] LC_MONETARY=English_United States.1252
    ## [4] LC_NUMERIC=C                          
    ## [5] LC_TIME=English_United States.1252    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] lubridate_1.6.0 dplyr_0.7.4     purrr_0.2.3     readr_1.1.1    
    ## [5] tidyr_0.7.1     tibble_1.3.4    ggplot2_2.2.1   tidyverse_1.1.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.13     cellranger_1.1.0 compiler_3.4.2   plyr_1.8.4      
    ##  [5] bindr_0.1        forcats_0.2.0    tools_3.4.2      digest_0.6.12   
    ##  [9] jsonlite_1.5     evaluate_0.10.1  nlme_3.1-131     gtable_0.2.0    
    ## [13] lattice_0.20-35  pkgconfig_2.0.1  rlang_0.1.2      psych_1.7.8     
    ## [17] yaml_2.1.14      parallel_3.4.2   haven_1.1.0      bindrcpp_0.2    
    ## [21] xml2_1.1.1       httr_1.3.1       stringr_1.2.0    knitr_1.17      
    ## [25] hms_0.3          rprojroot_1.2    grid_3.4.2       glue_1.1.1      
    ## [29] R6_2.2.2         readxl_1.0.0     foreign_0.8-69   rmarkdown_1.6   
    ## [33] modelr_0.1.1     reshape2_1.4.2   magrittr_1.5     backports_1.1.1 
    ## [37] scales_0.5.0     htmltools_0.3.6  rvest_0.3.2      assertthat_0.2.0
    ## [41] mnormt_1.5-5     colorspace_1.3-2 stringi_1.1.5    lazyeval_0.2.0  
    ## [45] munsell_0.4.3    broom_0.4.2
