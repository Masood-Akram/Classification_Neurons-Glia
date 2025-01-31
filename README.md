Needs revision

# Classification_Neurons-Glia
Morphological Classification of Neurons and Glia

### STEP BY STEP GUIDE TO CARRY OUT ALL THE ANALYSES UNDER FOLDER "R_CODE" ###

# Coefficient of determination
>Under the R_Code, there is a file named as Coefficient_of_Determination.R.
>Open the file and first set the working directory of your local computer.
>Frist all the required packages will be installed.
>After inatlling all the packages, Neurons (Neurons_Morphometrics.csv) and Glia (Glia_Morphometrics.csv) datasets will be uploaded.
>19 different morphometric features will be used to make the correaltion plot. 
>At the end, the csv files of the Neuron and Glia morhometrics can also be downladed as a csv file.

# Principal Component Analysis
>Under the R_Code, there is a file named PCA.R.
>Once the file is opened, working directory is set of you local machine.
>All the necessary packages will be installed.
>Read the dataset named New_Data_Full.csv having the morphometric features of glia and neurons.
>Datasets is checked for all the missing values.
>Two morphometric features will be removed out of 21 which have missing values (Depth, Soma Surface), remaining 19 morhphometric features.
>Principal component analysis is performed.
>There are 11 principal components contributing 95.70 of the variance which are then used for the analysis.
>To see the variance contributed by 19 morphometric features, Loadings_NEW.csv file is also produced.
>CSV file of those 11 morphometric components are then produced named Data_Classification.csv which is then used for supervised calssification.

# Random Forest
>Under the R_Code, open the file name RF_CrossValidation.R.
>Set the working directory to your local machine.
>All the necessary packages should be installed.
>The dataset of neurons an glia should be uploaded named Data_Classification.csv. 
>This dataset has 11 Principal Components with their labels as neurons and glia.
>After uploading the data and converting it into a dataframe, 10-fold cross validation model is made.
>After making the 10-fold cross validation model named "fitControl", Random Forest model is applied and fitControl is specified under "trControl" so that cross vlaidation is also performed.
>You will also get the start and stop time so see that how long the classification task takes.
>Once the classification task is carried out, confusion matrix is made to check the accuracy of the model.

# K-Nearest Neighbor
>Under the R_Code, open the file name KNN_CrossValidation.R.
>Set the working directory to your local machine.
>All the necessary packages should be installed.
>The dataset of neurons an glia should be uploaded named Data_Classification.csv. 
>This dataset has 11 Principal Components with their labels as neurons and glia.
>After uploading the data and converting it into a dataframe, 10-fold cross validation model is made.
>After making the 10-fold cross validation model named "fitControl1", K-Nearest Neighbor model is applied and fitControl1 is specified under "trControl" so that cross valaidation is also performed.
>You will also get the start and stop time so see that how long the classification task takes.
>Once the classification task is carried out, confusion matrix is made to check the accuracy of the model.

# Support Vector Machine
>Under the R_Code, open the file name SVM_CrossValidation.R.
>Set the working directory to your local machine.
>All the necessary packages should be installed.
>The dataset of neurons an glia should be uploaded named Data_Classification.csv. 
>This dataset has 11 Principal Components with their labels as neurons and glia.
>After uploading the data and converting it into a dataframe, 10-fold cross validation model is made.
>After making the 10-fold cross validation model named "fitControl1", Support Vector Machine model is applied and fitControl1 is specified under "trControl" so that cross valaidation is also performed.
>radial kernel is used for the classification under 'method="svmRadial"'.
>You will also get the start and stop time so see that how long the classification task takes.
>Once the classification task is carried out, confusion matrix is made to check the accuracy of the model.

### STEP BY STEP GUIDE TO CARRY OUT ALL THE ANALYSES UNDER FOLDER "Python_Code" ###

# Glia 1-15 Branch Analysis
>To carry out the branch analysis for glia, the file is named "Glia_Classifier_1-15-Branches.ipynb".
>After opeining the file, import all the library mentioned in the code.
>Load the dataset named "Glia_Data_Final.csv".
>First convert the dataset into lists. 
>Import the random sampling from random and run the function "random_combination".
>Do the branch analysis for branch 1, 2, 3, 4, 5, 10, and 15 by taking 100 random samples of all the cells (glia and neurons) one by one specified in the code.
>Import the mean from statistic library.
>Since you will 100 random samples of individual cells in a nested list, averages are taken of each nested list to get the Average Euclidean Branch Length (ABEL).
>Change the averages in lists into arrays, then dataframes, and then change the shape of the dataset by transposing it.
>Set the threshold of 14.33um such that if the cell has ABEL above 14.33um it is misclassified (1 is produced in each sample out of 100).
>CSV files will be produced named "Glia_Branch-1.csv", "Glia_Branch-2.csv", to "Glia_Branch-15.csv", for 1, 2 ,3 ,4, 5, 10, and 15 branches.

