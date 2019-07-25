setwd('D://R语言程序编译/应用回归及分类练习')


#######决策树
w=read.table("servo.data")
library(rpart.plot)
(a=rpart(class~.,w))
rpart.plot(a,type=4,extra=1,digits=4)
predict(a,new.data)
#######
n=nrow(w);D=5;K=7;
mm=Fold(K,w,2,8888);gg=class~.
MSE=matrix(99,K,2)

J=1
for(i in 1:K)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=rpart(gg,w[-m,])#决策树回归
MSE[i,J]=mean((w[m,D]-mean(w[m,D]))^2)/M
}

J=2
for(i in 1:K)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=lm(gg,w[-m,])#线性回归
MSE[i,J]=mean((w[m,D]-mean(w[m,D]))^2)/M
}
MSE=data.frame(MSE)
names(MSE)=c("Tree","LM")
apply(MSE,2,mean);MSE


###############bagging回归
w=read.csv("airfoil.csv");n=nrow(w)
library(ipred)
set.seed(1010)
#coob表示使用OOB数据进行交叉验证
#OOB表示自助法抽样当中没有抽到的观测值组成的数据
#a$err表示交叉验证误差
a=bagging(pressure~.,w,coob=T)
##########
D=6;K=10;mm=CV(nrow(w),K,1111)
gg=pressure~.
MSE=matrix(99,K,3) = NMSE
J=1
for(i in 1:K)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=rpart(gg,w[-m,])#决策树回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)
NMSE[i,J]=MSE[i,J]/M
}
J=2
set.seed(1010)
for(i in 1:K)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=bagging(gg,w[-m,])#bagging回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)
NMSE[i,J]=MSE[i,J]/M
}
J=3
set.seed(1010)
for(i in 1:K)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=lm(gg,w[-m,])#线性回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)
NMSE[i,J]=MSE[i,J]/M
}

#############随机森林树
w=read.csv("energy.csv");w=w[,-10]
library(randomForest)
set.seed(1010)
a=randomForest(Y1~,w,importance=T,localImp=T,proximity=T)
names(a)
#获取树的信息
getTree(a,28,labelVar=T)
#变量重要性程度
a$importance
#接近度表示观测值接近观测主体
a$proximity
#绘制变量重要性图形和局部重要性图形
layout(matrix(c(1,2,3,3),nrow=2,b=T))
for(i in 1:2){
  barplot(a$importance[,i],horiz=T)
  title(colnames(a$importance)[i])
}
matplot(1:8,a$local,type="1",xlab="Variable",
        ylab="Local importance",main="Local importance")
#部分依赖图
par(mfrow=c(2,4))
partialPlot(a,pred.data=w,X1);partialPlot(a,pred.data=w,X2)
partialPlot(a,pred.data=w,X3);partialPlot(a,pred.data=w,X4)
partialPlot(a,pred.data=w,X5);partialPlot(a,pred.data=w,X6)
partialPlot(a,pred.data=w,X7);partialPlot(a,pred.data=w,X8)
#关于误差的两个点图
rr=rfcv(w[,-9],w[,9],cv.fold=10)
par(mfrow=c(1,2))
plot(a,main="Error vs number of tree")
with(rr,plot(n.var,error.var,type="o",lwd=2))
#寻找最优节点竞争变量个数
set.seed(8888);tuneRF(w[,-9],w[,9],stepFactor=1.5)

########
w=w[,-c(2,10)]
D=8;Z=10;mm=CV(nrow(w),Z)
gg=paste(names(w)[D],"~",".",sep="")
gg=as.formula(gg)
####
KK=3;MSE=matrix(0,Z,KK)
set.seed(1010)
J=1
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=bagging(gg,w[-m,])#bagging回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}
J=2
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=radomForest(gg,data=w[-m,],mtry=8)#随机森林回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}
J=3
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=lm(gg,data=w[-m,])#线性回归
MSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}

MSE=data.frame(MSE)
names(MSE)=c("bagging","RF","LM")
options(digits=3)
(NMSE=apply(MSE, 2, MSE));MSE




###################mboost回归
w=read.csv("imports85.csv");m=ncol(w);NM=names(W)
gg1=paste(NM[m],"~bree(",NM[1],")+",sep="")
for(i in 2:(m-1)) gg1=paste(gg1,"~btree(",NM[i],")+",sep="")
gg1=as.formula(gg1)
gg2=paste(NM[m],"~bree(",NM[1],",",sep="")
for(i in 2:(m-1)) gg2=paste(gg2,",",NM[i],")+",sep="")
gg2=as.formula(paste(gg2,")",sep=""))
library(mboost)
a1=mboost(gg1,w);a2=mboost(gg2,w)
mean(resid(a1)^2);mean(resid(a2)^2)
#变量重要性
TS1=table(selected(a1))
par(mai=c(0.5,1.5,0.5,0.5))
barplot(TS1,names.arg = names(w)[TS1],horiz=T,las=2)
##########
D=26;Z=10;mm=CV(nrow(w),Z,9999)
KK=3;NMSE=matrix(0,Z,KK)
set.seed(1010)
J=1
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=bagging(price~.,w[-m,])#bagging回归
NMSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}
J=2
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=radomForest(price~.,data=w[-m,])#随机森林回归
NMSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}
J=3
for(i in 1:Z)
{m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
a=lm(gg1,data=w[-m,])#mboost回归
NMSE[i,J]=mean((w[m,D]-predict(w[m,D]))^2)/M
}

NMSE=data.frame(NMSE)
names(NMSE)=c("bagging","RF","mboost")
(NMSE=apply(NMSE, 2, mean));NMSE

###############人工神经网络
library(nnet)
w=read.csv("imports85.csv")
sel=c(2,1,5,7,4,6,9)
w1=w[c(sel,26)]
a=nnet(price/max(price)~.,data=w1,method="nnet",maxit=1000,size=5,decay=0.01,trace=F)
library(devtools)
source_url('http://gist.githubusercontent.com/fawda123/7471137/raw/
           466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(a)
par(mfrow=c(1,2))
plot(a$fitted*max(w$price)~w$price)
plot(a$fitted*max(w$price)~w$resid)
abline(h=0,lty=2)
#选择神经网络的参数
library(caret)
grid=expand.grid(.decay=c(0.5,0.1,0.05,0.01),.size=c(9,10,11))
fit=train(price/max(price)~.,data=w,method="nnet",maxit=1000,tuneGrid=grid,trace=F)
print(fit)



############支持向量机回归
library(e1071)
w=read.csv("imports85.csv")
set.seed(1010)
a=svm(pressure~.,w,cross=10)
summary(a)

#############K近邻回归
library(kknn)
E=NULL;K=10
for(i in 1:K){
  m=mm[[i]];M=mean((w[m,D]-mean(w[m,D]))^2)
  a=kknn(Pressure~.,w[-m,],w[m,])
  E=c(E,mean((w[m,D]-a$fitted)^2)/M)
}
NMSE$knn=E
MNMSE=apply(NMSE,2,mean)


