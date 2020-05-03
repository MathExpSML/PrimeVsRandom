source("r_code/pack_func.R")

# generate list of all integers up to 10000 = bound
bound = 10000
x <- seq(2,bound,(bound-2)/1000)


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
  data.frame(x, label = "rho", value = rho_x),
  data.frame(x, label = "sigma", value = sig_x))

<<<<<<< HEAD
lt = c("pi"="solid", "Li"="solid", "rho"="dashed", "sigma"="dashed")
alphas = c("Li" = 0.5, "pi"=1,"rho"=1,"sigma"=1)
cols = c(pi="red",Li = "orange", sigma= "blue", rho="purple")
=======
# lt = c("pi"="solid", "Li"="solid", "rho"="dashed", "sigma"="dashed")
alphas = c("Li" = 0.5, "pi"=1,"rho"=1,"sigma"=1)
>>>>>>> 261905c3b265308df1da25fb22c9558164e1e220

comp <- comparison %>% filter(label %in% c("pi","Li","rho")) %>% 
  ggplot(aes(x, value, color = label,linetype=factor(label), alpha = label)) + 
  geom_line() + 
<<<<<<< HEAD
  scale_linetype_manual(values=lt, na.value = "solid") +
  scale_color_manual(values=cols) + 
=======
  scale_linetype_discrete(values=lt, na.value = "solid") +
>>>>>>> 261905c3b265308df1da25fb22c9558164e1e220
  scale_alpha_manual(values = alphas) +
  theme_minimal() +
  labs(y= NULL, x = NULL, color=NULL)+ 
  theme(legend.position=c(.05,.95), legend.justification = c("left", "top"),legend.box.just = "right") +
  guides(alpha = FALSE, linetype = FALSE)
ggsave("comparison_sigma_prob.pdf",comp, width = 6, height = 4, path="images")

comp <- comparison %>% filter(label %in% c("pi","Li","sigma")) %>% 
  ggplot(aes(x, value, color = label)) + 
  geom_line(aes(linetype=label, alpha = label)) +
<<<<<<< HEAD
  scale_linetype_manual(values=lt, na.value = "solid") +
  scale_color_manual(values=cols) + 
=======
  scale_linetype_discrete(values=lt) +
>>>>>>> 261905c3b265308df1da25fb22c9558164e1e220
  scale_alpha_manual(values = alphas) +
  theme_minimal() +
  labs(y= NULL, x = NULL, color=NULL)+ 
  theme(legend.position=c(.05,.95), legend.justification = c("left", "top"),legend.box.just = "right") +
  guides(alpha = FALSE, linetype = FALSE)
<<<<<<< HEAD
ggsave("comparison_odd_prob.pdf",comp, width = 6, height = 4, path="images")
=======
ggsave("comparison_sigma_prob2.pdf",comp, width = 6, height = 4, path="images")
>>>>>>> 261905c3b265308df1da25fb22c9558164e1e220
comp
