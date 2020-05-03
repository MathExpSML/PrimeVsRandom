## This script is used to generate a plot for odd random sets.

source("r_code/pack_func.R")

#generate a lis of primes up to 10^7
primes <- generate_primes(2,100000)

bound <- 100000
div = seq(1,bound,(bound-1)/1000)
#define pi(x) function and generate a dataframe 
pi_df <- data.frame(x = div, primes_count = sapply(x,FUN=pi))

# define a function to count number of elements in random sample prior to X.
sets = head(dir("./data/odd_prob_sets/"),n=15)


f = function(set){
  s = read.table(paste("./data/odd_prob_sets/",set,sep=""))
  tibble(n = div,
         c = sapply(div, FUN=function(n) sum(s <= n)),
         label = set,
  )
}

plot_df <- data.frame() #generate generic data.frame
for (set in sets){
  plot_df <<- rbind(plot_df, f(set))
}

#Plot everything and save it in images/
ggplot() + 
  geom_line(data = plot_df, aes(n,c, color=label),alpha = .4) +
  geom_line(data = pi_df, aes(x,primes_count), color = "red", linetype="dashed", show.legend = T) +
  labs(x=NULL, y=NULL) + guides(color="none", linetype="hello") +
  theme_minimal()
ggsave("prob_sample_odd.pdf",width=6,height=4,path="images")
