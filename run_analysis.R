##Install and use required packages
install.packages("dplyr")
library(dplyr)

##Load all training data seperated into subject, activities and measurements
subjects_train<-read.csv("UCI HAR Dataset/train/subject_train.txt",header = FALSE)
activity_train<-read.csv("UCI HAR Dataset/train/y_train.txt",header = FALSE)
measurements_train<-read.csv("UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "")

##Load all test data seperated into subject, activities and measurements
subjects_test<-read.csv("UCI HAR Dataset/test/subject_test.txt",header = FALSE)
activity_test<-read.csv("UCI HAR Dataset/test/y_test.txt",header = FALSE)
measurements_test<-read.csv("UCI HAR Dataset/test/X_test.txt",header = FALSE,sep="")

##Load features data also calculate the indexes of activities containing mean() or std()
##Finally load the names of identified indexes to be used later to give descriptive names
features<-read.table("UCI HAR Dataset/features.txt",header = FALSE)
select_columns<-which(grepl("mean\\(\\)|std\\(\\)",features$V2))
name_measures<-features[grepl("mean\\(\\)|std\\(\\)",features$V2),2]

##Read activity descriptions
activities<-read.table("UCI HAR Dataset/activity_labels.txt",sep = "")

##Select needed columns from train data (ie the columns of mean() and std()) and assign correct names to columns
measurements_train<-measurements_train[,select_columns]
names(measurements_train)<-name_measures
names(activity_train)<-"Activity_nr"
names(subjects_train)<-"Subject"

##Select needed columns from test data (ie the columns of mean() and std()) and assign correct names to columns
measurements_test<-measurements_test[,select_columns]
names(measurements_test)<-name_measures
names(activity_test)<-"Activity_nr"
names(subjects_test)<-"Subject"

##Assign correct names to activities table
names(activities)<-c("Activity_nr","Activity")

##Combine the tables so that order is remained, cbind before merge with activities 
train_set_comb<-cbind(subjects_train,activity_train,measurements_train)
test_set_comb<-cbind(subjects_test,activity_test,measurements_test)

##Append training and test data
data_comb<-rbind(train_set_comb,test_set_comb)

##Merge so descriptive names for activities can be used and remove activity numbers
##Also reorder table so logic is: subject,activity,measurements
full_data<-merge(data_comb,activities)
full_data<-full_data[,-1]
full_data<-full_data[,c(1,68,2:67)]

##Group the data by Subject and Activity and then use summarize to calculate the mean for all measures
full_data %>% 
        group_by(Subject,Activity) %>%
        summarise_all(funs(mean)) ->
finalDataSet

