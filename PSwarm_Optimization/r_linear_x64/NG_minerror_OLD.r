# Define a list with the problem definition
#m=x[1]
#c=x[2]
r<-read.csv("C:/Users/vselabs/OneDrive - George Mason University - O365 Production/Office-Desktop/r_linear_x64/Optim_ABEL-H.csv")
names(r)[1]<-"GABEL"
r[is.na(r)] = 0
#View(r)
rm(Problem, outputfcn, Options, Result)
Problem <- list()
Problem$Variables <- 2
Problem$objf <- function(x) {
 ##############################################
 ##### LINEAR EQUATION FOR NEURON AND GLIA ####
 for(i in 1:11394){if((x[1]*r$GABEL[i]+x[2])<r$GH[i]){r$e1[i]=1}else{r$e1[i]=0}}
 for(j in 1:11398){if((x[1]*r$NABEL[j]+x[2])>r$NH[j]){r$e2[j]=1}else{r$e2[j]=0}}
 ##############################################
 ((sum(r$e1)+sum(r$e2))/22923)*100
}

Problem$lb <- c(-10,75)
Problem$ub <- c(5,175)

outputfcn <- function(it, gbest, fx, x){
  cat(sprintf("Iteration: %d", it), sprintf("Error: %f", fx), "\n", sep = "\t");
  # return a negative value for PSwarm to abort execution
  1.0;
}


# Define a list with the solver options
Options <- list(
  cognitial = 0.5, fweight = 0.4, iweight = 0.9,
  maxf = 2000000000, maxit = 2000000000, size = 2 * Problem$Variables, iprint = 10000, social = 0.5,
  tol= 1E-20, ddelta = 0.5, idelta = 2,
  outputfcn = outputfcn, vectorized=0)

# Load the solver
#dyn.load("pswarm_r.so")  # Linux
dyn.load("pswarm_r")    # Windows

##########################
# Call the solver
Result <- .Call("pswarm_r", Problem, Options, .GlobalEnv)

# Results presents the obtained solution, its objective function value
# and a zero return value on success
print(Result)
#################################################################################

#multiple iterations (50 iterations in this case)

report <- data.frame(matrix(ncol = 3, nrow = 0))
for (i in 1:50){  
  # Call the solver
  set.seed(rnorm(1)*1E3)
  Result <- .Call("pswarm_r", Problem, Options, .GlobalEnv)
  cat("\n\nError=", Result$f, "\n\n")
  # print(Result)
  
  report<-rbind(report, append(Result$x, Result$f, after=0))
}

#Writing a csv file of the results (slope, y-intercept, and misclassification error)
write.table(report, file = "./ABEL_HEIGHT.csv", fileEncoding = "UTF-16", na = "", sep = ",", row.names = F,
            col.names = c("error", "x1","x2"))

rm(i, Options, Problem, outputfcn, Result)

