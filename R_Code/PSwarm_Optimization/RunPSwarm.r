##################################################################
#
#  Run Pswarm with a test problem
#
##################################################################
#
# 26-06-2008 aivaz@dps.uminho.pt
#
# See README file for instructions
#
##################################################################

# Define a list with the problem definition
Problem <- list()

# Define a list with the solver options
Options <- list()


# Read problem definition, functions and options
source("hs024.r")

# Load the solver
#dyn.load("pswarm_r.so")  # Linux
dyn.load("pswarm_r")    # Windows

# Call the solver
Result <- .Call("pswarm_r", Problem, Options, .GlobalEnv)

# Results presents the obtained solution, its objective function value
# and a zero return value on success
print(Result)


