source("r_code/generate_samples.R")

#generate a lis of primes up to 10^7
primes <- generate_primes(2,10^7)

#define pi(x) function and generate a dataframe 
pi_df <- data.frame(x, primes_count = sapply(x,FUN=pi))

# define a function to count number of elements in random sample prior to X. We could
# call this rho(x)
Rho <- function(i,j) {length(which(rand_sets[[j]] <= i))}

# Generate a data frame to hold rho(x) for all samples
holding_df <- data.frame(sapply(1:50,function(y) sapply(1:bound,Rho,y)))

# Generate a binded data frame, in order to plot each random set differently.
plot_size = 15   # number of samples to plot
plot_df <- data.frame() #generate generic data.frame
mapply(1:plot_size,1:plot_size,FUN=function(x,y) {
  d <- data.frame(n = 1:bound, c = holding_df[,x], label = paste("sample",y,sep="_"))
  plot_df <<- rbind(plot_df,d)
}
)

#Plot everything and save it in images/
ggplot() + 
  geom_line(data = plot_df, aes(n,c, color=label),alpha = .4) +
  geom_line(data = pi_df, aes(x,primes_count), color = "red", linetype="dashed", show.legend = T) +
  labs(x=NULL, y=NULL) + guides(color="none", linetype="hello") +
  theme_minimal()
ggsave("prob_sample1.pdf",width=6,height=4,path="images")
