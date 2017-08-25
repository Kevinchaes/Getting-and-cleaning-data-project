# Getting-Cleaning-Data-Project
Coursera Data Science Specialization Course on Getting and Cleaning Data: Course Project

## Project Description
This project is an exercise in acquiring and cleaning data. 
The project use data from the [UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The R script *run_analysis.R* reads the data files and combines the files into one full data file.  Important variable values are renamed from numbers to meaningful names. The full set is reduced to a subset of the measures that involve means and standard deviations.  Variable names are changed to conform with R's legal variable names and to be descriptive.

The data is then grouped by subject and activity, and summarized by each variable's mean. The end result is a tidy data set, conforming to Hadley Wickham's tidy data principles [Tidy Data](https://www.jstatsoft.org/article/view/v059i10).  The tidy data set is written to the file *tidyDataset.txt*.

The file *CodeBook.md* describes the processing steps and variables used in *run_analysis.R* and supplements the README.txt included in the original downloaded archive.
