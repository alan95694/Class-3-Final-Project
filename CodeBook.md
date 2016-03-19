CodeBook.md

CodeBook for Cousera "getting and cleaning data" end of class project.
Chris W. 3/19/2016

Raw data is described at the below link.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Raw data was obtained from the below link.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Variables in the output file "tidyData.txt"
SubjectNumber: Human participant identification number 1-30
Activity: Activity performed by participant, (walking, laying, etc)
Content

	>> Variable names were appended to but not modified from the source data, see source
		documentation for full explanation of variable names.
	>> No unit or coordinate transformations were performed, all units remain in g 
		as specified in the original data set.
	>> "_aggMean" was appended to indicate that the channel represents the aggregate
		mean of the source data channel.

Data within the output file "tidyData.txt" represent the aggregated mean of 
the mean and standard deviation from the source data files for each 
subject for a given activity.




