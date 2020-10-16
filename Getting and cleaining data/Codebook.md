#CODEBOOK
**run_analysis.R** script performs the data preparation and analysis and then followed by the 5 steps as described in the course project’s definition.

-To run the code in R it is required to load dplyr package.

1. **Download DataSet**
    -downloaded and extracted under the folder called UCI HAR Dataset.
2. **Reading data in variables**
    -features <- features.txt : 561 rows, 2 columns
      *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
    -act_labels <- activity_labels.txt : 6 rows, 2 columns
      *List of activities performed when the corresponding measurements were taken and its codes (labels)*
    -sub_test <- test/subject_test.txt : 2947 rows, 1 column
      *contains test data of 9/30 volunteer test subjects being observed*
    -test_x <- test/X_test.txt : 2947 rows, 561 columns
      *contains recorded features test data*
    -test_y <- test/y_test.txt : 2947 rows, 1 columns
      *contains test data of activities’code labels*
    -sub_train <- test/subject_train.txt : 7352 rows, 1 column
      *contains train data of 21/30 volunteer subjects being observed*
    -train <- test/X_train.txt : 7352 rows, 561 columns
      *contains recorded features train data*
    -train_y <- test/y_train.txt : 7352 rows, 1 columns
      *contains train data of activities’code labels* 

3. **Merges the training and the test sets to create one data set**
    -x (10299 rows, 561 columns) is created by merging train_x and test_x using **rbind() func**.
    -y (10299 rows, 1 column) is created by merging y_train and y_test using **rbind() func**.
    -subject (10299 rows, 1 column) is created by merging subject_train and subject_test using **rbind() func**.
    -merge_Data (10299 rows, 563 column) is created by merging Subject, Y and X using **cbind() func**.

4. **Extracts only the measurements on the mean and standard deviation for each measurement**
    -tidy_data (10299 rows, 88 columns) is created by subsetting merge_Data, selecting only columns: subject, id and the measurements on the mean and standard deviation (std) for each measurement

5. **Uses descriptive activity names to name the activities in the data set**
    -Entire numbers in id column of the tidy_data replaced with corresponding activity taken from second column of the act_labels variable

6. **Appropriately labels the data set with descriptive variable names**
    -id column in tidy_data renamed into activities
    -All Acc in column’s name replaced by Accelero
    -All Gyro in column’s name replaced by Gyroscope
    -All BodyBody in column’s name replaced by Body
    -All Mag in column’s name replaced by Magnitude
    -All start with character f in column’s name replaced by Freq
    -All start with character t in column’s name replaced by Time

7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
    -group_data is created by grouping the tidy_data by subject and acitivity.
    -summary (180 rows, 88 columns) is created by sumarizing group_data taking the means of each variable for each activity and each subject.
    -assigning summary to final_data variable.
    -Export final_data into Final_Data.txt file.