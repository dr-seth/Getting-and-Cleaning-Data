---
# README  
### Coursera Data Science Specialization -- Getting and Cleaning Data
#### December 7th, 2015 session
https://class.coursera.org/getdata-035/human_grading/view/courses/975119/assessments/3/submissions

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Explanation of Code

#### Required Packages 
data.table 

#### Load activity labels, features labels and features  
Load in the data tables that the ```activity labels```, ```feature labels``` and ```features``` are derived from

#### Extract mean and standard deviation data
Only the ```mean``` and ```std``` data are required for this project. Extract these data using the ```features``` varrible defined above and create intermediate varriables ```feature_wanted``` and ```feature_labels``` to clean up column headers

#### Load training sets
Read in only the data for mean and std by leveraging the ```feature_label``` varriable as well as loading the training subjects and activities. The combine the individual training set varriables (```traning_set ```, ```training_subject ```, ```training_activities ```) into a single data table ```training_set```

#### load test sets
Read in only the data for mean and std by leveraging the ```feature_label``` varriable as well as loading the test subjects and activities. The combine the individual training set varriables (```test_set ```, ```test_subject ```, ```test_activities ```) into a single data table ```test_set```

#### merge training and test sets with labels
Create a data table ```all_data``` that combines the tables stored in ```training_set``` and ```test_set``` andAdd column headers to the table

#### turn activities & subjects into factors
The activity and subject data are being stored as characters and need to be converted to factors
 
#### Write output file
Output the data table ```all_data``` as a text firle 'tidy.txt'


