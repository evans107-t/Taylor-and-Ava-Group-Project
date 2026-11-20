# ============================================================================
# DAT 511 Group Project: Human Activity Recognition Dataset Analysis
# GroupWork.R
# ============================================================================
# PROJECT GOAL: Prepare tidy data from wearable computing accelerometer data
# collected from Samsung Galaxy S smartphones tracking human activities.
#
# DATASET: Human Activity Recognition Using Smartphones
# Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# ============================================================================

# ============================================================================
# UNDERSTANDING THE DATASET STRUCTURE
# ============================================================================
# Before we begin, let's understand what we're working with:
#
# The UCI HAR Dataset contains data from 30 volunteers (subjects) performing
# 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
# STANDING, LAYING) while wearing a Samsung Galaxy S smartphone.
#
# WHY IS THE DATA SPLIT INTO TRAINING AND TEST SETS?
# ----------------------------------------------------------------------------
# In machine learning, we split data into:
# - TRAINING SET (70%): Used to train/build predictive models
# - TEST SET (30%): Used to evaluate how well the model performs on new data
#
# Think of it like studying for an exam:
# - Training data = practice problems you study from
# - Test data = the actual exam questions (never seen during study)
#
# For OUR project, we don't need this split anymore. We're not building a
# model - we're cleaning and organizing ALL the data. So we'll MERGE both
# sets back together to create one complete dataset.
#
# DATASET FILES STRUCTURE:
# UCI HAR Dataset/
#   ├── activity_labels.txt      (Links activity IDs 1-6 to activity names)
#   ├── features.txt              (Names of all 561 measurements/features)
#   ├── train/
#   │   ├── X_train.txt          (7352 observations × 561 features)
#   │   ├── y_train.txt          (7352 activity labels)
#   │   └── subject_train.txt    (7352 subject IDs)
#   └── test/
#       ├── X_test.txt           (2947 observations × 561 features)
#       ├── y_test.txt           (2947 activity labels)
#       └── subject_test.txt     (2947 subject IDs)
# ============================================================================

# STEP 1: Load Required Libraries
# ============================================================================
# R packages extend R's functionality with additional functions and tools.
# For this project, you need to install and load the following packages:
#
# REQUIRED PACKAGES:
# ------------------
# 1. dplyr: For data manipulation (filtering, grouping, summarizing)
#    - Install: install.packages("dplyr")
#    - Why: Makes data transformation cleaner and more readable

#
# OPTIONAL (but recommended) PACKAGES:
# -------------------------------------
# 2. tidyr: For reshaping data (optional for this project)
#    - Install: install.packages("tidyr")
#
library(tidyr)

# 3. readr: For faster data reading (optional alternative to read.table)
#    - Install: install.packages("readr")
library(readr)
#
# NOTE: You only need to install packages ONCE using install.packages()
#       But you must load them with library() in EVERY new R session

# TODO: Load the dplyr package
# HINT: Use library(dplyr)

library(dplyr)

# INTERACTIVE CHECK #1
# Run this command to verify dplyr loaded correctly:
# If successful, you'll see the dplyr version and attached packages
# packageVersion("dplyr")

# ============================================================================
# STEP 2: Set Working Directory and Data Path
# ============================================================================
# The working directory is where R looks for files and saves outputs.

# TODO: Set your working directory to where you extracted the UCI HAR Dataset
# HINT: Use setwd("your/path/here") with forward slashes or double backslashes
# EXAMPLE for Windows: setwd("C:/Users/YourName/Desktop/DAT511/GroupProject")
# EXAMPLE for Mac: setwd("/Users/YourName/Desktop/DAT511/GroupProject")

setwd("/Users/taylorevans/Desktop/DAT413GroupProject/Taylor and Ava GP")

# INTERACTIVE CHECK #2
# Verify your working directory is correct:
# getwd()  # Should show the path you just set
# list.files()  # Should show "UCI HAR Dataset" folder
getwd()
list.files() 

# TODO: Define the path to the UCI HAR Dataset folder
# HINT: If the folder is directly in your working directory, just use the folder name

data_path <- "UCI HAR Dataset"

# INTERACTIVE CHECK #3
# Verify the dataset folder contains the expected files:
# list.files(data_path)  # Should show: activity_labels.txt, features.txt, train, test
list.files(data_path)

# ============================================================================
# STEP 3: Load Metadata Files
# ============================================================================
# Metadata = "data about data" - files that describe the structure of our dataset

