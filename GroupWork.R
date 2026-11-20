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
# Step 1: Load Packages
# ============================================================================

library(tidyr)


library(readr)


library(dplyr)


packageVersion("dplyr")

# ============================================================================
#Step 2: Set Working Directory
# ============================================================================

setwd("/Users/taylorevans/Desktop/DAT413GroupProject/Taylor and Ava GP")

getwd()
list.files() 


data_path <- "UCI HAR Dataset"


list.files(data_path)

# ============================================================================
# STEP 3: Load Metadata Files
# ============================================================================


activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), 
                              col.names = c("activity_id", "activity"))



features <- read.table(file.path(data_path, "features.txt"), 
                       col.names = c("index", "feature_name"))


dim(features)

head(features, 10)

View(features)

# ============================================================================
# STEP 4: Extract Mean and Standard Deviation Features
# ============================================================================


mean_std_features <- grep("-(mean|std)\\(\\)", features$feature_name)

selected_features <- features$feature_name[mean_std_features]

selected_features

list.files(data_path)

length(mean_std_features)

head(selected_features)

# ============================================================================
# STEP 5: Load and Process Training Data
# ============================================================================

X_train <- read.table(file.path(data_path, "train", "X_train.txt"))[, mean_std_features]
X_train

colnames(X_train) <- selected_features

dim(X_train)

colnames(X_train)[1:5]

y_train <- read.table(file.path(data_path, "train", "y_train.txt"), 
                      col.names = "activity_id")

dim(y_train)
table(y_train$activity_id)

subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"), 
                            col.names = "subject")

dim(subject_train)

length(unique(subject_train$subject))

table(subject_train$subject)

# ============================================================================
# STEP 6: Load and Process Test Data
# ============================================================================

X_test <- read.table(file.path(data_path, "test", "X_test.txt"))[, mean_std_features]

colnames(X_test) <- selected_features 

y_test <- read.table(file.path(data_path, "test", "y_test.txt"), 
                     col.names = "activity_id")

subject_test <- read.table(file.path(data_path, "test", "subject_test.txt"), 
                           col.names = "subject")

dim(X_test)

dim(y_test)

dim(subject_test)

length(unique(subject_test$subject))

# ============================================================================
# STEP 7: Combine Training and Test Datasets
# ============================================================================

data_train <- cbind(subject_train, y_train, X_train)

data_test <- cbind(subject_test, y_test, X_test)

data_combined <- rbind(data_train, data_test)

dim(data_combined)  
                    
colnames(data_combined)[1:5]  

summary(data_combined[, 1:3])  

# ============================================================================
# STEP 8: Add Descriptive Activity Names
# ============================================================================


data_combined <- merge(data_combined, activity_labels, by = "activity_id", all.x = TRUE)

data_combined$activity_id <- NULL

colnames(data_combined)[1:3]

table(data_combined$activity)

unique(data_combined$activity)

# ============================================================================
# STEP 9: Create Tidy Dataset with Averages
# ============================================================================

tidy_data <- data_combined %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean))

dim(tidy_data)

head(tidy_data)

View(tidy_data)

nrow(unique(tidy_data[, c("subject", "activity")]))

# ============================================================================
# STEP 10: Save the Tidy Dataset
# ============================================================================

write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)

list.files(pattern = "tidy_dataset.txt")

test_data <- read.table("tidy_dataset.txt", header = TRUE)

dim(test_data)

# ============================================================================
# FINAL VERIFICATION CHECKLIST
# ============================================================================

dim(tidy_data)

colnames(tidy_data)[1:5]

table(tidy_data$subject)

table(tidy_data$activity)

summary(tidy_data[, 1:5])

