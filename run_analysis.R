
## Validate working directory and donwload the zip files in the working directory using the link provided in the assignment
getwd()

## Load the train and test datasets
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")

## Load the rest of data sets in the folder
variable_names <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Inspect the data sets
summary(subject_train)
View(subject_train)
summary(x_train)
View(x_train)
summary(y_train)
View(y_train)
summary(subject_test)
View(subject_train)
summary(x_test)
View(x_test)
summary(y_test)
View(y_test)



## Assignment task 1: Merge the training and the test sets to create one data set
subject_data <- rbind(subject_train, subject_test)
x_data <- rbind(x_train, x_test)
y_data<- rbind(y_train, y_test)



## Assignment task 2: Extract only the measurements on the mean and standard deviation for each measurement
selected_variables <- variable_names[grep("mean|std",variable_names[,2]),]
selected_x <- x_data[,selected_variables[,1]]


## Assignment task 3: Use descriptive activity names to name the activities in the data set
y_data [,1] <- activity_labels[y_data[,1], 2]
names(y_data) <- "activity"


## Assignment task 4:Appropriately labels the data set with descriptive variable names
colnames(selected_x) <- selected_variables[,2]
  

## Assignment task 5: From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject

colnames(subject_data) <- "subject" ##so we can group by subject
all_data <- cbind(selected_x, y_data, subject_data)
tidy_data <- all_data %>% group_by(activity, subject) %>% summarize_each(funs(mean))

# write final tidy data
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE, col.names = TRUE)


