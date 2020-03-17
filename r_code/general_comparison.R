#install.packages("expint")
#library(expint)

li <- function(x){ expint_Ei(log(x))}
xlog <- function(x){ x/log(x)}
pi_x <- function(x){length(generate_primes(min=2, x))}
Rsel <- function(x) {runif(1) <= li(x)/x}
Rsel2 <- function(x) {runif(1) <= 1/log(x)}
RCount <- function(df, x){
  sum(df[1:x])
}

lbound <- 2
bound <- 100000
x <- seq(lbound,bound)
lix <- data.frame(x, y = sapply(x, li), label = "li(x)")
xlogx <- data.frame(x, y = sapply(x,xlog), label = "x/log(x)")
pix <- data.frame(x, y = sapply(x,pi_x), label = "pi(x)")
R_tot <- sapply(x,Rsel) 
R_tot2 <- sapply(x, Rsel2)
Rcount <- data.frame(x, y = sapply(x,RCount,df = R_tot),label="random using li(x)/x")
Rcount2 <- data.frame(x, y = sapply(x,RCount,df = R_tot2),label="random using 1/log(x)")

df <- rbind(
  pix,
  lix,
  xlogx,
  Rcount, 
  Rcount2
)                  
df %>% filter(x >= 0) %>% ggplot() + geom_line(aes(x,y,color = label)) + 
  theme_minimal()
ggsave("comparison.pdf",path="images")
