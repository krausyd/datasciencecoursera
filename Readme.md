#Coursera Data Scientist Specialization - Getting and Cleaning Data final project

This git project contains the files required for the _Getting and Cleaning Data_ course final project. It contains the R script, the final data and its description.  

###run_analysis.r
This file contains the R script for doing the analysis. The steps in this file are:  
1. Downloads and unzip the dataset if them don't already exist in working directory.  
2. Loads the feature information that contains the names of the type of training.  
 2.a Gets a subset with only the ones that contains Mean and Std.  
 2.b Renames  
3. Loads the training test data, and subsets the data we need (mean and std).  
 3.a Loads the labels or type of training for the data.  
 3.b Loads the subject index for the data  
 3.c merges the three datasets  
4. Does the same than step 3, but for test data  
5. Merges the test and train datasets  
6. Creates the tidy dataset containing only the average per subject and activity.  
7. Saves the dataset into **tidy_data.txt** file  
