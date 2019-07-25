################logistic回归
setwd('D://R语言程序编译/应用回归及分类练习')
w <- read.csv("transfusion.csv")
a=glm(Donate~.w,family = binomial)
summary(a)
#参数置信区间
confint(a,parm = c(2:3))
#方差分析
anova(a,test="Chisq")
#wald检验
library(aod)
wald.test(b=coef(a),Sigma=vcov(a),Terms=c(2,4))

#二分类
#=0.5
n-nrow(w)
D=4;w[,D]=factor(w[,D]);pt=0.5
a=glm(Donate~.,w,family = binomial)
z=predict(a,w,type="response")
u=rep(levels(w[,D])[2],n)
u[!(z>pt)]=levels(w[,D])[1]
table(w[,D],u)
(e=sum(w[,D]!=u)/n)

##################
BI=function(D,w,ff,fm="binomial"){
  a=glm(ff,w,family = fm)
  z=predict(a,w,type="response")
  ee=NULL
  for(p in seq(0.01,0.99,0.01)){
    u=rep(levels(w[,D])[2],nrow(w))
    u[!(z>p)]=levels(w[,D])[1]
    e=sum(u!=w[,D])/nrow(w)
    ee=rbind(ee,c(p,e))}
  I=which(ee[,2]==min(ee[,2]))
  return(ee[min(I),])
}
ff=Donate~.
BI(4,w,ff)


###########交叉验证
BIM=function(D,w,ff,m,fm="binomial"){
  P=BI(D,w,ff)[1]
  a=glm(ff,w[-m,],family = fm)
  z=predict(a,w[m,],type="response")
  u=rep(levels(w[m,D])[2],nrow(w[m,]))
  u[!(z>p)]=levels(w[,D])[1]
  e=sum(u!=w[m,D])/nrow(w[m,])
  return(e)
}
D=4;Z=10;n=nrow(w)
ff=paste(names(w)[D],"~.",sep = " ");ff=as.formula(ff)
mm=Fold(Z,w,D,8888)
KK=3;E=matrix(99,Z,KK)
J=1
for(i in 1:Z)
{
  m=mm[[i]]
  a=glm(ff,w[,-m],family = "binomial")
  z=(predict(a,w[,-m],type="response")>0.5)
  u=rep(levels(w[m,D])[2],nrow(w[m,]))
  u[!z]=levels(w[m,D])[1]
  E[i,J]=sum(w[m,D]!=u)/length(m)
}
J=J+1
for (i in 1:Z) {
  m=mm[[i]]
  E[i,J]=BIM(D,w,ff,m)
}
J=J+1
for (i in 1:Z) {
  m=mm[[i]]
  a=lda(ff,w[-m,])
  E[i,J]=sum(w[m,D]!=predict(a,w[,-m])$class)/length(m)
}
apply(E,2,mean)



#######possion对数线性模型
html="http://www.statsci.org/data/general/cyclamen.txt"
w <- read.table(html,sep = '\t',header = TRUE)
ww = data.frame(Variety=w[,1],Regimem=w[,2],Day=w[,3],Night=w[,4],Fertilizer=w[,5],Flowers=w[,6])
n=nrow(w);m=ncol(w)
for(i in c(1,2,5)) w[,i]=factor(w[,i])
############
table(w[,c(1,2,5)])
############
w=w[,-(3:4)]
a=glm(Flowers~.,w,family = poisson)
summary(a)
#变量Fertilizer不显著
b=step(a);summary(b)
anova(b,a,test="Chisq")
########
d=glm(b,w,family = quasipoisson(link="log"))


#######交叉验证模型
Fold <- function(Z=10,w,D,seed){
  n=nrow(w)
  d1=1:n
  dd=list()
  e=levels(w[,D])
  t=length(e)
  set.seed(seed)
  for(i in 1:t)
  {
    d0=d1[w[,D]==e[i]]
    j=length(d0)
    zt=rep(1:Z,ceiling(j/Z))[1:j]
    id=cbind(sample(zt,length(zt)),d0)
    dd[[i]]=id
  }
  mm=list()
  for(i in 1:Z){
    u=NULL;
    for(j in 1:t)  u=c(u,dd[[j]][dd[[j]][,1]==i,2])
    mm[[i]]=u
  }
  return(mm)
}
####先选与3个变量搭配的分类变量
L=rep(777,n)
J=0;for(i in unique(w[,1])) for(j in unique(w[,2])) for(k in unique(w[,5]))
{J=J+1;L[w[,1]==i&w[,2]==j&w[,5]==k]==J}
L=data.frame(a=factor(L),1)
####再用10折交叉验证
w=w[,-(3:4)];D=4;Z=10
mm=Fold(Z,L,1,8888);
MSE=matrix(99,Z,2)
J=1
for(i in 1:Z)
{
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=glm(Flowers~.,w[-m,],family = "possion")
  y1=predict(a,w[m,],type="response")
  MSE[i,J]=mean((w[m,D]-y1)^2)/M
}
J=J+1
for(i in 1:Z)
{
  m=mm[[i]]
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=lm(Flowers~.,w[-m,])
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
}
