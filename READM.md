README.md

readme file for Cousera "getting and cleaning data" end of class project.
Chris W. 3/19/2016


Directions for new users:

1) Download data from sources listed in CodeBook.md  
2) Extract data into wokring folder that contains run_analysis.R  
3) Execute run_analysis.R  

run_analysis.R  
File loads raw data, subsets it to terms containing the mean and 
standard deviations.  The mean of these channels are then calculated
on a per-user and per-activity basis.  This aggregate data 
is then saved to a csv file the user specified.  For details regarding 
implementation the interested reader should refer to comments within 
the code. 




