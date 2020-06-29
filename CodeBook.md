The run_analysis.R script is described right below. 

1. Download the dataset

	Dataset downloaded and unzipped under the folder "UCI HAR Dataset"

2. Assign each data to variables

	features <- features.txt (561 rows, 2 columns). Features come from de gyroscope and the accelerometer data.

	activities <- activity_labels.txt  (6 rows, 2 columns). List of activities (with codes) performed when the measurements were taken.

	subject_test <- test/subject_test.txt (2947 rows, 1 column). Test data of the volunteers.

	x_test <- test/X_test.txt (2947 rows, 561 columns) Recorded features test data
	
	y_test <- test/y_test.txt (2947 rows, 1 columns) Test data of activities (using code)

	subject_train <- test/subject_train.txt  (7352 rows, 1 column). Train data of volunteers.

	x_train <- test/X_train.txt (7352 rows, 561 columns) Recorded features train data

	y_train <- test/y_train.txt (7352 rows, 1 columns) Train data of activities (using code)

3. Merge the training and the test sets to create one data set

	x_frame (10299 rows, 561 columns). Binding x_train and x_test using rbind() function
	
	y_frame (10299 rows, 1 column).Binding y_train and y_test using rbind() function
	
	subject (10299 rows, 1 column). Binding subject_train and subject_test using rbind() function
	
	mergedData (10299 rows, 563 column). Binding the 3 data frames above using cbind() function

4. Extract only the measurements on the mean and standard deviation for each measurement

	tidy_data (10299 rows, 88 columns) mergedData frame, subsetted by using only subject, code, and every variable including "meand" or "std".

5. Uses descriptive activity names to name the activities in the data set

	Code numbers for each activity replaced with the activity name, using the activities tabla already read.

6. Appropriately labels the data set with descriptive variable names

	Replaces every prefix (t, f) and abbreviations (Acc, Gyro, Mag) by its full names. Removes internal dots and creates full descriptive variable names.

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

	DATA (180 rows, 88 columns).  Summarizes tidy_data, finding the mean of each activity for each subjetc. Then creates DATA.txt file.