# Neuron 1-15 Branch Analysis
>To carry out the branch analysis for glia, the file is named "Neuron_Classifier_1-15-Branches.ipynb".
>After opeining the file, import all the library mentioned in the code.
>Load the dataset named "Neuron_Data_Final.csv".
>First convert the dataset into lists. 
>Import the random sampling from random and run the function "random_combination".
>Do the branch analysis for branch 1, 2, 3, 4, 5, 10, and 15 by taking 100 random samples of all the cells (glia) one by one specified in the code.
>Import the mean from statistic library.
>Since you will 100 random samples of individual cells in a nested list, averages are taken of each nested list to get the Average Euclidean Branch Length (ABEL).
>Change the averages in lists into arrays, then dataframes, and then change the shape of the dataset by transposing it.
>Set the threshold of 14.33um such that if the cell has ABEL below 14.33um it is misclassified (1 is produced in each sample out of 100).
>CSV files will be produced named "Neuron_Branch-1.csv", "Neuron_Branch-2.csv", to "Neuron_Branch-15.csv", for 1, 2 ,3 ,4, 5, 10, and 15 branches.

# Claculating Mean, 95 Percentile, and 5 Percentile
>Once you have 1-15 branch csv files for both glia and neurons then mean, 95 percentile, and 5 percentile is calculated by opening the Merge-Calculate_Glia-Neurons.ipynb.
>To carry out this, first import the Glia_Branch-1.csv and Neuron_Branch-1.csv file.
>Merge both the files in one dataframe.
>After merging the two datasets in one, take averages of all columns (100 columns because of 100 random ramples).
>Then calculate the average, 95 percentile (Max), and 5 percentile (Min) of those 100 values produced by the previous step.
>Repeat the same for 1, 2, 3, 4, 5, 10, and 15 branches and then merge all of them into one dataframe and produce "Branch_1-15_Final-Output.csv".


### STEP BY STEP GUIDE TO CARRY OUT PSWARM OPTIMIZATION ###

# Calculating the Slope, y-intercept, and Misclassification error of ABEL and Height combined
>Open the folder PSwarm_Optimization/r_linear_x64
>There are multiple files in this folder and this optimizaer is downloaded from the link: http://www.norg.uminho.pt/aivaz/pswarm/
>After opening the R programmming language, open files "hs024.r", "RunPSwarm.r", and "NG_minerror_NEW.R".
>Run "hs024.r", followed by "RunPSwarm.r".
>After both the files are loaded then run "NG_minerror_NEW.R".
>All the files are same as mentioned in the link. Since it is a linear optimization, we have just added the linear equation in "NG_minerror_NEW.R" file.
>The upper and lower bounds are specified as (5,175 and -10,75).
>The n umber of iterations are set to 2000000000 to get the best global minimum.
>These will be 50 global minimum values will be produced at the end.
>The results will be produced at the end by the name "ABEL_HEIGHT.csv" having slope, y-intercept, and misclassification error.

### MAIN DATASET AND ADDITIONAL DATASET ###

# Main Dataset Under "Data" Folder
>Main dataset file is named "MASTER_ABEL_MAIN-DATA_FINAL.xlsx"
>This file has 9 tabs.
>"MASTER" tab has all the data (glia and neurons, 22,792 cells) with their morphometrics, and metadata annotations.
>"Glia_ABEL_FINAL" tab has 11,394 glial cells with their metadata and morphometrics.
>"Neuron_ABEL_FINAL" tab has 11,398 neurons with their metadata and morphometrics.
>"ABEL_CALC" has glia and neuronal Average Branch Euclidean Length (ABEL) and their classification based on threshold.
>"HEIGHT_CALC" has glia and neuronal Height and their classification based on threshold.
>"TERMINAL_CALC" has glia and neuronal Terminal ABEL and their classification based on threshold.
>"INTERNAL_CALC" has glia and neuronal Internal ABEL and their classification based on threshold.
>"TERMINAL-INTERNAL_RATIO" has glia and neuronal Terminal and Internal branch ratio and their classification based on threshold.

# Additional Dataset Under "Data" Folder
>Additional dataset file is named "MASTER_ABEL_ADDITIONAL-DATA_FINAL.xlsx"
>This file has 4 tabs.
>"MASTER" tab has all the data (glia and neurons, 8,578 cells) with their morphometrics, and metadata annotations.
>"GLIA" tab has 4,286 glial cells with their metadata and morphometrics.
>"NEURONS" tab has 4,292 neurons with their metadata and morphometrics.
>"ABEL_CALC" has glia and neuronal Average Branch Euclidean Length (ABEL) and their classification based on threshold.
