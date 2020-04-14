# This script will generate multiple randoms sets following the distribution of pi(x).
# With the exception of 2, all elements of the sets are odd integers, which is a property of prime numbers.

# import base functions and 
source("r_code/pack_func.R")
library(stringr)

# bound of the samples
bound <- 10^7
x <- c(2,seq(3,bound,2))
p <- "data/odd_prob_sets/" #Setup path to record sets
dir.create(p) #Create directory accordingly to path

# Sel generates a random variable between 0 and 1, returns true if variable <= 1/log(x), false otherwise
Sel <- function(x) {runif(1) <= 2/log(x)}

df <- data.frame(x)
# This function generates a single random set. Takes all integers between 2 and x and apply Sel function logic
k <- 1

rsamp <- function(){
  d <- data.frame(x,v= sapply(x, Sel))
  #df <<- as.data.frame(cbind(df,R = d$v))
  sample <- d$x[which(d$v == TRUE)]
  write.table(sample, paste(p,"odd_prob_set_",str_pad(k,3,pad="0"),".txt",sep=""),row.names = F,col.names = F)
  # only selected integers are returned in the list.
  k <<- k + 1
  sample
}

# generates a list of samples
rand_sets <- replicate(100,rsamp())
