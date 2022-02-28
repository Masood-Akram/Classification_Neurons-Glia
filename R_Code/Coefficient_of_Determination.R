#####################################
#   COEFFICIENT OF DETERMINATION   |
#####################################

#===============================
#Setting the working directory |
#===============================

setwd("Z:/ToBackup/Masood/Machine_Learning/RStudio/Neuron_Glia-Optimization/GLIA_NEURON_OUTLIERS/Optimization_ABEL_Height_Final_01202022/Machine_Learning_01232022/Machine_Learning02032022/Code")

#=====================
#installing packages |
#=====================

install.packages("ggpubr")
library("ggpubr")
install.packages("readxl")
library("readxl")
install.packages("corrplot")
library(corrplot)
install.packages("PerformanceAnalytics")
library("PerformanceAnalytics")
install.packages("vctrs")
library(vctrs)
install.packages("Hmisc")
library(Hmisc)

#======================
#Loading the data set |
#======================

Neuron <- read_xlsx("Neuron_Morphometrics.xlsx")
Glia <- read_xlsx("Glia_Morphometrics.xlsx")

#==============================================================
#Deleting the unwanted morphometric features from the data set|
#==============================================================

Neuron1 <- subset(Neuron, select = -c(Soma_Surface, Depth))
names(Neuron1)
Glia1 <- subset(Glia, select = -c(Soma_Surface, Depth))
names(Glia1)

#===================================
#Scaling the morphometric features |
#===================================

scale_glia <- scale(Glia1[, 1:19])
scale_neuron <- scale(Neuron1[, 1:19])
Glia2 <- data.matrix(Glia1[,1:19])
Neuron2 <- data.matrix(Neuron1[, 1:19])

#=====================================
#Compute correlation matrix for Glia |
#=====================================

res <- cor(Glia2)
round(res, 2)

#=======================================
#Compute correlation matrix for Neuron |
#=======================================

Nes <- cor(Neuron2)
round(Nes, 2)

#========================================================================================
#Making correlation matrices,extracting correlation coefficients, and P-Values for Glia |
#========================================================================================

cor(Glia2, use = "complete.obs")

res2 <- rcorr(as.matrix(Glia2))
res2

#Extract the correlation coefficients
res2$r

#Extract p-values
res2$P

#Draw a correlogram for Glia
res = res^2

png(height=1800, width=1800, file="Plots_Glia.png", type = "cairo")

colmat <- colorRampPalette(c("white", "dodgerblue4"))
corrplot(res, type = "upper", order = "original", 
         tl.col = "black", tl.srt = 45, cl.lim = c(0, 1), is.corr = FALSE,
         tl.cex = 1, col = colmat(200), pch = 4)

#===========================================================================================
#Making correlation matrices,extracting correlation coefficients, and P-Values for Neurons |
#===========================================================================================

cor(Neuron2, use = "complete.obs")

Nes2 <- rcorr(as.matrix(Neuron2))
Nes2

#Extract the correlation coefficients
Nes2$r

#Extract p-values
Nes2$P

#Draw a correlogram for Neuron
Nes <- Nes^2
colmat1 <- colorRampPalette(c("white", "dodgerblue4"))
corrplot(Nes, type = "upper", order = "original", 
         tl.col = "black", tl.srt = 45, cl.lim = c(0, 1), is.corr = FALSE,
         tl.cex = 1, col = colmat1(200))

#Draw scatter plots for Neuron
#chart.Correlation(Nes, histogram=TRUE, pch=19)

#============================
#Output the matrix in excel |
#============================

write.csv(res, "Glia.csv")
write.csv(Nes, "Neuron.csv")

################################################################################
#########################      THE END        ##################################
################################################################################