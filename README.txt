README: Human Activity Recognition Data Cleaning Project
DAT 511 Group Project
Authors: Ava Jo Wertman and Taylor Evans

OVERVIEW
---------
This project takes the "Human Activity Recognition Using Smartphones"
dataset (UCI) and produces one tidy dataset. The raw data comes from
30 volunteers who had a Samsung Galaxy S smartphone while doing six
activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, and LAYING.


The R script (GroupProj.R) does the following:

  1. Replaces numeric activity codes with descriptive activity names.
    - using activity_labels.txt
    
  2. Extracts the measurements on the mean and standard deviation.
  
  3. Labels the columns with the descriptive activity names.
    - columns from both test and train folders
  
  4. Merges the training and test sets into one dataset.
  
  5. Creates a tidy dataset with the average of each variable
     for each activity and each subject. 
     
The final output is saved as tidy_dataset.txt.





FILE CONTENTS IN THIS REPOSITORY:
---------------------------------

GroupProj.R                       The R script with all of the processing and analysis.
README.txt                        The README file describing goals.
CodeBook.md                       Describes the data, variables, and design.
tidy_dataset.txt                  The tidy dataset.
UCI HAR Dataset                   The raw data folder.

REQUIREMENTS
------------
  - R studio
  - R packages: dplyr, tidyr, & readr


GETTING THE DATA
-----------------
  1. Download the dataset zip file:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Source:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
  2. Unzip the file and define the path to the "UCI HAR Dataset" folder.
    
      
UCI HAR Dataset:

  |-- activity_labels.txt      -> links activity IDs 1-6 to activity names
  |-- features_info.txt        -> Names of all 561 measurements/features
        
  |-- train:
  |   |--X_train.txt          -> 7352 observations × 561 features
  |   |--y_train.txt          -> 7352 activity labels
  |   |--subject_train.txt    -> 7352 subject IDs
  | --test:
  |   |--X_test.txt           -> 2947 observations × 561 features
  |   |--y_test.txt           -> 2947 activity labels
  |   |--subject_test.txt     -> 2947 subject IDs
  
HOW TO RUN THE SCRIPT
---------------------

1. Open GroupProj.R in RStudio

2. Change the working directory. Use setwd() to set the directory to the folder
   containing the "UCI HAR Dataset". Or use the menu bar: session -> set working directory.
=========================================================================================

ANALYSIS PROCESS
----------------

Step 1    Load the required libraries: library(c(dplyr, tidyr, readr)).

Step 2    Sets the working directory and stores dataset folder in
          variable data_path.

Step 3    Loads the metadata files: activity_labels.txt (activity ID to activity name)
          and features.txt (the 561 measurement names).

Step 4    Extracts the mean and standard deviation features. Uses grep()
          to find feature names containing "-mean()" or "-std()" ("-(mean|std)").
          This results in 66 features.

Step 5    Loads and processes the training datasets (X_train, y_train, subject_train).
          Only the 66 mean/std columns of the feature measurement dataset (X_train) are kept.
          Columns are given descriptive activity label names.

Step 6    Loads and processes test datasets (X_test, y_test, subject_test) repeating the
          exact process from step 5.
      
Step 7    Merges training and test data into one unified dataset. cbind() joins column names:
          subject, activity, and measurements for each dataset. rbind() stacks
          datasets vertically, giving one dataset with 10,299 rows.
          
Step 8    Adds descriptive activity names for activity in combined dataset. Merges activity_labels
          so each row of the combined dataset has a descriptive name (WALKING, SITTING, etc.) instead
          of a numeric value, then removes the matched numeric activity_id column. 
          
Step 9    Creates a tidy dataset with the average of each variable for each activity and subject.
          The tidy dataset has 180 unique combinations: 30 subjects x 6 activities. 

Step 10   Saves the tidy dataset to tidy_dataset.txt

=======================================================================================================

HOW TO VERIFY RESULTS
---------------------

Run the entire script and use these commands:

dim(tidy_data)                    # 180 rows x 68 colums
colnames(tidy_data)[1:5]          # "subject" "activity" "tBodyAcc-mean()-X"
                                  # "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"
table(tidy_data$subject)          # Each subject should appear 6 times
table(tidy_data$activity)         # Each activity should appear 30 times
summary(tidy_data[, 1:5])

REFLECTION QUESTIONS
--------------------
  1. Our goal of this project was to clean and organize all of the data from both the testing and
     training datasets.The split dataset are useful for predictive modeling and efficacy evaluation, 
     but we are interested in organization, analytics, and summary characteristics. 
  
  2. Each subject contributed between 281 and 409 observations in the study, resulting in a total of
     10,299 observations across all 30 subjects. 
     
  3.  Priorizing the summary statistics, the mean and standard deviation, allows us 
     to reduce complexity and focus on interpretable measurements to better understand the data.
     These specific measurements provide us with avergae performance across all subjects,
     while also considering individual variance. The mean averages the central value of movement
     during a specific time frame, and the standard deviation measures how much the signal
     varies around that average. Together, these measurements show both the level and variability
     of movement. 
    
   4. A tidy dataset is one where each variable has its own column, each observation has its own row,
      and each observation forms its own table. Our tidy dataset follows these guidlines;
      each column is one variable (subject, activity, or feature measurement), with descriptive
      names rather than ambiguous numeric values.
   
   5. One row in the tidy dataset represents one subject performing one activity.
      A single value in the measurement column is the average, across all observations of
      a particular subject for a specific activity, of the mean or standard deviation feature.
     



 
  
  
  