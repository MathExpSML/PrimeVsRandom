randvar <- replicate(5000-1,runif(1))
df <- tibble(
  x=seq(2,5000),
  prime_cnt = sapply(x,FUN=fpi),
  xlog = x/log(x),
  prob = xlog/x, 
  rand= randvar, 
  valid = randvar <= prob)

count_valid <- function(n){ nrow(df[df$valid == TRUE & df$x <= n,])}
df$valid_cnt <- sapply(df$x,FUN=count_valid)
df[df$valid == TRUE,]

df %>% ggplot() + 
  geom_line(aes(x,abs(valid_cnt))) +
  geom_line(aes(x,abs(prime_cnt)), color="red") + 
  geom_line(aes(x,xlog), color="blue") 

ggsave("random_set.pdf",path="Seb_R")
