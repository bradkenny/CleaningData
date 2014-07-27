#######################################
#R script to Getting and Cleaning Data#
#Coursera Course - Project 1          #
#Written by Brad Kenny                #
#######################################

################
#Load libraries#
################

library(reshape2)
library(plyr)

##############
#Data Loading#
##############

setwd("/home/brad/Documents/Classes/Coursera/Cleaning/Project/");

fil1 = read.table(file = "UCI HAR Dataset/activity_labels.txt",header = F)
    names(fil1) = c("ActivityLabel","Activity")
#fil2 = read.table(file="UCI HAR Dataset/features_info.txt",header = F)
fil3 = read.table(file="UCI HAR Dataset/features.txt",header =F)
fil4 = read.table(file="UCI HAR Dataset/train/subject_train.txt",header = F)
fil4b = read.table(file = "UCI HAR Dataset/test/subject_test.txt",header = F)
fil5 = read.table(file="UCI HAR Dataset/train/X_train.txt",header = F)
fil5b = read.table(file="UCI HAR Dataset/test/X_test.txt",header = F)
fil6 = read.table(file = "UCI HAR Dataset/train/y_train.txt",header = F)
fil6b = read.table(file="UCI HAR Dataset/test/y_test.txt",header = F)
featureNames = read.table(file="UCI HAR Dataset/features.txt",header = F);
names(featureNames) = c("featureID","featureName")

#Data Names for the X data frame - but we will need to remove ()s
datNames = as.character(featureNames[,2])
datNames = gsub("\\(","",datNames)
datNames = gsub(")","",datNames)


#fil4 is subject
#fil5  is the data
#fil6 is the activity label

##############
#Manipulation#
##############

# Finds which columns we would like to keep
myVec = grepl("mean|std",featureNames[,2]);  

mergeDatX = rbind(fil5,fil5b);
    names(mergeDatX) = datNames;
#Brings us down only to means and standard Devs
mergeDatX2 = mergeDatX[,myVec];
#Removes meanFreq()
myVec = grepl("meanFreq()",names(mergeDatX2));
mergeDatX2= mergeDatX2[,!myVec]

mergeDatY = rbind(fil6,fil6b);
names(mergeDatY) = "ActivityLabel"
mergeDatSub = rbind(fil4,fil4b)
names(mergeDatSub) = "Subject"

mergeDatPre = cbind(mergeDatSub,mergeDatY,mergeDatX2)
#Joins on "ActivityLabel", uses the plyr package
mergeDatTest = join(mergeDatPre,fil1)
#Copies the Activity to the Activity label
mergeDatTest$ActivityLabel = mergeDatTest$Activity
#Removes redundant column
mergeDat = mergeDatTest[,-69]
####The above is the non tidy dataset described in the problem statement####

#Creating the Tidy Data set
###########################


#The statement is to create a tidy dataset with reshape2
#Melt our Data 
melDat = melt(mergeDat,id.vars = c("Subject","ActivityLabel"))
#Cast
castDat = dcast(melDat,Subject + ActivityLabel ~ variable,mean)

write.csv(file="tidyDat.csv",x=castDat,row.names=F)
