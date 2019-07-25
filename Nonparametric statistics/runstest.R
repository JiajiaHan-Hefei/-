#随机游程检验
library(tseries)
#或者是library(lawstat)
run1 = c(1,1,1,0,rep(1,7),0,1,1,0,0,rep(1,6),0,rep(1,4),0,rep(1,5),rep(0,4),rep(1,13))
y = factor(run1)
runs.test(y)
