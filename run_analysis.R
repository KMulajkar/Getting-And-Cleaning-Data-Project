                                      ## Course Project ##


# Read training data

x_train <- read.table("train/X_train.txt")

y_train <- read.table("train/Y_train.txt")

subject_train <- read.table("train/subject_train.txt")


# Read test data
x_test <- read.table("test/X_test.txt")

y_test <- read.table("test/Y_test.txt")

subject_test <- read.table("test/subject_test.txt")


# Merge train data and test data
x_merged <- rbind(x_train, x_test)

y_merged <- rbind(y_train, y_test)

sub_merged <- rbind(subject_train, subject_test)

################################################################################################


features <-read.table("features.txt")

# Extract only the measurements on the mean and standard deviation for each measurement

mean_std <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns

x_merged <- x_merged[, mean_std]

# column names are corrected

names(x_merged) <- features[mean_std, 2]

##########################################################################
 
activities <- read.table("activity_labels.txt")

#update values with correct activity names
y_merged[ , 1] <- activities[y_merged[, 1], 2]

#column names are corrected
names(y_merged) <- "activity"
####################################################################################

#Appropriately label the data with descriptive variable names

#column names are corrected
names(sub_merged) <- "subject"

#bind all the data in a single data set
all_data <- cbind(x_merged, y_merged, sub_merged)

#####################################################################################

# create second, independent tidy data set with the average of each variable
# for each activity and each subject

tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# write tidy_data into tidy_data.txt file
write.table(tidy_data, "tidy_data.txt", row.name= FALSE)





