#计算Boston房价数据中各个变量的中位数
#然后用符号检验以及符号秩检验检验所得到的中位数是否显著
library(MASS)
data(boston)
colnames(boston)=toupper(colnames(boston))#将变量名由小写改为大写，易于区分
tax.median = median(boston$TAX)#TAX的样本中位数
splus=sum(boston$TAX>tax.median)
sminus=sum(boston$TAX<tax.median)
k=min(sminus,splus)
n=splus+sminus
binom.test(k,n,0.5)#符号检验
wilcox.test(boston$TAX-tax.median)#wilcoxon符号秩检验
plot(density(boston$TAX))#显示TAX服从双峰分布
ks.test(boston$TAX,pnorm,mean(boston$TAX),sd(boston$TAX))#Liliefor正态分布检验