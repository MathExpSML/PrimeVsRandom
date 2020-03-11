randvar <- replicate(10000-1,runif(1)) #Generate a random variable
df <- tibble(
  x=seq(2,10000), #create vector from 2 to n
  is.prime = is_prime(x),
  prime_cnt = sapply(x,FUN=fpi), #count number of primes prior to X
  xlog = x/log(x), #computes x/log(x)
  prob = xlog/x, #generate probability of x to be a random variable by deviding 1/log(x). Why does that work?
  rand= randvar, #Assign a random variable
  valid = randvar <= prob #Compare if randvar is lower than prob (TRUE if yes.)
)

count_valid <- function(n){ nrow(df[df$valid == TRUE & df$x <= n,])}
df$valid_cnt <- sapply(df$x,FUN=count_valid)
df$diff <- abs(df$prime_cnt - df$valid_cnt)
df[df$valid == TRUE,]

df %>% ggplot() + 
  geom_line(aes(x,abs(valid_cnt))) +
  geom_line(aes(x,abs(prime_cnt)), color="red") + 
# geom_line(aes(x,x/log(x)), color="blue") 

ggsave("random_set.pdf",path="Seb_R")
