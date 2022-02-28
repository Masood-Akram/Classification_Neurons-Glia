###############################
#      REANDOM FOREST         |
###############################


#===============================
#Setting the working directory |
#===============================

setwd("WORKING DIRECTORY URL")

#=====================
#installing packages |
#=====================

install.packages("tidyverse")
library(tidyverse)
install.packages("standardize")
library(standardize)
install.packages("ggplot2")
library(ggplot2)
install.packages("Amelia")
library(Amelia)
install.packages("readxl")
library("readxl")
install.packages("caret")
library("caret")
install.packages("purrr")
library(purrr)
install.packages("randomForest")
library("randomForest")
install.packages("lattice")
library(lattice)

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


#===========================================================================
#Setting the seed and applying 10-fold cross validation with random forest |
#===========================================================================

set.seed(13)
start.time <- Sys.time()

fitControl <- trainControl(method = "repeatedcv",
                            number = 10,
                            savePredictions = T,
                            repeats = 10)


modelFitrf <- train(Class ~ ., data = GN_dataset1,
                      method = "rf",
                      trControl = fitControl,
                      tuneLength = 10,
                      ntree = 500)

modelFitrf$bestTune

stop.time <- Sys.time()
  
total.svm.tuningtime <- print(stop.time - start.time)

#===============================================================
#Checking classification accuracy and making a confusion matrix|
#===============================================================

confusionMatrix(modelFitrf$pred$pred, modelFitrf$pred$obs)

################################################################################
#########################      THE END        ##################################
################################################################################
