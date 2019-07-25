#训练集
library(xlsx)
library(rJava)
library(xlsxjars)
xy <- read.xlsx("C:\\Users\\Administrator\\Desktop\\多元统计数据\\训练集.xls",sheetName = "Sheet1" ,startRow = 1, encoding = "UTF-8")
train <- data.frame(pH = xy$pH, DO = xy$DO.mg.l., CODMn = xy$CODMn.mg.l., NH3_N = xy$NH3.N.mg.l., class=as.factor(xy$水质级别))
train
class_train <- as.factor(train$class)
table(class_train)

#测试集
xx <- read.xlsx("C:\\Users\\Administrator\\Desktop\\多元统计数据\\测试集.xls",sheetName = "Sheet1" ,startRow = 1, encoding = "UTF-8")
test1 <- data.frame(pH = xx$pH,DO = xx$DO.mg.l.,CODMn = xx$CODMn.mg.l.,NH3_N = xx$NH3.N.mg.l.,class=as.factor(xx$水质级别))
test = test1[,1:4]
class_test <- as.factor(test1$class)
table(class_test)
w=rbind(train,test1)



#不平衡数据的处理(rose只能处理2分类)
#install.packages("ROSE")
#library(ROSE)
#dxy <- ROSE(class~., data=xy,seed = 1)$data
#table(dxy$calss)


#判别分析中lda
library(MASS)
fit.lda =lda(class~.,data = train, prior = c(10,59,21,5,7)/102)
pred.lda0=predict(fit.lda,data=train)
conf.lda0=table(class_train,pred.lda0$class)
pred.lda = predict(fit.lda,data=test)
conf.lda = table(class_test,pred.lda$class)
error.lda = 1-sum(diag(conf.lda))/sum(conf.lda)
#交叉验证
fit.cvlda =lda(class~.,data = w,CV=T)
conf.cvlda = table(w$class,fit.cvlda$class)
error.cvlda = 1-sum(diag(conf.cvlda))/sum(conf.cvlda)

#判别分析中qda(没成功，有些类别太少)
library(MASS)
fit.qda =qda(class~.,data = train)
pred.qda0=predict(fit.qda,data=train)
conf.qda0=table(class_train,pred.qda0$class)
pred.qda = predict(fit.qda,data=test)
conf.qda = table(class_test,pred.qda$class)
error.qda = 1-sum(diag(conf.qda))/sum(conf.qda)

#判别分析中rda
library(klaR)
fit.rda =rda(class~.,data = train)
pred.rda0=predict(fit.rda,data=train)
conf.rda0=table(class_train,pred.rda0$class)
pred.rda = predict(fit.rda,data=test)
conf.rda = table(class_test,pred.rda$class)
error.rda = 1-sum(diag(conf.rda))/sum(conf.rda)
#交叉验证
fit.cvrda =rda(class~.,data = w,cv=T)
pred.cvrda=predict(fit.cvrda,data=w)
conf.cvrda = table(w$class,pred.cvrda$class)
error.cvrda = 1-sum(diag(conf.cvrda))/sum(conf.cvrda)


#决策树进行判断
library(rpart)
fit.rpart=rpart(class~.,data = train, method="class")

pred.rpart0=predict(fit.rpart,newdata=train,type="class")
#pred.rpart.prob=predict(fit.rpart,newdata=test,type="prob")
pred.rpart = predict(fit.rpart,newdata=test1,type="class")

conf.rpart0=table(class_train,pred.rpart0)
conf.rpart = table(class_test,pred.rpart)

error.rpart0 = 1-sum(diag(conf.rpart0))/sum(conf.rpart0)
error.rpart = 1-sum(diag(conf.rpart))/sum(conf.rpart)
#交叉验证
fit.rpart.all=rpart(class~.,w, method="class")
cv.rpart = xpred.rpart(fit.rpart.all,xval=10,return.all=F)
cv.class = apply(cv.rpart,1,function(x) which.max(table(x)))
conf.cvrpart = t(table(w$class,cv.rpart[,5]))
error.cvrpart = 1-sum(diag(conf.cvrpart))/sum(conf.cvrpart)
#绘制图形
plot(fit.rpart,uniform = T,main="test");text(fit.rpart,use.n=TRUE,fancy=T,col="blue")



#支持向量机方法
library(e1071)
fit.svm = svm(class~.,data=train)
pred.svm <-predict(fit.svm,newdata=test1,decision.values = FALSE)
#f <- as.factor(round(t(pred.svm)))
conf.svm = table(class_test,pred.svm)
error.svm = 1-sum(diag(conf.svm))/sum(conf.svm)

