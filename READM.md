README.md

readme file for Cousera "getting and cleaning data" end of class project.
Chris W. 3/19/2016


Directions for new users:

1) Download and extract data from sources listed in CodeBook.md  
2) Modify run_analysis.R as specified below  
3) Execute run_analysis.R  


User required modifications to run_analysis.R  
The user must modify hard coded paths listed in this file.  Paths should
specify where raw source data is on the local machine and where tidy
data should be saved to.

run_analysis.R  
File loads raw data, subsets it to terms containing the mean and 
standard deviations.  The mean of these channels are then calculated
on a per-user and per-activity basis.  This aggregate data 
is then saved to a csv file the user specified.  For details regarding 
implementation the interested reader should refer to comments within 
the code. 




