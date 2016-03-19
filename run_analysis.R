run_analysis <- function() {
    # "Getting and Cleaning" data end of class project
    # see README.md for details of data origin and usage
    # 
    # Chris W. 3/19/16
    # 
    
    library(plyr)

    # --- Specify where data files are ---
    rootFolder <- paste0(getwd(), "/UCI HAR Dataset/")
    outputFile <- paste0(getwd(), "/tidyData.txt")

    ## Common files to both test and training folders
    actLabelsFile   <- paste0(rootFolder, "activity_labels.txt") # names of activities; 1-6, WALKING-LAYING-ETC
    colNamesFile    <- paste0(rootFolder, "features.txt")        # 562 col names of what is within data files
    
    # Training data sets
    subTrainFile    <- paste0(rootFolder, "train/", "subject_train.txt") # participant number, 1 column sub set of 1-30
    x_trainFile     <- paste0(rootFolder, "train/", "X_train.txt")      # acc data, 562 columns 
    y_trainFile     <- paste0(rootFolder, "train/", "Y_train.txt")      # activity code data, 1 column containing 1-6
    # Test data sets
    subTestFile     <- paste0(rootFolder, "test/", "subject_test.txt")  # participant number, 1 column sub set of 1-30
    x_testFile      <- paste0(rootFolder, "test/", "X_test.txt")        # acc data, 562 columns 
    y_testFile      <- paste0(rootFolder, "test/", "Y_test.txt")        # activity code data, 1 column containint 1-6
    
    # --- Load raw data ---
    # common set
    actlabel_raw    <- read.table(actLabelsFile, header = FALSE)
    colNames_raw    <- read.table(colNamesFile, header = FALSE, stringsAsFactors = FALSE)
    # training set 
    subTrain_raw    <- read.table(subTrainFile, header = FALSE)
    x_train_raw     <- read.table(x_trainFile, header = FALSE)
    y_train_raw     <- read.table(y_trainFile, header = FALSE)
    # test set
    subTest_raw     <- read.table(subTestFile, header = FALSE)
    x_test_raw      <- read.table(x_testFile, header = FALSE)
    y_test_raw      <- read.table(y_testFile, header = FALSE)
    
    ## --- "Part 1: Merges the TRAINING and the TEST sets to 
    ##                  create one data set" ---
    x_AccData       <- rbind(x_train_raw,  x_test_raw)  # acceleromater based data
    y_ActLblData    <- rbind(y_train_raw,  y_test_raw)  # activity label
    subjectData     <- rbind(subTrain_raw, subTest_raw) # subject number data
    
    # Check for NA's in the data
    good <- complete.cases(x_AccData)
    if ( NROW(good) != nrow(x_AccData)) {
        warning("One (or more) incomplete cases were found in x_AccData.")
    }
    
    
    ## --- "Part 2: Extracts only the measurements on the mean 
    ##                  and standard deviation for each measurement."
    # Make vector of column indexes where 'features.txt' aka colNames_raw
    #  contains '-mean', or '-std'
    
    iMeanStd <- union( grep("-mean", tolower(colNames_raw$V2)), 
                       grep("-std", tolower(colNames_raw$V2)) )
    
    # form new data frame of only mean and std terms
    x_AccData_MeanStd   <- x_AccData[, iMeanStd]
    colNames_MeanStd    <- colNames_raw$V2[iMeanStd]
    
    ## --- Part 3: Uses descriptive activity names to name the 
    ##                  activities in the data set.
    
    # apply activity names to activity rows
    desActNameVec <- join(y_ActLblData, actlabel_raw)
    
    # apply activity names into numerical data set x_AccData_MeanStd
    desActName_AccData_MeanStd <- cbind(desActNameVec$V2, x_AccData_MeanStd)
    
    ## --- Part 4: Appropriately label the data set with 
    ##                  descriptive variable names.
    
    # replace genearic col names in data set with those from "features.txt"
    names(desActName_AccData_MeanStd)[1] <- "Activity"
    
    names(desActName_AccData_MeanStd)[2:(length(colNames_MeanStd)+1)] <- colNames_MeanStd
    
    desActName_AccData_MeanStd <- cbind(subjectData, desActName_AccData_MeanStd)
    names(desActName_AccData_MeanStd)[1] <- "SubjectNumber"
    
    ## --- From the data set in step 4, create a second, independent 
    ##          tidy data set with the average of each variable for 
    ##          each activity and each subject.
    nc = NCOL(desActName_AccData_MeanStd)
    dActName_aggMeanStd <- aggregate( desActName_AccData_MeanStd[,3:nc], 
                                      list(desActName_AccData_MeanStd$SubjectNumber, 
                                           desActName_AccData_MeanStd$Activity),
                                      mean)
    # Apply col names
    names(dActName_aggMeanStd)[1:2] <- list("SubjectNumber", "Activity")
    
    # append "_aggMean" to col names indicating an aggregate mean
    nc          <- NCOL(dActName_aggMeanStd)
    badNames    <- names(dActName_aggMeanStd[3:nc])
    betterNames <- paste0(badNames, "_aggMean")
    names(dActName_aggMeanStd)[3:nc] <- betterNames
    
    ## --- Export data, asked for in the introduction.  
    
    write.table(dActName_aggMeanStd, outputFile,
                row.names = FALSE)
    
    print("end of run_analysis.R")
    return(TRUE)
}


