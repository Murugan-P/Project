test=read.table("UCI HAR Dataset/test/X_test.txt")
train=read.table("UCI HAR Dataset/train/X_train.txt")
col_names=read.table("UCI HAR Dataset/features.txt")
ytest=read.table("UCI HAR Dataset/test/y_test.txt")
ytrain=read.table("UCI HAR Dataset/train/y_train.txt")
stest=read.table("UCI HAR Dataset/test/subject_test.txt")
strain=read.table("UCI HAR Dataset/train/subject_train.txt")
activity=read.table("UCI HAR Dataset/activity_labels.txt")

main.merged=merge(test,train,all=TRUE)
colnames(main.merged)=col_names$V2
main.merged=main.merged[,grep('std|mean\\b',colnames(main.merged))]

ybind=rbind(ytest,ytrain)
main.merged=cbind(main.merged,ybind)
colnames(main.merged)[ncol(main.merged)]<-"Activity"

sbind=rbind(stest,strain)
main.merged=cbind(main.merged,sbind)
colnames(main.merged)[ncol(main.merged)]<-"Subject"

for (i in 1:nrow(main.merged)){
        j=main.merged[i,match("Activity",names(main.merged))]
        main.merged[i,match("Activity",names(main.merged))]=as.character(activity[j,2])
}

library(dplyr)

tidydata = main.merged %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))