# LOADING activity_labels.txt
# ----------------------------------------------------------------------------
# This file maps numeric activity IDs to descriptive names:
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

# TODO: Load activity_labels.txt
# HINT: Use read.table() with file.path() to construct the full path
# HINT: Set col.names = c("activity_id", "activity")

activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), 
                              col.names = c("activity_id", "activity"))

# INTERACTIVE CHECK #4
# View the activity labels:
# print(activity_labels)
# Expected output: 6 rows × 2 columns showing IDs 1-6 with activity names

# LOADING features.txt
# ----------------------------------------------------------------------------
# This file contains names for all 561 measurement variables
# Examples: "tBodyAcc-mean()-X", "tBodyAcc-std()-Y", "fBodyGyro-max()-Z"
# 
# Feature naming convention:
# - Prefix 't' = time domain signals
# - Prefix 'f' = frequency domain signals (after Fast Fourier Transform)
# - 'Body' = body motion components
# - 'Gravity' = gravitational motion components
# - 'Acc' = accelerometer measurements
# - 'Gyro' = gyroscope measurements
# - 'Jerk' = jerk signals (rate of change of acceleration)
# - 'Mag' = magnitude calculated using Euclidean norm
# - 'mean()' = mean value
# - 'std()' = standard deviation
# - 'X', 'Y', 'Z' = axis direction

# TODO: Load features.txt
# HINT: Set col.names = c("index", "feature_name")

features <- read.table(file.path(data_path, "features.txt"), 
                       col.names = c("index", "feature_name"))

# INTERACTIVE CHECK #5
# Explore the features:
# dim(features)  # Should show: 561 rows × 2 columns
# head(features, 10)  # View first 10 feature names
# View(features)  # Open in RStudio viewer to see all features
dim(features)
head(features, 10)
View(features)

# ============================================================================
# STEP 4: Extract Mean and Standard Deviation Features
# ============================================================================
# PROJECT REQUIREMENT: "Extract only measurements for mean and standard deviation"
#
# WHY? The dataset has 561 features, but we only need summary statistics
# (mean and std) for our analysis. This reduces complexity and focuses on
# the most informative measurements.

# UNDERSTANDING THE PATTERN:
# We want features with "-mean()" or "-std()" in their names
# Examples to INCLUDE: "tBodyAcc-mean()-X", "tBodyAcc-std()-Y"
# Examples to EXCLUDE: "meanFreq()", "gravityMean" (these are different calculations)

# TODO: Use grep() to find indices of features containing "-mean()" or "-std()"
# HINT: The pattern is "-(mean|std)\\(\\)"
# HINT: grep() searches for a pattern and returns matching positions
# BREAKDOWN of pattern:
#   - The dash before mean/std
#   (mean|std) = either "mean" OR "std"
#   \\(\\) = literal parentheses (escaped because () are special in regex)

mean_std_features <- grep("-(mean|std)\\(\\)", features$feature_name)

# TODO: Extract the feature names at those indices
# HINT: Use features$feature_name[mean_std_features]

selected_features <- features$feature_name[mean_std_features]
selected_features

# INTERACTIVE CHECK #6

list.files(data_path)
length(mean_std_features)
head(selected_features)
# ============================================================================
# STEP 5: Load and Process Training Data
# ============================================================================
# The training set contains 7,352 observations (70% of total data)
# collected from 21 of the 30 subjects.
#
# WHY THREE SEPARATE FILES?
# - X_train.txt: The actual measurements (7352 rows × 561 columns)
# - y_train.txt: Which activity was performed (7352 rows × 1 column)
# - subject_train.txt: Which person performed it (7352 rows × 1 column)
#
# We need to combine these files column-wise to have complete information:
# [subject | activity | measurement1 | measurement2 | ... | measurement561]

# LOADING X_train.txt (Feature Measurements)
# ----------------------------------------------------------------------------
# TODO: Load X_train.txt and select only the mean/std columns
# HINT: Use [, mean_std_features] after reading to select specific columns
# EXPLANATION: [rows, columns] - leaving rows blank selects all rows

X_train <- read.table(file.path(data_path, "train", "X_train.txt"))[, mean_std_features]
X_train
# TODO: Set descriptive column names for X_train
# HINT: Use colnames(X_train) <- selected_features

colnames(X_train) <- selected_features

# INTERACTIVE CHECK #7

dim(X_train)

colnames(X_train)[1:5]


