setwd('D://R语言程序编译/应用回归及分类练习')
data("Puromycin")
######第一个模型：简单线性回归
a1=lm(rate~conc,Puromycin)
summary(a1)
shapiro.test(a1$res)
#####第二个模型:加上定性变量
a2=lm(rate~.,Puromycin)
summary(a2)
#####第三个模型:加入交叉效应
a3=lm(rate~conc*state,Puromycin)
summary(a3)
#####第四个模型：非线性
a4=lm(rate~log(conc)+state,Puromycin)
summary(a4)
shapiro.test(a4$res)
#####第五个模型：非线性+交叉效应
a5=lm(rate~log(conc)*state,Puromycin)
summary(a5)
shapiro.test(a5$res)


#######交叉验证模型
#z是折数
#w是数据名称
#d为要照顾的定性变量是在数据中的列数
Fold <- function(z=5,w,d,seed){
  n=nrow(w)
  d1=1:n
  dd=list()
  e=dim(w[,d])[2]
  t=length(e)
  set.seed(seed)
  for(i in 1:t)
  {
    d0=d1[w[,d]==e[i]]
    j=length(d0)
    zt=rep(1:z,ceiling(j/z))[1:j]
    id=cbind(sample(zt,length(zt)),d0)
    dd[[i]]=id
  }
  mm=list()
  for(i in 1:z){
    u=null;
    for(j in 1:t)  u=c(u,dd[[j]][dd[[j]][,1]==i,2])
    mm[[i]]=u
  }
  return(mm)
}

#####回归模型
w=Puromycin;d=2;FML=list();
J=1;FML[[J]]=as.formula(paste(names(w)[d],"~",names(w)[1]))
J=2;FML[[J]]=as.formula(paste(names(w)[d],"~."))
J=3;FML[[J]]=as.formula(paste(names(w)[d],"~",names(w)[1],"*",names(w)[3]))
J=4;FML[[J]]=as.formula(paste(names(w)[d],"~log(",names(w)[1],")"))
J=5;FML[[J]]=as.formula(paste(names(w)[d],"~log(",names(w)[1],")+",names(w)[3]))  
J=6;FML[[J]]=as.formula(paste(names(w)[d],"~log(",names(w)[1],")*",names(w)[3]))
#####5折交叉验证
JJ=6;D=2;z=5;WW=NULL;N=1000
set.seed(1010)
Seed=sample(1:100000,N)
for(k in 1:N){
  mm=Fold(5,w,3,Seed[N])
  E=matrix(-99,Z,JJ)
  for(J in 1:JJ){
    for(i in 1:z){
      m=mm[[i]]
      M=mean((w[m,D]-mean(w[m,D]))^2)
      a0=lm(FML[[J]],data=w[-m,])
      pa=predict(a0,w[m,])
      E[i,J]=mean((w[m,D]-pa)^2/M)
    }
  }
  WW=rbind(WW,E)
}
#最后输出6个平均NMSE
(ZZ=apply(WW,2,mean))



##################CV函数
##随机把数据的下标分成Z份以做交叉验证使用
CV <- function(n,Z=10,seed=888){
  z=rep(1:Z,ceiling(n/Z))[1:n]
  set.seed(seed);z=sample(z,n)
  mm=list()
  for(i in 1:Z) mm[[i]]=(1:n)[z==i]
  return(mm)
}


################共线性问题
library(lars)
data("diabetes")
w=as.matrix(diabetes)[,11:75]
library(car)
library(carData)
kappa(w[,-1])#X2的条件数
sort(vif(lm(y~.,as.data.frame(w))),de=T)[1:5]


#############逐步回归
a=step(lm(y~.,as.data.frame(w)))
summary(a)
plot(a$fit,a$res)
abline(h=0,lty=2)


###########岭回归
library(ridge)
a=linearRidge(y~.,data=as.data.frame(w))
summary(a)
plot(a)


#########lasso回归
library(lars)
w=as.data.frame(w)
y=as.matrix(w[,1])
x2=as.matrix(w[,-1])
laa=lars(x2,y)#lars只用于矩阵型数据
plot(laa)
summary(laa)
cva=cv.lars(x2,y,K=10)#使用10折交叉验证
best=cva$index[which.min(cva$cv)]#选合适的比率
coef=coef.lars(laa,mode="fraction",s=best)
min(laa$Cp)#最小Cp
coef1=coef.lars(laa,mode="step",s=15)


########alasso回归
library(msgps)
y=w[,1]
x2=as.matrix(w[,-1])
al=msgps(x2,y,penalty = "alasso",gamma = 1,lambda = 0)
summary(al)
plot(al)


