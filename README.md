---
title: "README.md"
output: html_document
---

To run the run_analysis script you need to have the dplyr package installed.
The working directory should contain the following files:       

features.txt    
activity_labels.txt      
test/X_test.txt     
test/y_test.txt     
test/subject_test.txt       
train/X_train.txt       
train/y_train.txt       
train/subject_train.txt 

The script takes these data and produces a data frame of variable means grouped
by Subject x Activity. This data frame is stored as a variable named means_by_sub_activity
and is also written to /tidy_data.txt in the working directory.