data("iris")
model.iris = svm(Species ~ .,iris)
plot(fit.svm,train,pH~DO)
plot(fit.svm,train,CODMn~NH3_N,xlim=c(0,2.5))
plot(fit.svm,train,pH~CODMn)
plot(fit.svm,train,pH~NH3_N,xlim=c(0,2.5))
plot(fit.svm,train,DO~CODMn)
plot(fit.svm,train,DO~NH3_N,xlim=c(0,2.5))

#写入excel表格
#wb <- loadWorkbook("C:\\Users\\Administrator\\Desktop\\多元统计数据\\测试集.xls")
#sheets <- getSheets(wb)
#addDataFrame(f,sheets[[1]],col.names=T,startColumn=7)
#saveWorkbook(wb,"C:\\Users\\Administrator\\Desktop\\多元统计数据\\测试集.xls")

#k近邻方法
library(class)
fit.knn = knn(train,test1,class_train,k=5,prob=T)
conf.knn =table(class_test,fit.knn)
error.knn = 1-sum(diag(conf.knn))/sum(conf.knn)
#交叉验证
cv.knn = knn.cv(w,cl=w$class,k=5)
conf.cvknn = table(cv.knn,w$class)
error.cvknn = 1-sum(diag(conf.cvknn))/sum(conf.cvknn)
#K近邻结果展示
plot(fit.knn,main="K近邻的结果展示")


#adaboost算法
#(wt)
library(adabag)
fit.ada = boosting(class ~., data=train, mfinal=10, maxdepth=3) 
pred.ada = predict(fit.ada,newdata=test1)
conf.ada = table(test1$class,pred.ada$class)
error.ada = 1-sum(diag(conf.ada))/sum(conf.ada)
#交叉验证
cv.boosting = boosting.cv(class~.,data = w,v=10)
conf.cvada = t(cv.boosting$confusion)
error.cvada = 1-sum(diag(conf.cvada))/sum(conf.cvada)
#绘制图形
b.ada<-errorevol(fit.ada,train)  
plot(b.ada$error,type="l",main="AdaBoost error vs number of trees",ylab="error")
barplot(fit.ada$importance,main="AdaBoost important variables") 

 
#bagging算法
#(wt)
library(adabag)
fit.bagging = bagging(class~.,data=train,boos=TRUE, mfinal=10) 
pred.bagging = predict(fit.bagging,newdata=test1)
conf.bagging = table(test1$class,pred.bagging$class)
error.bagging = 1-sum(diag(conf.bagging))/sum(conf.bagging)
#交叉验证
cv.bagging = bagging.cv(class~.,data = w,v=10)
conf.cvbag = t(cv.bagging$confusion)
error.cvbag = 1-sum(diag(conf.cvbag))/sum(conf.cvbag)
#绘制图形
b.bagging<-errorevol(fit.bagging,train)  
plot(b.bagging$error,type="l",main="Bagging error vs number of trees",ylab="error")
barplot(fit.bagging$importance,main="Bagging important variables") 





#randomforest算法
library(randomForest)
fit.rf = randomForest(class~.,data=train,importance=T)
pred.rf = predict(fit.rf,newdata=test1,importance=T)
#rf <- as.factor(round(t(pred.rf)))
conf.rf = table(class_test,pred.rf)
error.rf = 1-sum(diag(conf.rf))/sum(conf.rf)
#交叉验证
cv.rf = rfcv(w,w$class,cv.fold=10)
cv.rf$n.var
dataf_rf <- data.frame(y=w$class,y1=cv.rf$predicted[1],y2=cv.rf$predicted[2],y3=cv.rf$predicted[3])
conf.cvrf1 <- table(dataf_rf$y,dataf_rf$y1)
conf.cvrf2 <- table(dataf_rf$y,dataf_rf$y2)
conf.cvrf3 <- table(dataf_rf$y,dataf_rf$y3)
error.cvrf = cv.rf$error.cv[2]
#绘制图形
varImpPlot(fit.rf,main="随机森林树的精确度与基尼指数的展示")
plot(fit.rf,main="随机森林树构造树的个数随着错误率的稳定变化")



rocplot <- function(m)
{
  x<- rep(0,5)
  y<- rep(0,5)
  for(i in 1:5)
  {
   x[i] <- m[i,i]/sum(m[i,])
   y[i] <- (1-m[i,i]/sum(m[i,]))
  }
  plot(x,y)
  print(x)
  print(y)
}





#汇总
error = c(error.cvknn,error.svm,error.cvrpart,error.cvada,error.cvbag,error.cvrf)
names(error)=c("K近邻","SVM","决策树","AdaBoost","Bagging","RF")
list(names,error)

pred = list(fit.knn,pred.rpart,pred.svm,pred.ada$class,pred.bagging$class,pred.rf)
write.xlsx(pred,"C:/Users/Administrator/Desktop/Book.xls",sheetName = "sheet1")
