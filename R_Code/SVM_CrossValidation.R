###############################
#   SUPPORT VECTOR MACHINE    |
###############################

#===============================
#Setting the working directory |
#===============================

setwd("WORKING DIRECTORY URL")

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
install.packages("standardize")
library(standardize)
install.packages("Amelia")
library(Amelia)
install.packages("caret")
library("caret")


#======================
#Loading the data set |
#======================

GN_dataset <- read.csv("Data_Classification.csv")
dim(GN_dataset)
str(GN_dataset)

#===============================================================
#Converting response/dependent variable to data frame & factor |
#===============================================================

GN_dataset1 <- as.data.frame(GN_dataset)
GN_dataset1$Class <- as.factor(GN_dataset1$Class)

#=================================================================
#Setting the seed and applying 10-fold cross validation with SVM |
#=================================================================

set.seed(13)

start.time <- Sys.time()

fitControl1 <- trainControl(method = "repeatedcv",
                           number = 10,
                           savePredictions = T,
                           repeats = 10)



fit.svm1 <- train(Class~.,
                  data=GN_dataset1,
                  method="svmRadial", 
                  trControl=fitControl1, 
                  na.action=na.omit,
                  preProcess= c("center", "scale"),
                  tuneLength = 10)

stop.time <- Sys.time()

total.svm.tuningtime <- print(stop.time - start.time)

#===============================================================
#Checking classification accuracy and making a confusion matrix|
#===============================================================

confusionMatrix(fit.svm1$pred$pred, fit.svm1$pred$obs)

################################################################################
#########################      THE END        ##################################
################################################################################
