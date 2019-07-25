#分类数据的关联分析
#Mantel-Haenszel检验
da1 <- matrix(c(50,92,15,90),2)
da2 <- matrix(c(47,5,135,60),2)
m <- c(da1,da2)
x <- array(m,c(2,2,2))
mantelhaen.test(x)

#Fisher精确检验
da <- matrix(c(8,7,2,23),2)
fisher.test(da)
chisq.test(da)

#Apriori算法
install.packages("arules")
library(arules)
library(Matrix)
library(lattice)
data("Adult")
myrules = apriori(Adult,parameter=list(supp=0.5,conf=0.9,target="rules"))
myrules[1:10]



#对数线性模型
da1 <- matrix(c(55,45,58,41),2)
da2 <- matrix(c(66,87,85,70),2)
da3 <- matrix(c(66,41,50,39),2)
m <- c(da1,da2,da3)
x <- array(m,c(2,2,3))
#做拟合优度检验分析
loglin(x,list(c(1,2),3))
loglin(x,list(1,2,3))



#基于Ridit分析的变量筛选
library(foreign)
cc <- read.csv("E:/R语言程序编译/非参数统计练习/lx5.csv")
ridit.test <- function(x)
{
  order.num = ncol(x)
  treat.num = nrow(x)
  rowsum = rowSums(x)#0i.
  colsum = colSums(x)#0.i
  total=sum(rowsum)
  N=(colsum/2)[1:order.num]+c(0,(cumsum(colsum))[2:order.num-1])
  ri = N/total#每个顺序类的得分
  #概率矩阵-i水平下第j个顺序类的得分
  p_coni = x/outer(rowsum,rep(1,order.num),"*")
  pi= rowsum/total
  score = as.matrix(p_coni) %*% as.matrix(ri)#每个处理的得分
  confi_inter = matrix(c(score-1/sqrt(3*rowsum),score+1/sqrt(3*rowsum)),byrow=F,ncol=2)
  #不打结
  if (length(rle(sort(ri))$lengths)==length(ri))
  {
    w=(12*total/(total+1))*sum(rowsum*(ri-0.5)^2)
  }
  #打结
  if (length(rle(sort(ri))$lengths)<=length(ri))
  {
    tao=rle(sort(ri))$lengths
    T=1-sum(tao^3-tao)/(order.num^3-order.num)
    w=(12*total/((total+1)*T))*sum(rowsum*(score-0.5)^2)
  }
  pvalue = pchisq(w,treat.num-1,lower.tail = F)
  list(score,confi_inter=confi_inter,W=w,P=pvalue)
}
options(digits = 4)
res = ridit.test(cc)
#绘制图像-置信区间图像中间参照单位取0.5
g = res$confi_inter
plot(0,0,ylim=c(0,1),xlim=c(1,5))
abline(h=0.5)
for (i in 1:nrow(g))
  lines(c(i,i),g[i,],lwd=2)

