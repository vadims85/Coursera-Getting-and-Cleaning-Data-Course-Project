#Have the data.table and dplyr packages set prior to running script

library(data.table)
library(dplyr)

#initialize the url and the zip filename
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- "activedataUCI.zip"

## Download and unzip the dataset:
if (!file.exists(fname)){
  download.file(url, fname)
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(fname) 
}

# create tables for activity labels and features of the datasets
activity_tbl <- read.table("UCI HAR Dataset/activity_labels.txt")
features_tbl <- read.table("UCI HAR Dataset/features.txt")

# select the mean and std only
features_index <- grep("mean|std",features_tbl[,2])
features_value <- gsub('\\(\\)(-)?','', gsub('-std\\(\\)(-)?','Std',(gsub('-mean(-)?','Mean',grep("mean|std",features_tbl[,2], value = TRUE)))))

# create tables with the test and train with the features that give the mean and std only

train_tbl <- read.table("UCI HAR Dataset/train/X_train.txt")[features_index]
train_act_tbl <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject_tbl <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_combined_tbl <- cbind(train_subject_tbl,train_act_tbl,train_tbl)

test_tbl <- read.table("UCI HAR Dataset/test/X_test.txt")[features_index]
test_act_tbl <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject_tbl <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_combined_tbl <- cbind(test_subject_tbl,test_act_tbl,test_tbl)

# merge the test table and train table using rbind and give each column a name 
train_test_tbl <- rbind(train_combined_tbl,test_combined_tbl)
colnames(train_test_tbl) <- c("Subject", "Activity", features_value)

# used the function 'factor' to replace Activity column in the final data set with the activity names from the activity table
train_test_tbl$Activity <- factor(train_test_tbl$Activity, levels = activity_tbl[,1], labels = activity_tbl[,2])

# Group final table by Subject and Activity, and summarise each column
train_test_tbl %>% group_by(Subject,Activity) %>% summarise_each(funs(mean)) %>% 
write.table("Final_Tidy_Table.txt",row.names = FALSE, quote = FALSE)