# LOADING y_train.txt (Activity Labels)
# ----------------------------------------------------------------------------
# TODO: Load y_train.txt with column name "activity_id"
# HINT: Use col.names = "activity_id" parameter in read.table()

y_train <- read.table(file.path(data_path, "train", "y_train.txt"), 
                      col.names = "activity_id")

# INTERACTIVE CHECK #8
# Verify y_train:
dim(y_train)
table(y_train$activity_id)


# LOADING subject_train.txt (Subject IDs)
# ----------------------------------------------------------------------------
# TODO: Load subject_train.txt with column name "subject"

subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"), 
                            col.names = "subject")

# INTERACTIVE CHECK #9
# Verify subject_train:

dim(subject_train)
length(unique(subject_train$subject))
table(subject_train$subject) # Count observations per subject


# ============================================================================
# STEP 6: Load and Process Test Data
# ============================================================================
# The test set contains 2,947 observations (30% of total data)
# collected from the remaining 9 of the 30 subjects.
#
# We repeat the EXACT same process as with training data.

# TODO: Load X_test.txt and select only the mean/std columns

X_test <- read.table(file.path(data_path, "test", "X_test.txt"))[, mean_std_features]

# TODO: Set column names for X_test

colnames(X_test) <- selected_features 

# TODO: Load y_test.txt with column name "activity_id"

y_test <- read.table(file.path(data_path, "test", "y_test.txt"), 
                     col.names = "activity_id")

# TODO: Load subject_test.txt with column name "subject"

subject_test <- read.table(file.path(data_path, "test", "subject_test.txt"), 
                           col.names = "subject")

# INTERACTIVE CHECK #10
# Verify test data:
dim(X_test)
dim(y_test)
dim(subject_test)
length(unique(subject_test$subject))


# ============================================================================
# STEP 7: Combine Training and Test Datasets
# ============================================================================
# PROJECT REQUIREMENT: "Merge training and test data into one unified dataset"
#
# TWO-STEP PROCESS:
# 1. Combine columns within each dataset (cbind = column bind)
# 2. Stack datasets on top of each other (rbind = row bind)
#
# VISUAL REPRESENTATION:
# 
# Training: [subject_train | y_train | X_train] → data_train (7352 rows)
# Test:     [subject_test  | y_test  | X_test]  → data_test (2947 rows)
#                                ↓
#                     Stack vertically (rbind)
#                                ↓
#                        data_combined (10299 rows)


# ORDER MATTERS: We want subject first, then activity, then measurements

data_train <- cbind(subject_train, y_train, X_train)



data_test <- cbind(subject_test, y_test, X_test)



data_combined <- rbind(data_train, data_test)

# INTERACTIVE CHECK #11
# Verify the combined dataset:
dim(data_combined)  
                    
colnames(data_combined)[1:5]  
summary(data_combined[, 1:3])  

# ============================================================================
# STEP 8: Add Descriptive Activity Names
# ============================================================================
# PROJECT REQUIREMENT: "Use descriptive activity names for activities"
#
# Currently, data_combined has numeric activity codes (1, 2, 3, 4, 5, 6).
# We want descriptive names (WALKING, SITTING, etc.) for better understanding.
#
# PROCESS:
# 1. Merge data_combined with activity_labels by matching activity_id
# 2. Remove the numeric activity_id column (we only need the name now)

# TODO: Use merge() to join data_combined with activity_labels
# HINT: merge(x, y, by = "common_column", all.x = TRUE)
# EXPLANATION: 
#   - by = "activity_id" tells merge which column to match on
#   - all.x = TRUE keeps all rows from data_combined even if no match

data_combined <- merge(data_combined, activity_labels, by = "activity_id", all.x = TRUE)

# TODO: Remove the activity_id column (we only need descriptive names)
# HINT: Set the column to NULL: data_combined$activity_id <- NULL

data_combined$activity_id <- NULL

# INTERACTIVE CHECK #12
# Verify the activity names:
# colnames(data_combined)[1:3]  # Should show: "subject", "activity", then features
colnames(data_combined)[1:3]

# table(data_combined$activity)  # Count of each activity type
table(data_combined$activity)

# unique(data_combined$activity)  # Should show 6 activity names
unique(data_combined$activity)

