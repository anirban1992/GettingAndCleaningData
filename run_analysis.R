#1 Merge the training set and test set.

# reads the data for X
data1 <- rbind(read.table("train/X_train.txt"),read.table("test/X_test.txt"))
# reads the data for y
data2 <- rbind(read.table("train/y_train.txt"),read.table("test/y_test.txt"))
# reads the data for subject
subject <- rbind(read.table("train/subject_train.txt"),read.table("test/subject_test.txt"))

#2 Extract measurements from columns containing mean and std in the name.

f <- read.table("features.txt")
f_mean <- grep("-mean\\(\\)", f[, 2]) # matches with names containing mean
f_std <- grep("-std\\(\\)", f[, 2]) # matches with names containing std
required_index <- sort(c(f_mean,f_std)) # combines the indices got above
data1 <- data1[, required_index] # fetches the data based on the indices
names(data1) <- f[required_index, 2] # fetches the columns related to mean and std
names(data1) <- gsub("\\(|\\)", "", names(data1)) # to remove the brackets in the name
names(data1) <- toupper(names(data1)) #for capitalise

#3 Uses descriptive activity names to name the activities in the data set.

a <- read.table("activity_labels.txt")
data2[,1] = a[data2[,1], 2]
names(data2) <- "ACTIVITY" #simply renaming

#4 Appropriately labels the data set with descriptive activity names. 

names(subject) <- "SUBJECT"
final_data <- cbind(subject, data2, data1) # combining X, y and subject

#5 Creates a second, independent tidy data set with the average of each variable
## for each activity and each subject.

# finding the no of subjects (unique)
S <- unique(subject)[,1] 
totalCol <- dim(final_data)[2]
# creating the tidy_data table initially
tidy_data <- final_data[1:(length(S)*length(a[,1])),]

counter = 1
for (i in 1:length(S)) # iteration based on no of subjects (unique)
{
  for (j in 1:length(a[,1])) # iteration based on no of activities (unique)
  {
    tidy_data[counter, 1] = S[i]
    tidy_data[counter, 2] = a[j, 2]
    # check if subject and activity matches with final merged data
    check <- final_data$SUBJECT==i & final_data$ACTIVITY==a[j, 2]
    temp_data <- final_data[check, ]
    #attaching the other columns to that row
    tidy_data[counter, 3:totalCol] <- colMeans(temp_data[, 3:totalCol])
    counter = counter + 1
  }
}

# writes the file to file name tidy_data.txt
write.table(tidy_data, "tidy_data.txt")
