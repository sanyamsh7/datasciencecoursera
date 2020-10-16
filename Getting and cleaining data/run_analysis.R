# reading and assigning all data tables.
# set working directory as: UCI HAR DATASET after extracting 
# from the zip file.
# directory setup can be done using setwd().

# some functions below requires loading the dplyr package 
library(dplyr)
# reading activity labels and features
act_labels <- read.table("activity_labels.txt", col.names = c("id", "activity"))
features <- read.table("features.txt", col.names = c("num", "functions"))

# reading test data
sub_test <- read.table("test/subject_test.txt", col.names = "subject")
test_x <- read.table("test/X_test.txt", col.names = features$functions)
test_y <- read.table("test/y_test.txt", col.names = "id")

# reading training data
sub_train <- read.table("train/subject_train.txt", col.names = "subject")
train_x <- read.table("train/X_train.txt", col.names = features$functions)
train_y <- read.table("train/y_train.txt", col.names = "id")

## to view all the tables
## uncomment the below code lines
#View(activity_labels)
#View(features)
#View(subject_test)
#View(test_x)
#View(test_y)
#View(sub_train)
#View(train_y)
#View(train_x)

## MERGING THE TRAINING AND TEST SETS
# combining rows:
x <- rbind(train_x, test_x)
y <- rbind(train_y, test_y)
subject <- rbind(sub_train, sub_test)

# combing all columns:
merge_data <- cbind(subject, y, x)

## EXTRACT ONLY MEASUREMENTS ON MEAN AND STANDARD DEV.(for each measurement)
tidy_data <- select(merge_data, subject, id, contains("mean"), contains("std"))

## NAMING THE ACTIVITIES IN THE DATA SET
tidy_data$id <- act_labels[tidy_data$id, 2]

## LABELLING THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
names(tidy_data)[2] = "activity"
names(tidy_data) <- gsub("Acc", "Accelero", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Freq", names(tidy_data))
names(tidy_data) <- gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data) <- gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq()", "Freq", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))

## CREATING A SECOND DATA SET WITH 
## AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY 
## AND EACH SUBJECT

# grouping data:
# grouping doesn't change how the data looks (apart from listing
# how it's grouped)
# It changes how it acts with the other dplyr verbs
group_data <- group_by(tidy_data, subject, activity)

# summarising data: summarises all the variables and 
# calculates the mean of all the activity for each subject
summary <- summarise_all(group_data, funs(mean))

final_data <- summary
# writing a new table
# since the summary variable holds the final data
write.table(final_data, "Final_Data.txt", row.name=FALSE)