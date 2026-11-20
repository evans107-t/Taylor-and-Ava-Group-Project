CodeBook: Human Activity Recognition Tidy Dataset
================
Taylor Evans and Ava Wertman
2026-11-20

## 1. Data Overview

### Purpose

This project collects, works with, and cleans the Human Activity
Recognition data to prepare a tidy dataset that can be used for further
analysis.

### Source

Human Activity Recognition Using Smartphones Dataset, Version 1.0
(November 2012). Collected by Jorge L. Reyes-Ortiz, Davide Anguita,
Alessandro Ghio, and Luca Oneto at Smartlab, Non Linear Complex Systems
Laboratory, DITEN, Università degli Studi di Genova, Genoa, Italy.

### Study Design

- 30 volunteers between 19 and 48 years old each performed six
  activities while wearing a Samsung Galaxy S II smartphone on the
  waist.
- The smartphone’s embedded accelerometer and gyroscope captured 3-axial
  linear acceleration and 3-axial angular velocity at a constant rate of
  50 Hz.
- The experiments were video recorded in order to label the data
  manually.
- The dataset was randomly split by volunteer. 70% of the volunteers
  were used for the training data and 30% for the test data.

### Activity Labels

Each activity has a numeric code, linked to its name in
`activity_labels.txt`:

| Code | Activity           |
|------|--------------------|
| 1    | WALKING            |
| 2    | WALKING_UPSTAIRS   |
| 3    | WALKING_DOWNSTAIRS |
| 4    | SITTING            |
| 5    | STANDING           |
| 6    | LAYING             |

### Signal Processing

- The raw accelerometer and gyroscope signals (tAcc-XYZ and tGyro-XYZ)
  were filtered with a median filter and a 3rd order low pass
  Butterworth filter with a corner frequency of 20 Hz to remove noise.
- The signals were then sampled in fixed-width sliding windows of 2.56
  seconds with 50% overlap (128 readings per window).
- The acceleration signal was separated into body and gravity signals
  using another low pass Butterworth filter with a 0.3 Hz cutoff, since
  gravity is assumed to have only low frequency components.
- From each window, the researchers calculated a vector of 561 features
  from the time and frequency domains.

### Raw Data Files Used

| File | Contents |
|----|----|
| `features.txt` | List of all 561 features |
| `activity_labels.txt` | Links the activity codes to their names |
| `train/X_train.txt` | Training set |
| `train/y_train.txt` | Training labels |
| `train/subject_train.txt` | Subject who performed the activity for each window (1 to 30) |
| `test/X_test.txt` | Test set |
| `test/y_test.txt` | Test labels |
| `test/subject_test.txt` | Subject who performed the activity for each window (1 to 30) |

### Citation

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
Reyes-Ortiz. Human Activity Recognition on Smartphones using a
Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012.

## 2. Variable Descriptions

`tidy_dataset.txt` has 180 rows and 68 columns. Following tidy data
principles, each variable is in one column and each observation is in
its own row. Each row is one subject doing one activity (30 subjects × 6
activities). Columns 1 and 2 identify the row. Columns 3 to 68 hold the
measurements.

### Identifier Variables

| \# | Variable | Data Type | Values | Description |
|----|----|----|----|----|
| 1 | `subject` | integer | 1 to 30 | ID of the volunteer who performed the activity |
| 2 | `activity` | character | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING | Descriptive activity name, matched from its code in `activity_labels.txt` |

### Measurement Variables

All 66 measurement variables are numeric (double). Each value is the
**average** (calculated with `mean()`) of that feature across every
window recorded for that subject doing that activity.

The variable names follow the naming in `features_info.txt`:

| Part of name | Meaning |
|----|----|
| `t` prefix | Time domain signal, captured at a constant rate of 50 Hz |
| `f` prefix | Frequency domain signal, produced by applying a Fast Fourier Transform (FFT) |
| `Body` | Body motion part of the signal |
| `Gravity` | Gravity part of the acceleration signal, separated with a 0.3 Hz low pass Butterworth filter |
| `Acc` | Linear acceleration from the accelerometer |
| `Gyro` | Angular velocity from the gyroscope |
| `Jerk` | Jerk signal, obtained by deriving the body linear acceleration or angular velocity in time |
| `Mag` | Magnitude of the three-dimensional signal, calculated using the Euclidean norm |
| `mean()` | Mean value |
| `std()` | Standard deviation |
| `-X`, `-Y`, `-Z` | Direction of the 3-axial signal |

