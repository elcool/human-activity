# load libraries
library(lubridate)
library(dplyr)
library(tidyr)

## some global variables for debugging
limitread = 30    #change to -1 for read all

######
# load data from sources
######

### load activity labels
activities <- read.delim("UCI_HAR_Dataset\\activity_labels.txt", header = FALSE, sep = " ")

readme <- function() {
    r <- read.delim("UCI_HAR_Dataset\\README.txt")
    r
}
options(digits = 10)

### load train
subject_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\subject_train.txt", header = FALSE, nrows=limitread, col.names = c("subject")))
x_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\X_train.txt", header = FALSE, nrows=limitread))
y_train <- tbl_df(read.table(file="UCI_HAR_Dataset\\train\\y_train.txt", header = FALSE, nrows=limitread, col.names = c("activity")))

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
subject_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\subject_test.txt", header = FALSE, nrows=limitread, col.names = c("subject")))
x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\X_test.txt", header = FALSE, nrows=limitread))
y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\y_test.txt", header = FALSE, nrows=limitread, col.names = c("activity")))

body_acc_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_x_test.txt", header = FALSE, nrows=limitread))
body_acc_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_y_test.txt", header = FALSE, nrows=limitread))
body_acc_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_acc_z_test.txt", header = FALSE, nrows=limitread))

body_gyro_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt", header = FALSE, nrows=limitread))
body_gyro_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt", header = FALSE, nrows=limitread))
body_gyro_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt", header = FALSE, nrows=limitread))

total_acc_x_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_x_test.txt", header = FALSE, nrows=limitread))
total_acc_y_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_y_test.txt", header = FALSE, nrows=limitread))
total_acc_z_test <- tbl_df(read.table(file="UCI_HAR_Dataset\\test\\Inertial Signals\\total_acc_z_test.txt", header = FALSE, nrows=limitread))




# total subjects = 30
# measurements (variables)
# 3 axial linear
# 3 axial angular
# rate of 50Hz
# training subjects = 70% (21)
# test subjects = 30%  (9)