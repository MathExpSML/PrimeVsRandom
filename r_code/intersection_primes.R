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
  sets = paste(path(folder), dir(path(folder)),sep="/")
  do.call(rbind,lapply(sets,inter,folder=folder))
}

inter <- function(set,folder){
  s <- read.table(set)
  data.frame(set,
             folder,
             x,
             y = sapply(x,FUN=function(n) {length(intersect(s[s<=n],primes[primes <= n]))/length(s[s<=n])})
  )
}
namer = c(
  "analytic_sets"= "Analytique, non-impairs",
  "odd_analytic_sets" = "Analytique, impairs",
  "odd_prob_sets" = "Probabiliste, impairs",
  "prob_sets" = "Probabiliste, non-impairs"
)
boxplotDF <- do.call(rbind,lapply(Dirs,read_folder))
boxplotDF %>% group_by(x,folder) %>%
  summarise(Max = max(y),
            Med = median(y),
            Min=min(y),
            QT1 = quantile(y,probs=.25),
            QT3 = quantile(y,probs=.75)
            ) %>%
  ggplot() +
  # geom_line(aes(x,y=Max,color=folder),linetype="dashed") +
  # geom_line(aes(x,y=QT3,color=folder),alpha=.25) +
  geom_line(aes(x,y=Med,color=folder)) +
  # geom_line(aes(x,y=QT1,color=folder),alpha = .25) +
  # geom_line(aes(x,y=Min,color=folder),linetype="dashed") +
  geom_ribbon(aes(x,y=seq(0,1,1/251),ymin=QT1,fill=folder,ymax=QT3),alpha=0.3) +
  geom_ribbon(aes(x,y=seq(0,1,1/251),ymin=QT3,fill=folder,ymax=Max),alpha=0.1) +
  geom_ribbon(aes(x,y=seq(0,1,1/251),ymin=Min,fill=folder,ymax=QT1),alpha=0.1) +
  scale_x_log10() + expand_limits(x=1,y=0) +
  scale_y_continuous(breaks=seq(0,1,1/5),labels = scales::percent) +
  theme_minimal() +
  labs(y = "% primes in set",x="n") +
  scale_fill_discrete(name="Groupe",labels=namer) + 
  scale_color_discrete(name="Groupe", labels=namer)
  # facet_grid(folder ~ .) + theme(strip.text.y = element_text(angle=0))

  ggsave("intersection_primes.pdf",path="images")