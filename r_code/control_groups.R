n = 70000
p = pi(n)/n
generate_random_sample <- function(k){
  rand_samp <- which(runif(n) <= p)
  loc = paste("./data/rand_samp/","rand_samp_",str_pad(k,3,pad="0"),".txt",sep="")
  write.table(rand_samp, loc,row.names = F,col.names = F)
}
generate_ors <- function(k){
  rand_samp <- which(runif(floor(n/2)) <= p*2)*2+1
  loc = paste("./data/rand_samp_odd/","rand_samp_odd",str_pad(k,3,pad="0"),".txt",sep="")
  write.table(rand_samp, loc,row.names = F,col.names = F)
}
sapply(1:100,FUN=generate_random_sample)
sapply(1:100,FUN=generate_ors)
