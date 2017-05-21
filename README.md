# Getting and Cleaning Data - Course Project

run_analysis.R, does the following:

1. Source the data.table and dplyr library.
2. Initilize the url and the filename of the zip file for download.
2. Download the dataset and unzip the file if it does not already exist in the working directory.
3. Load and create tables for the activity and features info.
4. Create two vectors from features that contain the mean and the std only. One vector represents the index, 
   and second vector represents the full value name. 
5. Load tables with the test and train with the features that contain the mean and std only.
6. Merge the test table and train table and give each column a name.
7. Use the 'factor' function to replace Activity column in the final data set with the activity names from the activity table.
8. Create average of each variable for each activity and each subject by using the final dataset and write it as a text file 
   into the working directory and call it 'Final_Tidy_Table.txt'