Six variable names contain `BodyBody` (columns 63 to 68). This doubling
comes from `features.txt` in the original dataset. `features_info.txt`
lists the same signals with a single `Body` (for example,
`fBodyAccJerkMag`). The names were kept as they appear in
`features.txt`.

The values in `tBodyAccMag-mean()` (column 33) and
`tGravityAccMag-mean()` (column 35) are identical in every row, as are
`tBodyAccMag-std()` (column 34) and `tGravityAccMag-std()` (column 36).
This comes from the original dataset, where features 201 and 214, and
features 202 and 215, are identical in both `X_train.txt` and
`X_test.txt`. The columns were kept as they appear in the raw data.

### Units of Measurement

According to the dataset README, the features are **normalized and
bounded within \[-1, 1\]**, so the measurement variables have no units.
Because each value in the tidy dataset is an average of values in that
range, every value also stays between -1 and 1.

Before the features were calculated, the raw signals were measured in
standard gravity units (g) for acceleration and radians/second for
angular velocity. The normalization removes those units.

### Full List of Measurement Variables

| \# | Variable | Description |
|----|----|----|
| 3 | `tBodyAcc-mean()-X` | Time domain, body acceleration, mean, X axis |
| 4 | `tBodyAcc-mean()-Y` | Time domain, body acceleration, mean, Y axis |
| 5 | `tBodyAcc-mean()-Z` | Time domain, body acceleration, mean, Z axis |
| 6 | `tBodyAcc-std()-X` | Time domain, body acceleration, standard deviation, X axis |
| 7 | `tBodyAcc-std()-Y` | Time domain, body acceleration, standard deviation, Y axis |
| 8 | `tBodyAcc-std()-Z` | Time domain, body acceleration, standard deviation, Z axis |
| 9 | `tGravityAcc-mean()-X` | Time domain, gravity acceleration, mean, X axis |
| 10 | `tGravityAcc-mean()-Y` | Time domain, gravity acceleration, mean, Y axis |
| 11 | `tGravityAcc-mean()-Z` | Time domain, gravity acceleration, mean, Z axis |
| 12 | `tGravityAcc-std()-X` | Time domain, gravity acceleration, standard deviation, X axis |
| 13 | `tGravityAcc-std()-Y` | Time domain, gravity acceleration, standard deviation, Y axis |
| 14 | `tGravityAcc-std()-Z` | Time domain, gravity acceleration, standard deviation, Z axis |
| 15 | `tBodyAccJerk-mean()-X` | Time domain, body acceleration jerk, mean, X axis |
| 16 | `tBodyAccJerk-mean()-Y` | Time domain, body acceleration jerk, mean, Y axis |
| 17 | `tBodyAccJerk-mean()-Z` | Time domain, body acceleration jerk, mean, Z axis |
| 18 | `tBodyAccJerk-std()-X` | Time domain, body acceleration jerk, standard deviation, X axis |
| 19 | `tBodyAccJerk-std()-Y` | Time domain, body acceleration jerk, standard deviation, Y axis |
| 20 | `tBodyAccJerk-std()-Z` | Time domain, body acceleration jerk, standard deviation, Z axis |
| 21 | `tBodyGyro-mean()-X` | Time domain, body angular velocity, mean, X axis |
| 22 | `tBodyGyro-mean()-Y` | Time domain, body angular velocity, mean, Y axis |
| 23 | `tBodyGyro-mean()-Z` | Time domain, body angular velocity, mean, Z axis |
| 24 | `tBodyGyro-std()-X` | Time domain, body angular velocity, standard deviation, X axis |
| 25 | `tBodyGyro-std()-Y` | Time domain, body angular velocity, standard deviation, Y axis |
| 26 | `tBodyGyro-std()-Z` | Time domain, body angular velocity, standard deviation, Z axis |
| 27 | `tBodyGyroJerk-mean()-X` | Time domain, body angular velocity jerk, mean, X axis |
| 28 | `tBodyGyroJerk-mean()-Y` | Time domain, body angular velocity jerk, mean, Y axis |
| 29 | `tBodyGyroJerk-mean()-Z` | Time domain, body angular velocity jerk, mean, Z axis |
| 30 | `tBodyGyroJerk-std()-X` | Time domain, body angular velocity jerk, standard deviation, X axis |
| 31 | `tBodyGyroJerk-std()-Y` | Time domain, body angular velocity jerk, standard deviation, Y axis |
| 32 | `tBodyGyroJerk-std()-Z` | Time domain, body angular velocity jerk, standard deviation, Z axis |
| 33 | `tBodyAccMag-mean()` | Time domain, body acceleration magnitude, mean |
| 34 | `tBodyAccMag-std()` | Time domain, body acceleration magnitude, standard deviation |
| 35 | `tGravityAccMag-mean()` | Time domain, gravity acceleration magnitude, mean |
| 36 | `tGravityAccMag-std()` | Time domain, gravity acceleration magnitude, standard deviation |
| 37 | `tBodyAccJerkMag-mean()` | Time domain, body acceleration jerk magnitude, mean |
| 38 | `tBodyAccJerkMag-std()` | Time domain, body acceleration jerk magnitude, standard deviation |
| 39 | `tBodyGyroMag-mean()` | Time domain, body angular velocity magnitude, mean |
| 40 | `tBodyGyroMag-std()` | Time domain, body angular velocity magnitude, standard deviation |
| 41 | `tBodyGyroJerkMag-mean()` | Time domain, body angular velocity jerk magnitude, mean |
| 42 | `tBodyGyroJerkMag-std()` | Time domain, body angular velocity jerk magnitude, standard deviation |
| 43 | `fBodyAcc-mean()-X` | Frequency domain, body acceleration, mean, X axis |
| 44 | `fBodyAcc-mean()-Y` | Frequency domain, body acceleration, mean, Y axis |
| 45 | `fBodyAcc-mean()-Z` | Frequency domain, body acceleration, mean, Z axis |
| 46 | `fBodyAcc-std()-X` | Frequency domain, body acceleration, standard deviation, X axis |
| 47 | `fBodyAcc-std()-Y` | Frequency domain, body acceleration, standard deviation, Y axis |
| 48 | `fBodyAcc-std()-Z` | Frequency domain, body acceleration, standard deviation, Z axis |
| 49 | `fBodyAccJerk-mean()-X` | Frequency domain, body acceleration jerk, mean, X axis |
| 50 | `fBodyAccJerk-mean()-Y` | Frequency domain, body acceleration jerk, mean, Y axis |
| 51 | `fBodyAccJerk-mean()-Z` | Frequency domain, body acceleration jerk, mean, Z axis |
| 52 | `fBodyAccJerk-std()-X` | Frequency domain, body acceleration jerk, standard deviation, X axis |
| 53 | `fBodyAccJerk-std()-Y` | Frequency domain, body acceleration jerk, standard deviation, Y axis |
| 54 | `fBodyAccJerk-std()-Z` | Frequency domain, body acceleration jerk, standard deviation, Z axis |
| 55 | `fBodyGyro-mean()-X` | Frequency domain, body angular velocity, mean, X axis |
| 56 | `fBodyGyro-mean()-Y` | Frequency domain, body angular velocity, mean, Y axis |
| 57 | `fBodyGyro-mean()-Z` | Frequency domain, body angular velocity, mean, Z axis |
| 58 | `fBodyGyro-std()-X` | Frequency domain, body angular velocity, standard deviation, X axis |
| 59 | `fBodyGyro-std()-Y` | Frequency domain, body angular velocity, standard deviation, Y axis |
| 60 | `fBodyGyro-std()-Z` | Frequency domain, body angular velocity, standard deviation, Z axis |
| 61 | `fBodyAccMag-mean()` | Frequency domain, body acceleration magnitude, mean |
| 62 | `fBodyAccMag-std()` | Frequency domain, body acceleration magnitude, standard deviation |
| 63 | `fBodyBodyAccJerkMag-mean()` | Frequency domain, body acceleration jerk magnitude, mean |
| 64 | `fBodyBodyAccJerkMag-std()` | Frequency domain, body acceleration jerk magnitude, standard deviation |
| 65 | `fBodyBodyGyroMag-mean()` | Frequency domain, body angular velocity magnitude, mean |
| 66 | `fBodyBodyGyroMag-std()` | Frequency domain, body angular velocity magnitude, standard deviation |
| 67 | `fBodyBodyGyroJerkMag-mean()` | Frequency domain, body angular velocity jerk magnitude, mean |
| 68 | `fBodyBodyGyroJerkMag-std()` | Frequency domain, body angular velocity jerk magnitude, standard deviation |

