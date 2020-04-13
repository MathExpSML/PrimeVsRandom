unwrap_csv <- function(csv){
  df <- data.frame(read.csv(csv))
  DF = c()
  for (i in seq(3,ncol(df))){
    DF[[i-2]] = df[df[i]==TRUE,2]
  }
  DF
}

#samples <- unwrap_csv("data//prob_samples-2020-04-12.csv")