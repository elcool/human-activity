# load libraries
library(lubridate)
library(dplyr)
library(tidyr)
library(plyr)

## some global variables for debugging
limitread = -1    #change to -1 for read all

starttime <- Sys.time()
######
# load data from sources
######

### load labels
activities <- read.delim("UCI_HAR_Dataset\\activity_labels.txt", header = FALSE, sep = " ", col.names = c("activity_id", "activity_name"))
features <- read.delim("UCI_HAR_Dataset\\features.txt", header = FALSE, sep = " ")

options(digits = 15)

#reload <- function(){
### load train
subject_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\subject_train.txt", header = FALSE, nrows=limitread, col.names = c("subject_id")))
x_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\X_train.txt", header = FALSE, nrows=limitread, col.names = features$V2)) # 4. add labels to large set
y_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\y_train.txt", header = FALSE, nrows=limitread, col.names = c("activity_id")))

body_acc_x_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_acc_x_train.txt", header = FALSE, nrows=limitread))
body_acc_y_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_acc_y_train.txt", header = FALSE, nrows=limitread))
body_acc_z_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_acc_z_train.txt", header = FALSE, nrows=limitread))

body_gyro_x_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_gyro_x_train.txt", header = FALSE, nrows=limitread))
body_gyro_y_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_gyro_y_train.txt", header = FALSE, nrows=limitread))
body_gyro_z_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\body_gyro_z_train.txt", header = FALSE, nrows=limitread))

total_acc_x_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\total_acc_x_train.txt", header = FALSE, nrows=limitread))
total_acc_y_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\total_acc_y_train.txt", header = FALSE, nrows=limitread))
total_acc_z_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\Inertial Signals\\total_acc_z_train.txt", header = FALSE, nrows=limitread))

### load test
subject_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\subject_test.txt", header = FALSE, nrows=limitread, col.names = c("subject_id")))
x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\X_test.txt", header = FALSE, nrows=limitread, col.names = features$V2)) # 4. add labels to large set
y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\y_test.txt", header = FALSE, nrows=limitread, col.names = c("activity_id")))

body_acc_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_x_test.txt", header = FALSE, nrows=limitread))
body_acc_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_y_test.txt", header = FALSE, nrows=limitread))
body_acc_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_z_test.txt", header = FALSE, nrows=limitread))

body_gyro_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt", header = FALSE, nrows=limitread))
body_gyro_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt", header = FALSE, nrows=limitread))
body_gyro_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt", header = FALSE, nrows=limitread))

total_acc_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_x_test.txt", header = FALSE, nrows=limitread))
total_acc_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_y_test.txt", header = FALSE, nrows=limitread))
total_acc_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_z_test.txt", header = FALSE, nrows=limitread))
#}

## merging datasets
#mergedSets <- function(){
    # 3. adding descriptive activity names
    y_activity_train <- join(y_train, activities)  # this joins on activity_id
    y_subject_act_train <- cbind(subject_train, y_activity_train)
    train_set <- cbind(y_subject_act_train, x_train)
    
    y_activity_test <- join(y_test, activities)  # this joins on activity_id
    y_subject_act_test <- cbind(subject_test, y_activity_test)
    test_set <- cbind(y_subject_act_test, x_test)
    
    #body_acc_x <<- rbind(body_acc_x_train, body_acc_x_test)
    #total_acc_x <<- rbind(total_acc_x_train, total_acc_x_test)
    
    mergedSet <- tbl_df(rbind(train_set, test_set)) %>% select(-activity_id)  # remove redundant column
    mergedSet
#}

#extract2 <- function(){
    names1 <- colnames(mergedSet)
    wantCols <- names1[grepl("mean|std", names1)]
    extractedSet <- select(mergedSet, c("subject_id", "activity_name", wantCols))
#}

#extractedSet <- extract2()


    #5. average of each var for each activity and subject
    tidy_averages <- extractedSet %>% group_by(subject_id, activity_name) %>% summarise_all(funs(mean))
    write.table(tidy_averages, file = "ave_by_activity.txt", row.names = FALSE)
    print(tidy_averages)



# total subjects = 30
# measurements (variables)
# 3 axial linear
# 3 axial angular
# rate of 50Hz
# training subjects = 70% (21)
# test subjects = 30%  (9)

endtime <- Sys.time()
#print (endtime - starttime)

