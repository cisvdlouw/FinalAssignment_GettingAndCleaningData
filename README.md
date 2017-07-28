# FinalAssignment_GettingAndCleaningData
Tidy dataset in wide format

Below i describe the steps that I have taken to create this dataset. However before
I would like to explain some decisions I made so they are clear before judging.

- I Decided to only use measurements containing mean() and std() because when reading
	features_info.txt from the dataset this is what I consider to be closest to what is
	asked in the assignment

- I decided to first Import all files, then correct names and select columns 
	before I even considered joining files together. This might mean a bit more code
	but in my view also better readable code

- Since i have very little understanding of the content of the dataset I decided to use
	the features.txt as 'meaningful' column names.

-To create the cookbook I used the memisc packages which allows the function cookbook(x)
	and saves a lot of tedious manual work

-------------------------------------------------------------------------------

##Steps used to get to Tidy Wide tidy dataset
1. Loaded all data related to:
	1.1 Training data
	1.2 Test data
	1.3 Features data
	1.4 Activities data

2. Filter from features all measures containing mean() or std()
	by finding there indexes in the features data set. Also saved the names of corresponding 
	indexes so that these could be reused as measure names

3. Then selected the appropriate columns based on indexes from training data
	and applied correct column names

4. Then selected the appropriate columns based on indexes from test data
	and applied correct column names

5. Also gave activities column names so it can later be merged easily to add 
	meaningful variable names

6. Use cbind to combine subjects,activities and measures together for both 
	training and test sets

7. Combinded resulting training and test sets with rbind to create one overall
	dataset 

8. Then used merge to combine the dataset resulting from step 7 with activities dataset
	which results in a dataset with:
		Subject
		Activity
		Measurements...

9. Finally used dplyr package to group_by Subject and Activity and summarize the mean
	of all measurements to get the average per Subject and Activity

------------------------------------------------------------------------------

The result is a wide format Tidy dataset.

READ the dataset using:
data <- read.table(file_path, header = TRUE)
