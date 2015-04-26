Project_Getting_Clean_data
Getting and Cleaning Data Course Project
Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

What you find in this repository
•CodeBook.md: information about raw and tidy data set and elaboration made to transform them
•README.md: this file
•run_analysis.R: R script to transform raw data set in a tidy one
How to create the tidy data set
1.clone this repository: https://github.com/adityatare/Getting-and-Cleaning-Data 
2.download compressed raw data 
3.unzip raw data and copy the directory UCI HAR Dataset to the cloned repository root directory
4.open a R console and set the working directory to the repository root (use setwd())
5.source Run_analysis.R script (it requires the plyr package): source('run_analysis.R') 
In the repository root directory you find the file sensor_avg_by_act_sub.txt with the tidy data set.

