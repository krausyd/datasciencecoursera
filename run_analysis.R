filename <- "dataset.zip"
if (!file.exists(filename)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", filename)
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#read the feature names, which are contained in file features.txt
features <- read.table("UCI HAR Dataset/features.txt")
features
#Convert to character
features[,2] <- as.character(features[,2])
features

#we only need the features that are the mean and standard deviation, so we get the index of only those from our features dataset
features_to_get <- grep(".*mean.*|.*std.*", features[,2])
features_to_get
#we set the names to the index
features_to_get.names <- features[features_to_get,2]
#change for prettier names
features_to_get.names = sub('-mean\\(\\)', 'Mean', features_to_get.names)
features_to_get.names = sub('-std\\(\\)', 'Std', features_to_get.names)
features_to_get.names = sub('-meanFreq\\(\\)', 'MeanFreq', features_to_get.names)
features_to_get.names = sub('-()', '', features_to_get.names)
features_to_get.names

#we load the training datasets, train/x-train.txt contains the entire training set, but we only need the means
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_data <- x_train[features_to_get]
#with summary we can notice that we get only the ones we need (means and std deviation)
summary(train_data)

#load the training lables, in train/Y_train.txt
train_labels <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_labels

#load the subjects being analyzed in train/subject_train.txt
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects

#merge all together using cbind
train_data<-cbind(subjects, train_labels, train_data)

#we load the testing datasets, test/x-test.txt contains the entire training set, but we only need the means
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_data <- x_test[features_to_get]
#with summary we can notice that we get only the ones we need (means and std deviation)
summary(test_data)

#load the test labels, in test/Y_test.txt
test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_labels

#load the subjects being analyzed in test/subject_test.txt
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_subjects

#merge all together using cbind
test_data<-cbind(test_subjects, test_labels, test_data)

#merge test and train data together using rbind
the_data<-rbind(train_data, test_data)

#set the correct names to the columns
colnames(the_data) <- c("subject", "activity", features_to_get.names)

#Load the activitye labels, which are located in file activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels
#Convert to character
activity_labels[,2] <- as.character(activity_labels[,2])
activity_labels

#change the values of column 1 and column 2 to correct names with the data we have already loaded
the_data$activity <- factor(the_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
#the subject column must be a factor to ease data analysis
the_data$subject <- as.factor(the_data$subject)

#Let's get the tidy that with the means per activity and subject
#for this, we use the melt and the dcast methods of reshape2 library
install.packages("reshape2")
library(reshape2)
melted<-melt(the_data, id = c("subject", "activity"))
data_mean<-dcast(melted, subject + activity ~ variable, mean)

#save the data to a file
write.table(data_mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)