# ============================================================================
# STEP 9: Create Tidy Dataset with Averages
# ============================================================================
# PROJECT REQUIREMENT: "Create a tidy dataset with the average of each 
# variable for each activity and each subject"
#
# WHAT THIS MEANS:
# Currently: Multiple observations per subject-activity combination
# Example: Subject 1 performing WALKING might have 95 separate measurements
#
# We want: ONE row per subject-activity combination with AVERAGE values
# Example: Subject 1 WALKING → one row with mean of all measurements
#
# CALCULATION:
# - 30 subjects × 6 activities = 180 unique combinations
# - Final dataset should have 180 rows
#
# DPLYR PIPELINE EXPLANATION:
# data_combined %>%                    # Start with our data, then...
#   group_by(subject, activity) %>%    # Group by subject-activity pairs
#   summarise(across(everything(), mean))  # Calculate mean of all other columns

# TODO: Complete the dplyr pipeline
# HINT: group_by() needs two grouping variables: subject and activity
# HINT: summarise() should use across(everything(), mean) to average all columns

tidy_data <- data_combined %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean))

# INTERACTIVE CHECK #13
# Verify the tidy dataset:
# dim(tidy_data)  # Should be: 180 rows × 68 columns
#                 # (180 = 30 subjects × 6 activities)
dim(tidy_data)

# head(tidy_data)  # View first few rows
head(tidy_data)

# View(tidy_data)  # Open in RStudio viewer
View(tidy_data)

# Check if we have all subject-activity combinations:
# nrow(unique(tidy_data[, c("subject", "activity")]))  # Should be 180
nrow(unique(tidy_data[, c("subject", "activity")]))

# ============================================================================
# STEP 10: Save the Tidy Dataset
# ============================================================================
# PROJECT REQUIREMENT: Submit a tidy dataset

# TODO: Save tidy_data to "tidy_dataset.txt" without row names
# HINT: write.table(data, "filename.txt", row.name = FALSE)
# NOTE: It's row.name (singular), not row.names!

write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)

# INTERACTIVE CHECK #14
# Verify the file was saved:
# list.files(pattern = "tidy_dataset.txt")  # Should show the file
# 
list.files(pattern = "tidy_dataset.txt")

# To reload and verify:
# test_data <- read.table("tidy_dataset.txt", header = TRUE)
# dim(test_data)  # Should be: 180 rows × 68 columns
test_data <- read.table("tidy_dataset.txt", header = TRUE)

dim(test_data)

# ============================================================================
# FINAL VERIFICATION CHECKLIST
# ============================================================================
# Before submitting, verify your results:
#
# ✓ tidy_data has 180 rows (30 subjects × 6 activities)
# ✓ tidy_data has 68 columns (subject + activity + 66 feature averages)
# ✓ All column names are descriptive (not V1, V2, etc.)
# ✓ Activity column contains names (not numbers 1-6)
# ✓ Each subject appears exactly 6 times (once per activity)
# ✓ File "tidy_dataset.txt" exists in your working directory
#
# Run these commands to verify:
# dim(tidy_data)
# colnames(tidy_data)[1:5]
# table(tidy_data$subject)  # Each subject should appear 6 times
# table(tidy_data$activity)  # Each activity should appear 30 times
# summary(tidy_data[, 1:5])

# ============================================================================
# REFLECTION QUESTIONS (Include answers in your README.md)
# ============================================================================
# 1. Why did we merge the training and test datasets? What was their original
#    purpose, and why don't we need them separated for this project?
#
# 2. How many observations did each subject contribute to the study?
#    (HINT: Use table(data_combined$subject) to find out)
#
# 3. Why did we select only mean() and std() features? What do these 
#    statistics tell us about the data?
#
# 4. What does it mean for data to be "tidy"? How does our final tidy_data
#    dataset follow tidy data principles?
#
# 5. What is the interpretation of one row in the tidy_data dataset?
#    What does a single value in one of the measurement columns represent?
#
# ============================================================================
# NEXT STEPS FOR YOUR GROUP PROJECT
# ============================================================================
# Now that you have the code, you need to complete:
#
# 1. README.md: Explain how to run this script and what it does
#    - How to download and extract the dataset
#    - How to set the working directory
#    - What each step of the script accomplishes
#    - How to verify the results
#
# 2. CodeBook.md: Document the data and variables
#    - Data source and description
#    - Description of each variable (subject, activity, and features)
#    - Transformations performed (merging, filtering, averaging)
#    - Units of measurement
#
# 3. Push to GitHub:
#    - GroupWork.R (this script)
#    - README.md
#    - CodeBook.md
#    - tidy_dataset.txt (the output file)
#
# ============================================================================