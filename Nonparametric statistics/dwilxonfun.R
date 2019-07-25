#计算wilcoxon符号秩和检验W+分布密度函数
dwilxonfun = function(N)
{
  a = c(1,1);
  n=1
  pp = aa = NULL
  for (i in 2:N)
  {
    t = c(rep(0,i),a)
    a = c(a,rep(0,i))+t
    p = a/(2^i)
  }
  p
}
N = 19
