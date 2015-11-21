#use plyr
library(plyr)

##############
# Step 1: Merge the training and test sets to create one data set
##############

#read data
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create data sets for x and y
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

# create a data set for subject_data
subject_data <- rbind(subject_train, subject_test)

############
# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
############

#read data
features <- read.table("features.txt")

# consider only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the columns
x_data <- x_data[, mean_and_std_features]

# change column names
names(x_data) <- features[mean_and_std_features, 2]

##########
# Step 3: use activity names to name the activities in the data set
##########

#read data
activ <- read.table("activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activ[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

#########
# Step 4: label the data set with the variable names
#########

# correct column name
names(subject_data) <- "subject"

# create a single data set
all_data <- cbind(x_data, y_data, subject_data)

##########
# Step 5: Create independent tidy data set with the average of each variable for each activity and each subject
##########

# 66 <- 68 columns but last two (activity & subject)
aver_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(aver_data, "aver_data.txt", row.name=FALSE)
