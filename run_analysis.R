#Clean human activity recognition data
#Data frame of variable means grouped
#by Subject x Activity will be calculated and
#stored in: means_by_sub_activity
#and written to /tidy_data.txt 

library(dplyr)

#Read in the data
var_names <- read.table("features.txt", colClasses = c("NULL", "character"))
activity_names <- read.table("activity_labels.txt", colClasses = c("NULL", "character"))
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#Combine the inputs, outputs, ids, train and test data into one data frame
x <- rbind.data.frame(x_train, x_test)
y <- rbind.data.frame(y_train, y_test)
subject <- rbind.data.frame(subject_train, subject_test)
data <- cbind.data.frame(subject, x, y)

#Give the columns and activity types informative names
colnames(data) <- c("Subject", var_names$V2, "Activity")
data$Activity <- factor(data$Activity, labels = as.vector(activity_names$V2))

#Extract the columns that are mean() or std()
mean_std_indices = which(sapply(var_names$V2,
    function(x) {grep("std\\(\\)", x) || grep("mean\\(\\)", x)} ))

#Remove non-alphanumeric characters from column names
mean_std_data <- with(data, cbind(Subject, data[,mean_std_indices+1], Activity))
colnames(mean_std_data) <- sapply(colnames(mean_std_data), function(x){
    gsub("[^[:alnum:]]", "", x)
})

#Create data frame of variable means grouped by Subject x Activity
sub_activity <- group_by(mean_std_data, Subject, Activity)
means_by_sub_activity <- summarise_each(sub_activity, funs(mean))
means_by_sub_activity <- data.frame(means_by_sub_activity)

#Write data to text file
write.table(means_by_sub_activity, row.name = FALSE, file = "tidy_data.txt")
