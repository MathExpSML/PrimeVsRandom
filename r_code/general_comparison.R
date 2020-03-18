#install.packages("expint")
#library(expint)

li <- function(x){ expint_Ei(log(x))}
xlog <- function(x){ x/log(x)}
pi_x <- function(x){length(generate_primes(min=2, x))}
PiSel <- function(x) {runif(1) <= pi_x(x)/x}
logSel <- function(x) {runif(1) <= 1/log(x)}
RCount <- function(df, x){
  sum(df[1:x])
}

lbound <- 2
bound <- 100000
x <- seq(lbound,bound)

Pi_tot <- sapply(x,PiSel) 
Log_tot <- sapply(x, logSel)

lix <- data.frame(x, y = sapply(x, li), label = "li(x)")
xlogx <- data.frame(x, y = sapply(x,xlog), label = "x/log(x)")
pix <- data.frame(x, y = sapply(x,pi_x), label = "pi(x)")
Rcount <- data.frame(x, y = sapply(x,RCount,df = Pi_tot),label="random using Pi(x)/x")
Log_Distrib <- data.frame(x, y = sapply(x,RCount,df = Log_tot),label="random using 1/log(x)")

df <- rbind(
  pix,
  lix,
  #xlogx,
  #Rcount, 
  Log_Distrib
)                  
df %>% ggplot() +
  geom_line(aes(x,y,color = label)) + 
  theme_minimal() + 
  theme(legend.position="bottom") +
  labs(color="function")

ggsave("comparison.pdf",path="images")
