# Require Packages
require(reshape2)
require(plyr)
require(data.table)

# Load activity labels + features
activites <- read.table("~/R-wd/UCI HAR Dataset/activity_labels.txt")
activites[,2] <- as.character(activites[,2])
features <- read.table("~/R-wd/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract mean and standard deviation data
wanted_features <- grep(".*mean.*|.*std.*", features[,2])
feature_labels <- features[wanted_features,2]
feature_labels <- gsub('-mean', 'Mean', feature_labels)
feature_labels <- gsub('-std', 'Std', feature_labels)
feature_labels <- gsub('[-()]', '', feature_labels)

# Load training sets
train <- read.table("~/R-wd/UCI HAR Dataset/train/X_train.txt")[wanted_features]
train_activities <- fread("~/R-wd/UCI HAR Dataset/train/Y_train.txt")
train_subjects <- fread("~/R-wd/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

#load test sets
test <- read.table("~/R-wd/UCI HAR Dataset/test/X_test.txt")[wanted_features]
test_activities <- fread("~/R-wd/UCI HAR Dataset/test/Y_test.txt")
test_subjects <- fread("~/R-wd/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge training and test sets with labels
all_data <- rbind.data.frame(train, test)
colnames(all_data) <- c("subject", "activity", feature_labels)

# turn activities & subjects into factors
all_data$activity <- factor(all_data$activity, levels = activites[,1], labels = activites[,2])
all_data$subject <- as.factor(all_data$subject)

all_data_melted <- melt(all_data, id = c("subject", "activity"))
all_data_mean <- dcast(all_data_melted, subject + activity ~ variable, mean)

write.table(all_data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)