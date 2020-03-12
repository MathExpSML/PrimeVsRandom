#install.packages(c("ggplot2", "magrittr", "primes", "tibble"))
library(primes)
library(tibble)
library(magrittr)
library(ggplot2)

fpi <- function(n) length(generate_primes(2,n))

x_logx <- tibble(x=seq(2,10^5),prime_cnt = sapply(x,FUN=fpi), xlog = x/log(x)) %>% 
  ggplot() + 
  geom_line(aes(x,xlog), color = "red") + 
  geom_line(aes(x,prime_cnt), color = "blue") + 
  theme_minimal()

error_xlogx <- N %>% 
  ggplot() + 
  geom_line(aes(x,abs(xlog-prime_cnt)), color = "red") +
  theme_minimal()

ggsave("x_log.pdf",path="Seb_R")
ggsave("error_x_log.pdf",path="Seb_R")
