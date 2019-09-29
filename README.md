# human-activity
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================

This tidy data set is derived from the Human Activity Recognition Using Smartphones Dataset.

Original dataset description:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the original data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


==================================================================

From 'activity_labels.txt': we load a table of the names
From 'features.txt' we get the column names for all the features

After loading the data from all the txt files we can start to combine them

First, we join the y_train labels for each subject, same with the test.  We get a table with the same amount of rows than the other files.
Then we bind the labels with the x_train data with all the features.

Using regular expressions ("mean|std") we extract all columns with the variable names "mean" and "std"

To get the tidy data with the averages, we first group_by the subject and the activity.
Then using summarise_all we get averages of each of the other columns, which are the features taken from the Smartphones.

You can see this data set by looking at the *tidy_averages* variable.