## 3. Missing Data Handling

The raw measurement files (`X_train.txt` and `X_test.txt`) contain no
missing values, and neither does the final tidy dataset. All 180 rows
and 68 columns of `tidy_dataset.txt` were checked, and none are `NA`.
Because there were no missing values, no rows were removed and no values
were filled in.

## 4. Data Processing

`GroupWork.R` takes the raw data as input and outputs the tidy dataset.
The project task each step completes is shown in parentheses.

1.  **Read the metadata.** `activity_labels.txt` (6 activity codes and
    names) and `features.txt` (561 feature names) were read with
    `read.table()`.
2.  **Select the mean and standard deviation features (Extract Relevant
    Measurements).** `grep()` with the pattern `"-(mean|std)\\(\\)"`
    found the 66 features whose names contain `-mean()` or `-std()`.
    Features such as `meanFreq()` and the `angle()` variables were left
    out, because they are different calculations.
3.  **Load the training data (Label Data with Descriptive Names).** Only
    the 66 selected columns of `X_train.txt` were kept, and `colnames()`
    named them with the matching names from `features.txt`. The activity
    codes (`y_train.txt`) and subject IDs (`subject_train.txt`) were
    read alongside them. The training set has 7,352 rows from 21
    subjects.
4.  **Load the test data (Label Data with Descriptive Names).** The same
    process was repeated for the test files, giving 2,947 rows from 9
    subjects.
