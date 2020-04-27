# import base
source("r_code/pack_func.R")
library(stringr)

# bound of the samples
bound <- 10^7
x <- seq(2,bound)
p <- "data/prob_sets/"
dir.create(p)

# Sel generates a random variable between 0 and 1, returns true if variable <= 1/log(x), false otherwise
Sel <- function(x) {runif(1) <= 1/log(x)}

df <- data.frame(x)
# This function generates a single random set. Takes all integers between 2 and x and apply Sel function logic
k <- 1

rsamp <- function(){
  d <- data.frame(x,v= sapply(x, Sel))
  df <<- as.data.frame(cbind(df,R = d$v))
  sample <- d$x[which(d$v == TRUE)]
  write.table(sample, paste(p,"prob_set_",str_pad(k,3,pad="0"),".txt",sep=""),row.names = F,col.names = F)
  # only selected integers are returned in the list.
  k <<- k + 1
  d
}

# generates a list of samples
rand_sets <- replicate(100,rsamp())
