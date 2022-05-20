# Getting-Cleaning-Data-Project
Coursera Data Science Specialization Course 
Course Project

## Project Description
This project is an exercise in acquiring and cleaning data. 
The project uses data from the UCI Machine Learning Repository: Human Activity Recognition and Smart Phone Data site: [Description here.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Data for the project can be downloaded here: [Zip Archive Download](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Project Files

### Data Processing Script: cleaningdata.R
The R script [run_analysis.R](run_analysis.md) reads the data files and combines them into one full data file.  Important variable values are renamed from numbers to meaningful names. The full set of variables is reduced to a subset that involve means and standard deviations. Variable names are changed to conform with R's legal variable names and to be descriptive.


### Data Processing Description and Variable Names: CodeBook.md
The file [CodeBook.md](CodeBook.md) describes the processing steps and variables used in [run_analysis.R](run_analysis.md) and supplements the README.txt included in the original downloaded archive.

