##################################################################
#  IMPORTANT:This script must be run inside folder of unzip files

#library(data.table)
library(dplyr)
library(reshape2)

#Read labels
label_tab <- read.table("activity_labels.txt")
activitys <- as.character(label_tab[,2])

#Read features
features_tab <- read.table("features.txt")
features <- as.character(features_tab[,2])
# only mean and std features
log_fea <- grepl(".*mean.*|.*std.*", features)
features_mean_std <- features[log_fea] 
features_mean_std = gsub('mean', 'MEAN', features_mean_std)
features_mean_std = gsub('std', 'STD', features_mean_std)
features_mean_std = gsub('[-()]', '', features_mean_std)

#Read test data
test_x <- read.table("./test/X_test.txt")
test_x <- test_x[,log_fea]  # only mean and std
test_label <- read.table("./test/y_test.txt")
test_label_fac <- factor(test_label$V1, levels = c("1","2","3","4","5","6"), labels = activitys) 
test_subject <- read.table("./test/subject_test.txt")
test_subject <- factor(test_subject$V1)
test_x <- cbind(test_x, test_subject, test_label_fac)
colnames(test_x) <- c(features_mean_std,"subject","activity")

#Read train data
train_x <- read.table("./train/X_train.txt")
train_x <- train_x[,log_fea] # only mean and std
train_label <- read.table("./train/y_train.txt")
train_label_fac <- factor(train_label$V1, levels = c("1","2","3","4","5","6"), labels = activitys) 
train_subject <- read.table("./train/subject_train.txt")
train_subject <- factor(train_subject$V1)
train_x <- cbind(train_x, train_subject, train_label_fac)
colnames(train_x) <- c(features_mean_std,"subject","activity")


# Merge test and train data
mergeData <- rbind(test_x,train_x)

# Grup by subject and activity
mergeData_melt <- melt(mergeData, id = c("subject", "activity"))
mergeData_mean <- dcast(mergeData_melt, subject + activity ~ variable, mean)


write.table(mergeData_mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)