#######偏最小二乘回归
library(pls)
ap=plsr(y~x2,64,validation="CV")
ap$loadings#看代表性，前28个因子可以代表76.4%的方差
ap$coef#看各个因子作为原始变量的线性组合的系数
RMSEP(ap)
MSEP(ap)
R2(ap)
par(mfrow=c(1,3))
plot(RMSEP(ap));abline(v=5,lty=2)
plot(MSEP(ap));abline(v=5,lty=2)
plot(R2(ap));abline(v=5,lty=2)


##########10折交叉验证
w=as.data.frame(w)
n=nrow(w)
D=1
y=as.matrix(w[,D])
x2=as.matrix(w[,-D])
Z=10
mm=CV(n,Z)
MSEC=matrix(999,Z,6)
J=1
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=lm(y~.,data=w[-m,])
  MSEC[i,J]=mean((y[m,]-predict(a,w[m,]))^2)/M
}
J=2
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=step(lm(y~.,data=w[-m,]))
  MSEC[i,J]=mean((y[m]-predict(a,w[m,]))^2)/M
}
J=3
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=linearRidge(y~.,data=w[-m,])
  MSEC[i,J]=mean((y[m]-predict(a,w[m,]))^2)/M
}
J=4
set.seed(1010)
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=msgps(x2[-m,],y[-m])
  MSEC[i,J]=mean((y[m]-predict(a,x2[m,]))^2)/M
}
J=5
set.seed(1010)
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=msgps(x2[-m,],y[-m],penalty = "alasso",gamma = 1,lambda = 0)
  MSEC[i,J]=mean((y[m]-predict(a,x2[m,]))^2)/M
}
J=6
set.seed(1010)
for(i in 1:Z){
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=plsr(y[-m]~x2[-m,],5,validation = "CV")
  MSEC[i,J]=mean((y[m]-predict(a,x2[m,]))^2)/M
}
MSEC=data.frame(MSEC)
names(MSEC)=c("lm","step","ridge","lasso","alasso","pls")
(NMSE=apply(MSEC,2,mean))
MSEC




#############分位数回归:rq
library(quantreg)
data("engel")
plot(summary(rq(foodexp~income,tau=1:49/50,data=engel)))

############################33
par(mfrow=c(1,2))
plot(foodexp~income,data=engel,main="engel data")
taus <- c(.15,.25,.50,.75,.95,.99)
#存储结果
rqs <- as.list(taus)
for(i in seq(along=taus))
{
  #对每个tau做分位数回归并画图
  rqs[[i]]=rq(foodexp~income,tau=taus[i],data=engel)
  lines(engel$income,fitted(rqs[[i]]),col=i+1)
}
legend("bottomright",paste("tau=",taus),insert=0.04,col=2:(length(taus)+1),lty=1)
#重复上述过程
#把foodexp换成log10(foodexp)
plot(log10(foodexp)~log10(income),data=engel,main="engel data (log10-transformed)")
for(i in seq(along=taus))
{
  #对每个tau做分位数回归并画图
  rqs[[i]]=rq(log10(foodexp)~log10(income),tau=taus[i],data=engel)
  lines(log10(engel$income),fitted(rqs[[i]]),col=i+1)
}
legend("bottomright",paste("tau=",taus),insert=0.04,col=2:length(taus)+1,lty=1)


################应用
attach(engel)
#tau=-1:取（0，1）中最密集的tau
z <- rq(foodexp~income,tau=-1,engel)
x.poor=quantile(income,0.05)
x.rich=quantile(income,0.95)
qs.poor <- c(c(1,x.poor)%*%z$sol[4:5,])
qs.rich <- c(c(1,x.rich)%*%z$sol[4:5,])
ps <- z$sol[1,]
ps.wts <- (c(0,diff(ps))+c(diff(ps),0))/2
#自适应核密度估计
ap <- akj(qs.poor,z=qs.poor,p=ps.wts)
ar <- akj(qs.rich,z=qs.rich,p=ps.wts)
#画图程序
par(mfrow=c(1,2))
plot(c(ps,ps),c(qs.poor,qs.rich),type="n",xlab=expression(tau),ylab="foodexp")
plot(stepfun(ps,c(qs.poor[1],qs.poor)),do.points=F,add=T)
plot(stepfun(ps,c(qs.poor[1],qs.rich)),do.points=F,add=T,lty=2)
legend("topleft",c("poor","rich"),lty=c(1,2))
plot(c(qs.poor,qs.rich),c(ap$dens,ar$dens),type="n",xlab="Food Expenditure",ylab="Density")
lines(qs.poor,ap$dens)
lines(qs.rich,ar$dens,lty=2)
legend("topright",c("poor","rich"),lty=c(1,2))

