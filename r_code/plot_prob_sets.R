source("r_code/pack_func.R")

## This script is used to generate a plot for general random sets.
bound <- 100000
#generate a lis of primes up to 10^7
primes <- generate_primes(2,bound)

div = seq(1,bound,(bound-1)/1000)
#define pi(x) function and generate a dataframe 
pi_df <- data.frame(x = div, primes_count = sapply(div,FUN=pi))

# define a function to count number of elements in random sample prior to X.
sets = head(dir("./data/prob_sets/"),n=25)

f = function(set){
  s = read.table(paste("./data/prob_sets/",set,sep=""))
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
  geom_line(data = plot_df, aes(n,c, colour=label),alpha = .4) +
  geom_line(data = pi_df, aes(x,primes_count),linetype="dashed" , color = "black", show.legend = T) +
  labs(x=NULL, y=NULL) +
  scale_color_discrete(guide=NULL) +
  theme_minimal()
ggsave("prob_samples.pdf",width=14,height=6,units="cm",path="images")
