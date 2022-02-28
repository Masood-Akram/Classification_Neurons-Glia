###############################
#     K-NEAREST NEIGHBORS     |
###############################

#===============================
#Setting the working directory |
#===============================

setwd("Z:/ToBackup/Masood/Machine_Learning/RStudio/Neuron_Glia-Optimization/GLIA_NEURON_OUTLIERS/Optimization_ABEL_Height_Final_01202022/Machine_Learning_01232022/Machine_Learning02032022/Code")

#=====================
#installing packages |
#=====================

install.packages("vctrs")
library(vctrs)
install.packages("tidyverse")
library("tidyverse")
install.packages("scales")
library("scales")
install.packages("ggplot2")
library("ggplot2")
install.packages(c("FactoMineR", "factoextra"))
library("FactoMineR")
library("factoextra")
install.packages("readxl")
library("readxl")
library("corrplot")
install.packages("dplyr")
library("dplyr")
install.packages("devtools")
library("devtools")
install.packages("readr")
library("readr")
install.packages("cluster")
library("cluster")
install.packages("readr")
library(readr)
install.packages("standardize")
library(standardize)
install.packages("ggplot2")
library(ggplot2)
install.packages("Amelia")
library(Amelia)
install.packages("caret")
library("caret")

#======================
#Loading the data set |
#======================

GN_dataset <- read_xlsx("Data_Classification.xlsx")
dim(GN_dataset)
str(GN_dataset)


#===============================================================
#Converting response/dependent variable to data frame & factor |
#===============================================================

GN_dataset1 <- as.data.frame(GN_dataset)
GN_dataset1$Class <- as.factor(GN_dataset1$Class)

#=================================================================
#Setting the seed and applying 10-fold cross validation with KNN |
#=================================================================

set.seed(13)
  
start.time <- Sys.time()

trControl1 <- trainControl(method = "repeatedcv",
                            number = 10,
                            savePredictions = T,
                            repeats = 10)


fit1 <- train(Class ~ .,
              method     = "knn",
              trControl  = trControl1,
              metric     = "Accuracy",
              data       = GN_dataset1,
              tuneLength = 10)

stop.time <- Sys.time()

total.svm.tuningtime <- print(stop.time - start.time)

#===============================================================
#Checking classification accuracy and making a confusion matrix|
#===============================================================

confusionMatrix(fit1$pred$pred, fit1$pred$obs)

################################################################################
#########################      THE END        ##################################
################################################################################
