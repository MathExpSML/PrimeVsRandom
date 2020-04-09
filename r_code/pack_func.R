# Packages and basic functions 

#install.packages(c("ggplot2", "magrittr", "primes", "tibble", "expint"))
library(primes)
library(tibble)
library(magrittr)
library(ggplot2)
library(expint)
library(dplyr)

Li <- function(x){ expint_Ei(log(x)) -expint_Ei(log(2))}
pi <- function(x){length(generate_primes(min=2, x))}
rho <- function(x) sum(c(sapply(seq(2,x), FUN= function(y) 1/log(y))))