#Training Data sets
#importing activity ids for the training dataset and asigning  column name
activityids=read.table("y_train.txt")
names(activityids)[names(activityids)=="V1"]="activity_id"

#importing volunteer ids for the training dataset and asigning a column name
subjects=read.table("subject_train.txt")
names(subjects)[names(subjects)=="V1"]="subject_id"

#importing feature vector values, feature labels and subsequently assigning the feature labels to the coulmns of feature values training dataset
feature_values=read.table("X_train.txt")
feature_labels=read.table("features.txt")
names(feature_labels)[names(feature_labels)=="V2"]="featurelabel"
colnames(feature_values)=feature_labels[,2]

#column binding to get the final training data set
Final_train= cbind(subjects,activityids,feature_values)


#Test Data sets
#importing activity ids for the testing dataset and asigning  column name
activityids_T=read.table("y_test.txt")
names(activityids_T)[names(activityids_T)=="V1"]="activity_id"

#importing volunteer ids for the testing dataset and asigning a column name
subjects_T=read.table("subject_test.txt")
names(subjects_T)[names(subjects_T)=="V1"]="subject_id"

#importing feature vector values(testing) and subsequently assigning the feature labels to the coulmns of feature values testing dataset
feature_values_T=read.table("X_test.txt")
colnames(feature_values_T)=feature_labels[,2]

#column binding to get the final testing data set
Final_test= cbind(subjects_T,activityids_T,feature_values_T)

#complete data set
#1.combining the training and testing data set
Final_Data =rbind(Final_train,Final_test)

#2.subsetting the data set to keep id columns, mean and standard deviation mesaurement columns
Final_data_subset=Final_Data[,grep("activity|subject|mean\\()|std\\()",colnames(Final_Data))]

#importing activity labels data set  and asigning a column names
activity_labels=read.table("activity_labels.txt")
names(activity_labels)[names(activity_labels)=="V2"]="activitylabels"
names(activity_labels)[names(activity_labels)=="V1"]="activity_id"

#3.merging the activity labels to the the main data set(Final_data_subset)
Final_data_act_label=merge(Final_data_subset,activity_labels,by.x="activity_id", by.y="activity_id")

#converting the DATA TYPE of id columns to character
Final_data_act_label$activity_id= as.character(Final_data_act_label$activity_id)
Final_data_act_label$subject_id= as.character(Final_data_act_label$subject_id)

#4.assigning discreptive variable labels
change1=gsub("std\\()","Std_DEV",colnames(Final_data_act_label))
change2=gsub("^t","Time",change1)    
change3=gsub("^f","Frequency",change2)
change4=gsub("Mag","Magnitude", change3)
change5=gsub("Acc","Acceleration", change4)
change6=gsub("Gyro","Velocity",change5)
colnames(Final_data_act_label)=change6

 #5.creating the tidy data set
 FinalData_Melted=melt(Final_data_act_label, id = c("subject_id","activity_id", "activitylabels"))
 FinalData_mean <- dcast(FinalData_Melted, subject_id + activitylabels ~ variable, mean)
 write.table(FinalData_mean, "tidy.txt", row.names = FALSE, quote = FALSE)

