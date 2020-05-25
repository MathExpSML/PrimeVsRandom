library(stringr)
library(magrittr)

gen_sample <- function(n) {
  i <<- i + 1 # i is used to name file within the folder 
  # (2:n) generates the integer interval [2,n]
  # The part within the square bracket generates a boolean vector of same length with probability = 1/m, m in [2,n]
  (2:n)[sapply(2:n,FUN=function(m) runif(1) <= 1/log(m))] %>% 
  write.table(
    paste(p,"prob_set_",str_pad(i,3,pad="0"),".txt",sep=""),
    col.names = F,
    row.names = F) 
  }

gen_odd_sample <- function(n){
  i <<- i + 1
  # same function as before but interval and probability are updated.
  c(2,seq(3,n,2))[sapply(c(2,seq(3,n,2)),FUN=function(m) runif(1) <= 2/log(m))] %>%
    write.table(
      paste(p,"odd_prob_set_",str_pad(i,3,pad="0"),".txt",sep=""),
      col.names = F,
      row.names = F) 
}

i =0 
p<- "data/prob_sets/" # folder where sets will be created
replicate(100,gen_sample(10^7))

i =0 
p<- "data/odd_prob_sets/"
replicate(100,gen_sample(10^7))
