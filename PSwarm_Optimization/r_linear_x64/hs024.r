# Problem is already defined as a list

Problem$Variables <- 2


Problem$objf <- function(x){

fx <- matrix(0,1,dim(x)[2])

for(i in 1:dim(x)[2])
	fx[i]=((x[1,i]-3.0)^2.0-9.0)*x[2,i]^3.0/(2.07*sqrt(3.0))


fx

}

Problem$lb <- array(c(0.0,0.0),dim=c(2,1))
Problem$ub <- array(c(1e20,1e20),dim=c(2,1))

Problem$A <- array(0.0, dim=c(3,2))

Problem$A[1,] <- c(-1.0/sqrt(3), 1)
Problem$A[2,] <- c(-1.0, sqrt(3))
Problem$A[3,] <- c(1.0, sqrt(3))

# columnwise representation
Problem$b <- array(c(0,0,6),dim=c(3,1))

# columnwise representation
Problem$x0 <- array(c(1, 0.5),dim=c(2,1))

# Optimal solution
# Problem$x0 <- array(c(3, 1.73205))



outputfcn <- function(it, gbest, fx, x){
	if(it==0){
        cat("  Iter     Leader     Objective\n");
	  cat("  ------------------------------\n");
	}

	cat("    ",it,"   ", gbest, "   ",fx,"\n");

# return a negative value for PSwarm to abort execution
	1.0;
}


# Options list already defined
# All the described 
# delta parameter is computed at run time and is problem related
Options=list(cognitial = 0.5, fweight = 0.4, iweight = 0.9,
	maxf = 2000, maxit = 2000, size = 42, iprint = 10, social = 0.5,
	tol= 1E-5, ddelta = 0.5, idelta = 2,
      outputfcn = outputfcn, vectorized=0)

#end

