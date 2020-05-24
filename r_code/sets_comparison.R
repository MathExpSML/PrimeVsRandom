path <- function(folder){
  paste("data",folder,sep="/")
}

x = as.vector(sapply(2:10,FUN=function(n) n*10^(0:6)))
Dirs <- as.list(dir("data")[grepl("set",dir("data"))][1:4]) # select the folders containing the different sets

sigma <- function(set,folder){
  s <- read.table(set)
  data.frame(set,folder, x, y = sapply(x, FUN=function(n) sum(s <= n)))
}

primes <- read.table(path("set_primes.txt"))
sigma(path("set_primes.txt"),"primes")
read_folder <- function(folder){
  sets = head(paste(path(folder), dir(path(folder)),sep="/"),n=50)
  do.call(rbind,lapply(sets,sigma,folder=folder))
}

# 
plotDf <- do.call(rbind,lapply(Dirs,read_folder))
left_join(plotDf,sigma(path("set_primes.txt"),"primes"),by="x") %>% mutate(ratio = y.x/y.y) %>% 
  # filter(set.x == "data/odd_prob_sets/odd_prob_set_032.txt") %>% 
  ggplot() + 
  geom_hline(yintercept = 1) + 
  # geom_line(aes(x=x,y=ratio,color=set.x)) + scale_x_log10() +
  geom_boxplot(aes(y=ratio,group=x,color=folder.x)) +
  guides(color=F) +
  facet_grid(folder.x ~ .)


left_join(plotDf, sigma(path("set_primes.txt"),"primes"), by="x") %>% 
  mutate(ecart = y.x/y.y) %>% 
  group_by(x,folder.x) %>% 
  summarize(med = median(ecart),
            QT1 = quantile(ecart,probs=.25),
            QT3 = quantile(ecart,probs=.75)
            ) %>% 
  ggplot() +
  geom_ribbon(aes(x=x,y=seq(0,1,1/251),ymin=QT1,ymax=QT3,fill=folder.x),alpha=0.2) +
  geom_line(aes(x,med,color=folder.x),alpha=.5) + 
  scale_x_log10() + 
  scale_y_continuous(breaks=c(.8,1,1.2,1.4)) +
  scale_fill_discrete(name="Groupe",labels=namer) +
  scale_color_discrete(name="Groupe",labels=namer) + 
  labs(x="n (log 10)", y="sigma(n) / pi(n)")

ggsave("comparison_all_random_sets.pdf", path="images")

