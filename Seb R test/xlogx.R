#install.packages("primes")
#install.packages("tibble")
#install.packages("magrittr")
#install.packages("ggplot2")
library(primes)
library(tibble)
library(magrittr)
library(ggplot2)

fpi <- function(n) length(generate_primes(2,n))

tibble(x=seq(2,50000),prime_cnt = sapply(x,FUN=fpi), xlog = x/log(x)) %>% 
  ggplot() + 
  geom_line(aes(x,xlog), color = "red") + 
  geom_line(aes(x,prime_cnt), color = "blue") + 
  theme_classic()
