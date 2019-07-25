##Spearman秩相关检验
ss=c(65,79,67,66,89,85,84,73,88,80,86,75)
su=c(62,66,50,68,88,86,64,62,92,64,81,80)
cor.test(ss,su,meth="spearman")
##Kendall t 相关检验
cor.test(ss,su,meth="kendall")

##建立间隔分位回归
install.packages("quantreg");
library(quantreg)
library(SparseM)
par(mfrow=c(1,3))
data(engel)
attach(engel)
plot(income,foodexp,xlab="household income",ylab="food expenditure",type="n",cex=.5)
points(income,foodexp,cex=.5)
taus=seq(0.1,0.9,0.1)
f=coef(rq((foodexp)~(income),tau=taus))
for(i in 1:length(taus))
{
  abline(f[,i][1],f[,i][2],lty=2)
}
abline(lm(foodexp~income),lty=9)
abline(rq((foodexp)~(income),tau=0.5))
legend(3000,700,c("mean","median","otherquantile"),lty=c(9,1,2))
plot(taus,f[1,])
lines(taus,f[1,])
plot(taus,f[2,])
lines(taus,f[2,])

