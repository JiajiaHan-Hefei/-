setwd('D://R语言程序编译/应用回归及分类练习')
w=read.csv("kidney02.csv")

#决策树
library(rpart.plot)
(a=rpart(class~.,w))
rpart.plot(a,type=4,extra=3,digits=4,Margin=0)
#预测
predict(a,new.data,type="class")
#变量重要性
a$var

#bagging
set.seed(9999)
a=bagging(class~.,w)
#预测
predict(a,new.data)$class
#交叉验证
bcv=bagging.cv(class~.,w,v=10)
#混淆矩阵
bcv$confusion
bcv$err


#randomFoest
library(randomForest)
set.seed(1010)
a=randomForest(class~.,w,importance=T,localImp=T,proximity=T)
#部分依赖图
NM=names(w)[1:24]
par(mfrow=c(4,6))
for(i in 1:24)
{
  partialPlot(a,pred.data=w,NM[i],xlab=NM[i],
              main="Partial Dependence on",NM[i])
}
#透视图
par(mfrow=c(1,2))
persp(1:400,1:400,a$proximity,theta=30,phi=30,
      expand=0.5,col="lightblue")
#影像图
image(1:400,1:400,a$proximity)
#接近度
d=outlier(a$proximity)
plot(d,type="h")
#寻找最佳节点竞争变量个数
set.seed(8888)
tuneRF(w[,-25],w[,25],stepFactor=1.5)


#adaboost分类
library(adabag)
set.seed(1010)
a=boosting(class~.,w)
barplot(a$importance)
predict(a,new.data)$class
cv=boosting.cv(class~.,w,v=10)


#人工神经网络
library(nnet)
set.seed(9999)
a=nnet(class~.,w,size=20,rang=0.01,decay=5e-4,maxit=300)

#支持向量机
library(kernlab)
a=ksvm(class~.,w,cross=10)
table(predict(a,w),w$class)
#核函数
a@kernelf

#K近邻
library(kknn)
a=kknn(class~.,train=w,test=w)
table(a$fit,w$class)



#实验一：蘑菇可食用性
#数据来源：http://archive.ics.uci.edu/ml/datasets/Mushroom
w=read.table("agaricus-lepiota.data")
library(rpart.plot)
(a=rpart(V1~.,w))
rpart.plot(a,type=4,extra=3,digits=4,Margin=0)
a.p=predict(a,w,type="class")
table(a.p,w$V1)
a$var

library(adabag)
a=bagging(V1~.,w)

a=randomForest(V1~.,w,importance=T,localImp=T,proximity=T)
print(a)
a$importance
par(mfrow=c(2,2))
for (i in 1:4) {
  barplot(a$importance[,i],cex.names=7,main=colnames(a$importance)[i])
}
#局部变量的重要性
matplot(2:23,a$local,type="1",xlab="variable",ylab="local importance",
        main="local imporatance",xaxp=c(2,23,21))
#部分依赖图
par(mfrow=c(4,6))
for (i in 1:22) {
  partialPlot(a,pred.data=w,NM[i],xlab=NM[i],
              main=paste("Partial Dependence on"),NM[i])
}

library(adabag)
set.seed(1010)
a=boosting(V1~.,w)
barplot(a$importance,cex.names = 1.2)


#实验二：手写数据笔记识别
#数据来源：http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/multiclass.html#new20
w=read.table("pendigits.t")
w[,17]=factor(w[,17]);m=1:3498
D=17;n=nrow(w)
ff=as.formula(paste(names(w)[D],"~."))
a=list()
E=rep(999,6)

J=1
set.seed(1010)
a[[J]]=boosting(ff,w[-m,])
E[J]=sum(w[m,D]!=predict(a[[J]],w[,m])$class)/length(m)
J=2
set.seed(1010)
a[[J]]=randomForest(ff,w[-m,])
E[J]=sum(w[m,D]!=predict(a[[J]],w[,m]))/length(m)
J=3
set.seed(1010)
a[[J]]=ksvm(ff,w[-m,])
E[J]=sum(w[m,D]!=predict(a[[J]],w[,m]))/length(m)
J=4
set.seed(1010)
a[[J]]=kknn(ff,w[-m,],w[m,])
E[J]=sum(w[m,D]!=predict(a[[J]]$fit))/length(m)
J=5
set.seed(1010)
a[[J]]=lda(ff,w[-m,])#线性判别分析
E[J]=sum(w[m,D]!=predict(a[[J]],w[m,])$class)/length(m)
J=6
set.seed(1010)
a[[J]]=mda(ff,w[-m,])#混和线性判别分析
E[J]=sum(w[m,D]!=predict(a[[J]],w[m,]))/length(m)

