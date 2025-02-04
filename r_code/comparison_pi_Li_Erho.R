source("r_code/pack_func.R")

# generate list of all integers up to 10000 = bound
x <- seq(2,10000,)

# generate images of functions
pi_x = sapply(x, FUN=pi)
Li_x = sapply(x, FUN=Li)
rho_x = sapply(x, FUN=rho)

sig <- function(x) {
  if (x <=5) {
    0
  } else {
  4 + sum(sapply(5:floor(x/2),FUN= function(n) 2/log(2*n-1)))
  }
}
sig_x = sapply(x,FUN=sig)


# Generate a data frame to plot multiple lines
comparison <- rbind(  data.frame(x, label = "pi", value = pi_x),
  data.frame(x, label = "Li", value = Li_x),
  data.frame(x, label = "sigma_k", value = rho_x),
  data.frame(x, label = "sigma_k'", value = sig_x))

lt = c("pi"="solid", "Li"="solid", "sigma_k"="dashed", "sigma_k'"="dashed")
alphas = c("Li" = 0.5, "pi"=1,"sigma_k"=1,"sigma_k'"=1)
cols = c(pi="red",Li = "orange", "sigma_k"= "blue", "sigma_k'"="purple")

comp <- comparison %>% filter(label %in% c("pi","Li","sigma_k")) %>% 
  ggplot(aes(x, value, color = label,linetype=factor(label), alpha = label)) + 
  geom_line() + 
  scale_linetype_manual(values=lt, na.value = "solid") +
  scale_color_manual(values=cols) + 
  scale_alpha_manual(values = alphas) +
  theme_minimal() +
  labs(y= NULL, x = NULL, color=NULL)+ 
  theme(legend.position=c(.05,.95), legend.justification = c("left", "top"),legend.box.just = "right") +
  guides(alpha = FALSE, linetype = FALSE)
ggsave("comparison_sigma_prob.pdf",comp,  width = 14, height = 6,unit="cm", path="images")

comp <- comparison %>% filter(label %in% c("pi","Li","sigma_k'")) %>% 
  ggplot(aes(x, value, color = label)) + 
  geom_line(aes(linetype=label, alpha = label)) +
  scale_linetype_manual(values=lt, na.value = "solid") +
  scale_color_manual(values=cols) + 
  scale_alpha_manual(values = alphas) +
  theme_minimal() +
  labs(y= NULL, x = NULL, color=NULL)+ 
  theme(legend.position=c(.05,.95), legend.justification = c("left", "top"),legend.box.just = "right") +
  guides(alpha = FALSE, linetype = FALSE)
ggsave("comparison_odd_prob.pdf",comp, width = 14, height = 6,unit="cm", path="images")
comp
