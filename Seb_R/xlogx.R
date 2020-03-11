#install.packages(c("ggplot2", "magrittr", "primes", "tibble"))
library(primes)
library(tibble)
library(magrittr)
library(ggplot2)

fpi <- function(n) length(generate_primes(2,n))

x_logx <- tibble(x=seq(2,100),prime_cnt = sapply(x,FUN=fpi), xlog = x/log(x)) %>% 
  ggplot() + 
  geom_line(aes(x,xlog), color = "red") + 
  geom_line(aes(x,prime_cnt), color = "blue") + 
  theme_minimal()

ggsave("x_log.pdf",path="/Seb_R")
