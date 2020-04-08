# import base
source("r_code/pack_func.R")

# bound of the samples
bound <- 100000
x <- seq(2,bound)

# Sel generates a random variable between 0 and 1, returns true if variable <= 1/log(x), false otherwise
Sel <- function(x) {runif(1) <= 1/log(x)}

df <- data.frame(x)
# This function generates a single random set. Takes all integers between 2 and x and apply Sel function logic
rsamp <- function(){
  d <- data.frame(x,v= sapply(x, Sel))
  df <<- as.data.frame(cbind(df,R = d$v))
  # df = generate a data frame. It's a bit awkward to work with for the moment...
   d$x[which(d$v == TRUE)]
  # only selected integers are returned in the list.
}

# generates a list of samples
rand_sets <- replicate(100,rsamp())

write.csv(df,"samples.csv")
