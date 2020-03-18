#import mods
library(primes)
library(magrittr)
library(ggplot2)

#generate a lis of primes up to 10^7
primes <- generate_primes(2,10^7)

#create the bounds of my samples.
x <- seq(2,20000)

#define pi(x) function and generate a dataframe 
Pi <- function(k){
  length(primes[which(primes <= k)])
}
pi_df <- data.frame(x, c = sapply(x,FUN=Pi))

#define function to generate a random sample
test <- function(){
  d <- data.frame(x,v= sapply(x, logSel))
  d$x[which(d$v == TRUE)]
}

# create multiple random sets 
rand_sets <- replicate(100,test())

# define a function to count number of elements in random sample prior to X. We could
# call this rho(x)
Rho <- function(i,j) {length(which(rand_sets[[j]] <= i))}

# Generate a data frame to hold rho(x) for all samples
holding_df <- data.frame(sapply(1:100,function(y) sapply(1:20000,Rho,y)))

# Generate a binded data frame, in order to plot each random set differently.
plot_size = 25   # number of samples to plot
plot_df <- data.frame() #generate generic data.frame
mapply(1:plot_size,1:plot_size,FUN=function(x,y) {
  d <- data.frame(n = 1:20000, c = holding_df[,x], label = paste("sample",y,sep="_"))
  plot_df <<- rbind(plot_df,d)
  }
)

#Plot everything and save it in images/
ggplot() + 
  geom_line(data = dd, aes(n,c, color=label),alpha = .4) +
  geom_line(data = pi_df, aes(x,c), color = "red",alpha = 1, linetype="dashed") +
  guides(color = "none")
ggsave("multi_sample.pdf",path="images")
