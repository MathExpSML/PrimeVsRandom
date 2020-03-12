#install.packages(c("ggplot2", "magrittr", "primes", "tibble"))
library(primes)
library(tibble)
library(magrittr)
library(ggplot2)

fpi <- function(n) length(generate_primes(2,n))

dfxlogx <- tibble(x=seq(2,10^5),prime_cnt = sapply(x,FUN=fpi), xlog = x/log(x))

x_logx <- dfxlogx %>% 
  ggplot() + 
  geom_line(aes(x,xlog), color = "red") + 
  geom_line(aes(x,prime_cnt), color = "blue") + 
  theme_minimal()
ggsave("x_log.pdf",path="images")

error_xlogx <- dfxlogx %>% 
  ggplot() + 
  geom_line(aes(x,abs(xlog-prime_cnt)), color = "red") +
  theme_minimal()


ggsave("error_x_log.pdf",error_xlogx,path="images")
