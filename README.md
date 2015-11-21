# How the script works?

The script named run_analysis.R does the following: 

* First, it merges the training and the test sets to create one data set using rbind function.
* Then it extracts only the measurements on the mean and standard deviation for each measurement. 
* Later it uses descriptive activity names provided to name the activities in the data set
* After that, it appropriately labels the data set with descriptive variable names. 
* Finally, it takes the data set in step 4 and creates a second independent tidy data set with the average of each variable for each activity and each subject. It also use write.table() function to create a .txt file.
#Project
