hm <- read.csv("./data/conjecture_2_3/failure_mapping_10K_V2.csv")
hm <- hm %>% mutate(
  label = ifelse(grepl("analytique",set),"analytique","probabiliste"),
  odd = grepl("odd",set)
)
# hm <- hm %>% group_by(label,odd) %>% mutate(set_cnt = n_distinct(set)) 
# hm %>% group_by(group, label, odd) %>% select(!set) %>% ungroup

b = 1
plot_hm <- hm %>% 
  mutate(group = cut(hm$failedInt,breaks=seq(6,10000,b),labels=F)) %>% ungroup %>%
  group_by(group, label, odd) %>% mutate(cnt = n()) %>% ungroup %>% 
  group_by(label,odd) %>% mutate(set_cnt = n_distinct(set)) %>% select(!set) %>% unique()
med =(max(plot_hm$cnt) + min(plot_hm$cnt))/200

heat_conj_2_3 <- plot_hm %>% ggplot() + 
  geom_tile(aes(x=group*b, y=paste(label,odd), fill=cnt/set_cnt)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 35, hjust = 1), 
        legend.position = "top",
        panel.background = element_blank()) +
  # facet_grid((odd) ~ . ) +
  labs(x="density") +
  ylab(NULL) +
  # scale_alpha_continuous(seq(0,b/10,1/100),range=0:1) +
  scale_fill_gradient2(low = "white", mid="red",high = "blue", midpoint = b/2) 
heat_conj_2_3
ggsave("heat_conjecture_2_3.pdf",heat_conj_2_3,width=12,height=6,units="cm",path="images")

heat_conj_2_3 + xlim(c(6,300))

conj_line <- plot_hm %>% ggplot() + 
  geom_line(aes(x=group*b, y=(cnt/set_cnt), color = label)) +
  facet_grid(odd ~ .) + theme_minimal() + ylab("nombre moyen d'erreur") + xlab("x") 
ggsave("conjecture_2_3_10k_bin5_line.pdf",conj_line,width=12,height=6,units="cm",path="images")