5.  **Combine the training and test sets (Merge Training and Test
    Data).** Column binding with `cbind()` joined the subject, activity
    code, and measurement columns within each set. Row binding with
    `rbind()` then stacked the test rows under the training rows, giving
    one dataset of 10,299 rows and 68 columns.
6.  **Add descriptive activity names (Descriptive Activity Names).**
    `merge()` matched each activity code to its name in
    `activity_labels.txt` using the shared `activity_id` column. The
    numeric `activity_id` column was then removed.
7.  **Average by subject and activity (Create Tidy Data).**
    `group_by(subject, activity)` grouped the data by each subject and
    activity pair, giving 180 groups (30 subjects × 6 activities).
    `summarise(across(everything(), mean))` then collapsed each group
    into a single summary row holding the average of each of the 66
    measurement variables.
8.  **Save the tidy dataset.** `write.table()` saved the result to
    `tidy_dataset.txt` without row names, giving 180 rows and 68
    columns.

## 5. Code Instructions

### Software

- R version 4.6.1
- `dplyr` 1.2.1 (required)
- `tidyr` 1.3.2 and `readr` 2.2.0 (loaded by the script)

### Running the Script

1.  Download the dataset zip file from
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
2.  Unzip it. This creates a folder named `UCI HAR Dataset`.
3.  Put `GroupWork.R` in the same folder that contains
    `UCI HAR Dataset`.
4.  Install the packages if needed (only once per computer):
    `install.packages(c("dplyr", "tidyr", "readr"))`
5.  Open `GroupWork.R` and change the path inside `setwd()` to the
    folder from step 3.
6.  Run the whole script. It writes `tidy_dataset.txt` to that same
    folder.

### Reading the Tidy Dataset

``` r
tidy <- read.table("tidy_dataset.txt", header = TRUE)
```

## 6. Analysis Description

The analysis in this project is a summary of the raw data. For each of
the 30 subjects and each of the 6 activities, the script calculated the
average of every mean and standard deviation feature, across all the
windows recorded for that subject doing that activity.

- **One row** in `tidy_dataset.txt` represents one subject doing one
  activity.
- **One value** in a measurement column is the average of that feature
  over all of that subject’s windows for that activity. For example, the
  `tBodyAcc-mean()-X` value for subject 1 and WALKING is the average of
  the time domain body acceleration mean along the X axis across all of
  subject 1’s walking windows.

No further statistical analysis was performed. The tidy dataset is
prepared so it can be used for further analysis, such as comparing
activities or subjects.
