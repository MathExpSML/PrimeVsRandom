df <- rbind(
  data.frame(read.csv("./data/conjecture_2_3/conjecture_2_3_odd_10k.csv"), 
             label = "probabilistes", odd=T),
  data.frame(read.csv("./data/conjecture_2_3/conjecture_2_3_10k.csv"),
             label = "probabilistes", odd=F),
  data.frame(read.csv("./data/conjecture_2_3_odd_analytique_10k.csv"), 
             label = "analytique", odd= T),
  data.frame(read.csv("./data/conjecture_2_3_analytique_10k.csv"), 
             label = "analytique", odd=F)#,
  # data.frame(read.csv("./data/rand_samp.csv"), 
  #            label = "random", odd=F),
  # data.frame(read.csv("./data/rand_samp_odd.csv"),
  #            label = "random",odd=T)
)

df <- df %>% group_by(label) %>% mutate(
  MedianMaxFail = median(maxFail),
  MedianFailures = median(failures)
  )

failPlot <- df %>% filter(set != "primes") %>% 
  ggplot(aes(failures,maxFail, color = label, alpha = .7,shape=odd)) + 
  geom_point() +
  theme_minimal() +
  scale_color_discrete(name="Methode") +
  scale_shape_discrete(name="impair seulement",labels=c("non","oui")) +
  guides(alpha ="none",color=guide_legend(order=1))
ggsave("plot_failure_maxfaile_c_2_3.pdf", failPlot, width=6,height=2.5,path="images")

maxFailBox <- df %>% filter(set!= "primes") %>% 
  ggplot(aes(y=maxFail, fill=odd)) + 
  geom_boxplot(position=position_dodge(0)) +
  theme_minimal() + 
  facet_grid(. ~ label) + 
  scale_fill_discrete(name="impair seulement",labels=c("non","oui")) +
  ylab("max{n | -P(n)}") +
  theme(legend.position="bottom", axis.text.x = element_blank()) +
  scale_x_continuous(breaks=NULL)
ggsave("C23_MaxFail_BoxPlot.pdf", maxFailBox, width=6,height=6,units="cm",path="images")

FailCount <- df %>% filter(set!= "primes") %>% 
  ggplot(aes(y=failures, fill=odd)) + 
  geom_boxplot(position=position_dodge(0)) +
  theme_minimal() + 
  ylab("#{n | -P(n)}") +
  facet_grid(. ~ label) + 
  scale_fill_discrete(name="impair seulement",labels=c("non","oui")) +
  theme(legend.position="bottom", axis.text.x = element_blank()) +
  scale_x_continuous(breaks=NULL)
ggsave("C23_FailCount_BoxPlot.pdf", FailCount, width=6,height=6,units="cm",path="images")

maxFailBoxOdd <- df %>% filter(set!= "primes", label!= "random", odd==T) %>% 
  ggplot(aes(y=maxFail, fill=odd)) + 
  geom_boxplot(position=position_dodge(0)) +
  theme_minimal() + 
  facet_grid(. ~ label) + 
  scale_fill_discrete(guide=NULL) +
  ylab("max{n | -P(n)}") +
  theme(legend.position="bottom", axis.text.x = element_blank()) +
  scale_x_continuous(breaks=NULL) + guides(fill=NULL)
ggsave("C23_MaxFail_BoxPlot_Odd.pdf", maxFailBoxOdd, width=6,height=6,units="cm",path="images")

FailCountOdd <- df %>% filter(set!= "primes", label!= "random", odd==T) %>% 
  ggplot(aes(y=failures, fill=odd)) + 
  geom_boxplot(position=position_dodge(0)) +
  theme_minimal() + 
  ylab("#{n | -P(n)}") +
  facet_grid(. ~ label) + 
  scale_fill_discrete(guide=NULL) +
  theme(legend.position="bottom", axis.text.x = element_blank()) +
  scale_x_continuous(breaks=NULL) 
ggsave("C23_FailCount_BoxPlot_Odd.pdf", FailCountOdd, width=6,height=6,units="cm",path="images")
