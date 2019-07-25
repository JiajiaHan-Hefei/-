##实例
##利用wilcoxon 符号秩检验认为中心位置超过320
x <- c(310,350,370,377,389,400,415,425,440,295,325,296,250,340,298,365,375,360,385);
wilcox.test(x)
#为了方便比较我们采取binom.test进行参数位置的检验
s = sum(x>320)
n = length(x)
binom.test(s,n,0.5)

##实例
##用Boostrap方法估计中位数
median.x = median(x)
TBoot = NULL
n=20
B=1000
SD.x = NULL
for (i in 1:B)
{
  xsample = sample(x,n,T)
  Tboot = median(xsample)
  TBoot = c(TBoot,Tboot)
  SD.x = c(SD.x,sd(TBoot))
}
sd.median.x = sd(TBoot)
plot(1:B,SD.x,col=4)
hist(TBoot,col=3)

##实例
##利用三种方法构造中位数置信区间
a = 0.05
#正态置信区间
lcl = median.x + qnorm(0.025,0,1)*sd.median.x
ucl = median.x - qnorm(0.025,0,1)*sd.median.x
norm_interval = c(lcl,ucl)
#枢轴量置信区间
lc2 = 2*median.x - quantile(TBoot,0.975)
uc2 = 2*median.x - quantile(TBoot,0.025)
pivotal_interval = c(lc2,uc2)
#1-a的Bootstrap Pivotal置信区间
uc3 =quantile(TBoot,0.975)
lc3 =quantile(TBoot,0.025)
quantile_interval = c(lc3,uc3)


##实例
##中位数的置信区间
y <- c(82,53,70,73,103,71,69,80,54,38,87,91,75,65,77)
a = 0.05
n = length(y)
conf = pbinom(n,n,0.5)-pbinom(0,n,0.5)
for (k in 1:n)
{
  conf = pbinom(n-k,n,0.5)-pbinom(k-1,n,0.5)
  if (conf<1-a) {loc = k-1;print(loc) ;break}
}
##得到的结果为4，故按照数据排列选取(x(k),x(n-k+1))的为(62,82)

##实例
##walsh方法的中位数的置信区间
n = length(y)
a = 0.05
for (k in seq(1,n/2,1))
{
  f = pbinom(n-k,n,0.5)-pbinom(k,n,0.5)
  if (f < 1-a)
  {
    l=k-1;
    break
  }
}
sort.Walsh.AL.scot = sort(y)
lower = sort.Walsh.AL.scot[l]
upper = sort.Walsh.AL.scot[n-l+1]
c(lower,upper)

