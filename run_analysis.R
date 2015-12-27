# Required Packages
require(data.table)

# Check if file exists and download if it does not
if (!file.exists("~/R-wd/UCI HAR Dataset/activity_labels.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = "~/R-wd")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
  date = Sys.Date()
}

# Load activity labels, feature labels and features 
activities <- read.table("~/R-wd/UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])
features <- read.table("~/R-wd/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract mean and standard deviation data
wanted_features <- grep(".*mean.*|.*std.*", features[,2])
feature_labels <- features[wanted_features,2]
feature_labels <- gsub('-mean', 'Mean', feature_labels)
feature_labels <- gsub('-std', 'Std', feature_labels)
feature_labels <- gsub('[-()]', '', feature_labels)

# Load training sets
training_set <- read.table("~/R-wd/UCI HAR Dataset/train/X_train.txt")[wanted_features]
training_activities <- fread("~/R-wd/UCI HAR Dataset/train/Y_train.txt")
training_subjects <- fread("~/R-wd/UCI HAR Dataset/train/subject_train.txt")
training_set <- cbind(training_subjects, training_activities, training_set)

# Load test sets
test_set <- read.table("~/R-wd/UCI HAR Dataset/test/X_test.txt")[wanted_features]
test_activities <- fread("~/R-wd/UCI HAR Dataset/test/Y_test.txt")
test_subjects <- fread("~/R-wd/UCI HAR Dataset/test/subject_test.txt")
test_set <- cbind(test_subjects, test_activities, test_set)

# Merge training and test sets with labels
all_data <- rbind.data.frame(training_set, test_set)
colnames(all_data) <- c("subject", "activity", feature_labels)

# Turn activities & subjects into factors
all_data$activity <- factor(all_data$activity, levels = activities[,1], labels = activities[,2])
all_data$subject <- as.factor(all_data$subject)
all_data_melted <- melt(all_data, id = c("subject", "activity"))
all_data_mean <- dcast(all_data_melted, subject + activity ~ variable, mean)

# Write output file
write.table(all_data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)