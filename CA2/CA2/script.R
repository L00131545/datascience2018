install.packages("pwr")
library(pwr)
n_value <- pwr.t.test(power = 0.8, d = 0.055297,
                              sig.level = 0.05,
                              type = "two.sample",
                              alternative = "two.sided")
n_value
plot(n_value)

sig_level <- pwr.t.test(n = 45, d = 0.055297,
                                      power = 0.8,
                                      sig.level = NULL,
                                      type = "two.sample",
                                      alternative = "two.sided")
sig_level
plot(sig_level)
