#利用二项分布做正态修正
f = function(n,p)
{
  x = c(1,2)
  a = b = d =c()
  for (i in 1:2)
  {
    a[i] = pbinom(x[i],size=n,prob=p)
    b[i] = pnorm(x[i],mean=n*p,sd=sqrt(n*p*(1-p)))#正态近似
    d[i] = pnorm(x[i],mean=(n*p+0.5),sd=sqrt(n*p*(1-p)))#正态修正
  }
  x2 = rbind(a,b,d)
  #dinames(x2) = list(c("B(30,0.4)","N(12,7.2)","N(12.5,7.2)"),c("1","2"))
  print(x2)
}

