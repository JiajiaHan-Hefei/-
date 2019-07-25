#随机游程个数R的精确分布
pruns = function(n,n0,n1)
{
  b=NULL
  a=1:n
  #游程个数的精确分布
  for(i in 1:n)
  {
    if (a[i]%%2==0)
    {
      k=a[i]/2
      b[i]=2*choose(n1-1,k-1)*choose(n0-1,k-1)/choose(n,n1)
    }
    else
    {
      k=(a[i]-1)/2
      b[i]=(choose(n1-1,k-1)*choose(n0-1,k)+choose(n0-1,k-1)*choose(n1-1,k))/choose(n,n1)
    }
  }
  #游程个数的累积概率
  c=NULL
  c[1]=b[1]
  for (i in 2:n)
  {
    c[i] = c[i-1] +b[i]
  }
  result=as.data.frame(cbind(a,b,c))
  colnames(result)=c("k","prob","cumprob")
  return(result)
}

res=pruns(10,4,6)
res
barplot(res[,2],border=F,col="gray1")
#均值
m = sum(res$k*res$prob)
#方差
s = sum((res$k-m)^2*res$prob)
