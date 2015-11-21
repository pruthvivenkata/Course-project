Explanation of the script:
1.	Imported all the data sets pertaining to training and testing  into R using read.table () function. Also, assigned the appropriate column names to the attributes in the tables
2.	Used cbind ()  to  combine the  subject ID, Activity ID and feature values tables to create the final training and testing data sets respectively.
3.	Used rbind()  to combine the final training and test data sets to create the complete data set
4.	grep() was used to retain the necessary measurement columns along with the ID columns
5.	Activity labels data set was imported and merged with the main data set to assign the corresponding activity names to activity IDs. Merge() was used for this purpose.
6.	gsub() was used to assign appropriate names to the columns such that the column names are self descriptive
7.	melt() and Dcast()  were used to create mean of the measurement columns across the combination each subject and activity.
8.	Write.table() was used to create the final tidy data set.


