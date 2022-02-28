###############################
#PRINCIPAL COMPONENT ANALYSIS |
###############################

#===============================
#Setting the working directory |
#===============================

setwd("WORKING DIRECTORY URL")

#=====================
#installing packages |
#=====================

install.packages(c("FactoMineR", "factoextra"))
install.packages("devtools")
install.packages("ggplot2")
install.packages("ggfortify")
install.packages("zoom")
library("FactoMineR")
library("factoextra")
library("readxl")
library("ggplot2")
library("devtools")
library("readr")
library("ggfortify")
library("zoom")

#==============================
#Loading the data set for PCA |
#==============================

dataset <- read.csv("New_Data_Full.csv")
head(dataset)
dim(dataset)
str(dataset)

#=========================================
#Finding the missing values in a dataset |
#=========================================

is.na(dataset)
sum(is.na("dataset"))

#==============================================================
#Deleting the unwanted morphometric features from the data set|
#==============================================================

dataset1 <- subset(dataset, select = -c(Soma_Surface, Depth))
names(dataset1)

#=============================================
#Setting the seed, and randmoize the data set|
#and convert it into a data frame            |
#=============================================

set.seed(1001)
rows <- sample(nrow(dataset1))
data <- as.data.frame(dataset1)
datasetRandom <- data[rows, ]

#============================
#Applying PCA on a data set |
#============================

p <- prcomp(datasetRandom[1:22792,1:19], scale=TRUE)

s <- summary(p)

#=====================================
#Get Eigenvalue and percent variance |
#=====================================

get_eigenvalue(p)

#===================================
#Screeplot of principal components |
#===================================

fviz_eig(p, addlabels = TRUE, ylim = c(1, 50), ncp = 19, cex.lab = 50)

#===============================================
#Produce a CSV of principal component loadings |
#===============================================

Loadings <- data.frame(p$rotation)
write_csv(Loadings, path = "Loadings_NEW.csv")

#==========================================================================
#Exporting data set to perform traditional machine learning classification|
#==========================================================================

X <- p$x
X1 <- as.data.frame(X)
Data <- cbind(X1[1:11], Class = datasetRandom$Class)

write_csv(Data, path = "Data_Classification.csv")

################################################################################
##########################     THE END    ######################################
################################################################################

