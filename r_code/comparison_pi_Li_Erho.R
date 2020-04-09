source("r_code/pack_func.R")

# generate list of all integers up to 10000
x <- seq(2,10000,1)

# generate images of functions
pi_x = sapply(x, FUN=pi)
Li_x = sapply(x, FUN=Li)
rho_x = sapply(x, FUN=rho)

# Generate a data frame to plot multiple lines
comparison <- rbind(  data.frame(x, label = "pi", value = pi_x,linetype = "solid"),
  data.frame(x, label = "Li", value = Li_x,linetype = "solid"),
  data.frame(x, label = "rho", value = rho_x,linetype="dashed"))

comp <- comparison %>%  ggplot(aes(x, value, color = label)) + 
  geom_line(aes(linetype=linetype)) + 
  theme_minimal() +
  labs(y= NULL, x = NULL, color=NULL)+ 
  theme(legend.position=c(.05,.95), legend.justification = c("left", "top"),legend.box.just = "right") +
  guides(linetype = FALSE)

ggsave("comparison_sigma_prob.pdf",comp, width = 6, height = 4, path="images")
