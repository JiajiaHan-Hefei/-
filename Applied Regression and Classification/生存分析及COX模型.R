setwd('D://R语言程序编译/应用回归及分类练习')
w=read.csv("uissurv1.csv")
nn=c(3:4,6:8)
for(i in nn) w[,i]=factor(w[,i])
library(survival)
a=Surv(w$time,w$censor)
par(mfrow=c(2,3))
plot(survfit(a~1,conf.int=0.95,conf.type="log"),
     main = "Kaplan-Meier估计在95%置信区间下")

plot(survfit(a~hercoc,w),main = "Heroin/Cocaine Use",lty=1:4)
legend("topright",paste("hercoc=",levels(w$hercoc)),lty=1:4)

plot(survfit(a~ivhx,w),main = "Drug Use",lty=1:3)
legend("topright",paste("ivhx=",levels(w$ivhx)),lty=1:3)

plot(survfit(a~race,w),main = "Race",lty=1:2)
legend("topright",paste("Race=",levels(w$race)),lty=1:2)

plot(survfit(a~treat,w),main = "Treatment",lty=1:2)
legend("topright",paste("treat=",levels(w$treat)),lty=1:2)

plot(survfit(a~site,w),main = "Site",lty=1:2)
legend("topright",paste("site=",levels(w$site)),lty=1:2)

#置信区间
nn=c(3:4,6:8);for(i in nn) w[,i]=factor(w[,i])
a=Surv(w$time,w$censor)
b=confBands(a,confLevel=0.95,type="hall")
plot(survfit(a~1),xlab="Time",ylab="Survival function")
title("Confidence Bands and Pointwise Confidence Intervals")
lines(b$time,b$lower,lty=3,type = "s")
lines(b$time,b$upper,lty=3,type = "s")
legend("topright",c("K-M survival estimate","pointwise intervals","confidence bands"),lty=1:3)

#累计危险函数图
fit=summary(survfit(a~1))
Hh=-log(fit$surv)
Hh=c(Hh,tail(Hh,1))
hs=fit$n.event/fit$n.risk
Hna=cumsum(hs)
Hna=c(Hna,tail(Hna,1))
plot(c(fit$time,800),Hh,type="s",xlab="Time",ylab="Cumulative hazard")
title("Cumulative hazards")
points(c(fit$time,800),Hna,lty=2,type="s")
legend("topleft",c("H-Kaplan-Meier","H-Nelson-Aalen"),lty=1:2)

#估计
print(survfit(a~1),print.rmean = TRUE)
#检验
L=11;J=seq(-2,2,length=L);P=matrix(0,L,5)
for(k in 1:5){
  for(j in 1:L){
    f=formula(paste("a~",names(w)[nn[k]]))
    x2=survdiff(f,w,rho=J[j])$chi
    P[j,k]=1-pchisq(x2,length(levels(w[,nn[k]]))-1)
  }
}
P

#COX回归模型
fit=coxph(a~age+ndrugtx+los+ivhx+hercoc+race+treat+site,w)
summary(fit)
plot(survfit(fit))
library(mfp)
f=mfp(formula=a~fp(age,df=4,select=0.05)+fp(ndrugtx,df=4,select=0.05)+
        fp(los,df=4,select=0.05)+ivhx+hercoc+race+treat+site,data=w,family=cox)
print(f)