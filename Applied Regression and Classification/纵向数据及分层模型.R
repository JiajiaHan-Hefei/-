html="http://faculty.washington.edu/heagerty/Books/AnalysisLongitudnal/milk.data"
w=read.table("html")
library(nlme)
a=lme(protein~week+diet,random=~week+diet|id,w,method = "ML")
summary(a)

b=lme(protein~diet,random = ~diet|id,w,method = "ML")
anova(b,a)







html="http://archive.ics.uci.edu/ml/datasets/Parknsons+Telemonitoring"
w=read.table("html")
library(lme4)
n=nrow(w)
w[,c(1,3,5)]=scale(w[,-c(1,3,5)])
ff=total.UPDRS~age+DFA+HNR+sex+Jitter+PPE+test.time+Shimmer.APQ3+Jitter.abs+RPDE+NHR+Shimmer.APQ11+(age+DFA|subject)
a=lmer(ff,data=w)
summary(a)
###################
ff1=~DFA|subject
library(REEMtree)
a=REEMtree(ff,data=w,random=ff1)
print(a)
plot(a)




setwd('D://R语言程序编译/应用回归及分类练习')
w=read.csv("seizures.csv")
library(lme4)
g=glmer(counts~time_1+time_2+time_3+time_4+treat+counts+age+(age|id),w,family = poisson)
summary(g)





html="http://faculty.washington.edu/heagerty/Books/AnalysisLongitudnal/madras.data"
w=read.table("html")
library(lme4)
g=glmer(y~month*age+gender(1|id),w,family = binomial)
summary(g)

