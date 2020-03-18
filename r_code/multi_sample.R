primes <- generate_primes(2,10^7)
length(primes)
x <- seq(2,20000)

Pi <- function(x){
  length(primes[which(primes <= x)])
}
pi_df <- data.frame(x, c = sapply(x,FUN=Pi))

test <- function(){
  d <- data.frame(x,v= sapply(x, logSel))
  d$x[which(d$v == TRUE)]
}

test_output <- replicate(100,test())

count_i <- function(i,j) {length(which(test_output[[j]] <= i))}

i = seq(1,3)

binding_table <- function(x,y){
  sapply(x,)
}

d <- data.frame(sapply(1:100,function(y) sapply(1:20000,count_i,y)))
test_output[1:3]

dd <- data.frame()
mapply(1:25,1:25,FUN=function(x,y) {
  d2 <- data.frame(n = 1:20000, c = d[,x], label = paste("sample",y,sep="_"))
  dd <<- rbind(dd,d2)
}
)

ggplot() + 
  geom_line(data = dd, aes(n,c, color=label),alpha = .4) +
  geom_line(data = pi_df, aes(x,c), color = "red",alpha = 1, linetype="dashed") +
  guides(color = "none")
ggsave("multi_sample.pdf",path="images")
