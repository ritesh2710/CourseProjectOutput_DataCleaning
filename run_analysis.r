# Get the activities labels for test data
ytest<-read.csv("ytest.csv")
ActLblTest<-read.csv("activity_labels.csv")
TestActivities<-merge(ytest,ActLblTest,by=c("srno"))
TestActivities[,2]

# Get the activities lables for training data
ytrain<-read.csv("ytrain.csv")
ActLblTrain<-read.csv("activity_labels.csv")
TrainActivities<-merge(ytrain,ActLblTrain,by=c("srno"))
TrainActivities[,2]

# Get subjects for test
subject_test<-read.csv("subject_test.csv")

# Get subjects for train
subject_train<-read.csv("subject_train.csv")

# Get the features list
features1<-read.csv("features.csv")
features<-features1[,2]

# Get the test data and assign column names 
xt<-read.csv("xtest.csv",header=FALSE)
colnames(xt)<-features

# Get the train data with activities, subject and features
xtr<-read.csv("xtrain.csv",header=FALSE)
colnames(xtr)<-features

# Bind test data with activities, subject and features
activities<-TestActivities[,2]
xtest1<-cbind(xt,activities)
xtest<-cbind(xtest1,subject_test)

# Bind train data with activities, subject and features
activities<-TrainActivities[,2]
xtrain1<-cbind(xtr,activities)
xtrain<-cbind(xtrain1,subject_train)

# Merge test and train data
allrecords<-rbind(xtest,xtrain)

# Get tidy data 
tidydata<-subset(allrecords, select = c("tBodyAccmeanX","tBodyAccmeanY","tBodyAccmeanZ","tGravityAccmeanX","tGravityAccmeanY","tGravityAccmeanZ","tBodyAccJerkmeanX","tBodyAccJerkmeanY","tBodyAccJerkmeanZ","tBodyGyromeanX","tBodyGyromeanY","tBodyGyromeanZ","tBodyGyroJerkmeanX","tBodyGyroJerkmeanY","tBodyGyroJerkmeanZ","tBodyAccMagmean","tGravityAccMagmean","tBodyAccJerkMagmean","tBodyGyroMagmean","tBodyGyroJerkMagmean","fBodyAccmeanX","fBodyAccmeanY","fBodyAccmeanZ","fBodyGyromeanX","fBodyGyromeanY","fBodyGyromeanZ","fBodyAccMagmean","fBodyBodyAccJerkMagmean","fBodyBodyGyroMagmean","fBodyBodyGyroJerkMagmean","angletBodyAccMeangravity","angletBodyAccJerkMeangravityMean","angletBodyGyroMeangravityMean","angletBodyGyroJerkMeangravityMean","angleXgravityMean","angleYgravityMean","angleZgravityMean","tBodyAccstdX","tBodyAccstdY","tBodyAccstdZ","tGravityAccstdX","tGravityAccstdY","tGravityAccstdZ","tBodyAccJerkstdX","tBodyAccJerkstdY","tBodyAccJerkstdZ","tBodyGyrostdX","tBodyGyrostdY","tBodyGyrostdZ","tBodyGyroJerkstdX","tBodyGyroJerkstdY","tBodyGyroJerkstdZ","tBodyAccMagstd","tGravityAccMagstd","tBodyAccJerkMagstd","tBodyGyroMagstd","tBodyGyroJerkMagstd","fBodyAccstdX","fBodyAccstdY","fBodyAccstdZ","fBodyAccJerkstdX","fBodyAccJerkstdY","fBodyAccJerkstdZ","fBodyGyrostdX","fBodyGyrostdY","fBodyGyrostdZ","fBodyAccMagstd","fBodyBodyAccJerkMagstd","fBodyBodyGyroMagstd","fBodyBodyGyroJerkMagstd","activities","srno"))

# Perform required operations
mdata <- melt(tidydata, id=c("activities","srno"),na.rm=TRUE)
fdata <- cast(mdata,activities~srno~variable , mean)

# write the output to a csv file
write.csv(fdata,"output.csv")