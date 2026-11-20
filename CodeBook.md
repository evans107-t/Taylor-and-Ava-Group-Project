CodeBook: Human Activity Recognition Tidy Dataset
================
Taylor Evans and Ava Wertman
2026-11-20

# CodeBook: Human Activity Recognition Tidy Dataset

## 1. Data Set Overview

### Source

Human Activity Recognition Using Smartphones Dataset, Version 1.0
(November 2010). Collected by Jorge L. Reyes-Ortiz, Davide Anguita,
Alessandro Ghio, and Luca Oneto at Smartlab, Non Linear Complex Systems
Laboratory, DITEN, Università degli Studi di Genova, Genoa, Italy.

### Study Design

- 30 volunteers between the ages of 19 to 48 years old each preformed
  six activities while wearing a smartphone, Samsung Galaxy S II, on the
  waist.
- The smartphones embedded accelerometer and gyroscope captured 3-axial
  linear acceleration and 3-axial angular velocity at a constant rate of
  50Hz.
- The experiments were video recorded in order to label the data
  manually.
- The dataset was randomly split by volunteer. 70% of the volunteers
  were used for the training data and 30% for the test data. \###
  Activity Labels Each activity has a numeric code, linked to its name
  in ‘activity_labels.txt’ \| Code \| Activity \| \|——\|——————–\| \| 1
  \| WALKING \| \| 2 \| WALKING_UPSTAIRS \| \| 3 \| WALKING_DOWNSTAIRS
  \| \| 4 \| SITTING \| \| 5 \| STANDING \| \| 6 \| LAYING \|

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

### Raw Files Used

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
Spain. Dec 2012
