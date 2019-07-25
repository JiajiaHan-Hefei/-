#Browm-Mood检验程序-中位数检验
BMtest <- function(x,y,alt)
{
  xy <- c(x,y)
  md.xy <- median(xy)
  t <- sum(xy > md.xy)
  lx <- length(x)
  ly <- length(y)
  lxy <- lx + ly
  A <- sum(x > md.xy)
  #计算p值，其中A的分布服从超几何分布
  if(alt == "greater")
  {w <- 1-phyper(A,lx,ly,t)}
  else if(alt == "less")
  {w <- phyper(A,lx,ly,t)}
  #默认按列转成矩阵
  conting.table = matrix(c(A,lx-A,lx,t-A,ly-(t-A),ly,t,lxy-t,lxy),3,3)
  col.name <- c("X","Y","X+Y")
  row.name <- c(">MXY","<MXY","TOTAL")
  dimnames(conting.table) <- list(row.name,col.name)
  list(contingency.table = conting.table,p.value = w)
}

X <- c(698,688,675,656,655,648,640,639,620)
Y <- c(780,754,740,712,693,680,621)
BMtest(X,Y,"less")


#Browm-Mood检验程序-q分位数检验
BMqtest <- function(x,y,q,alt)
{
  xy <- c(x,y)
  q.xy <- quantile(xy,q)
  t <- sum(xy > q.xy)
  lx <- length(x[x!=q.xy])
  ly <- length(y[y!=q.xy])
  lxy <- lx + ly
  A <- sum(x > q.xy)
  #检验统计量的计算
  z = (A-lx*t)/(lx+ly)/(lx*ly*t*(lx+ly-t)/(lx+ly)^3)^0.5
  #正态近似时的标准化统计量
  if(A > (min(lx,t)/2) )
  {
    z1 = (A+0.5-lx*t)/(lx+ly)/(lx*ly*t*(lx+ly-t)/(lx+ly)^3)^0.5
  }
  else
  {
    z1 = (A-0.5-lx*t)/(lx+ly)/(lx*ly*t*(lx+ly-t)/(lx+ly)^3)^0.5
  }
  #计算p值，其中A的分布服从超几何分布
  if(alt == "greater")
  {
    pv1 = 1-phyper(A,lx,ly,t)
    pv2 = 1-pnorm(z)
    pv3 = 1-pnorm(z1)
  }
  else if(alt == "less")
  {
    pv1 = phyper(A,lx,ly,t)
    pv2 = pnorm(z)
    pv3 = pnorm(z1)
  }
  if(alt == "two.side")
  {
    pv1 = 2*min(1-phyper(A,lx,ly,t),phyper(A,lx,ly,t)) 
    pv2 = 2*min(1-pnorm(z),pnorm(z))
    pv3 = 2*min(1-pnorm(z1),pnorm(z1))
  }
  #默认按列转成矩阵
  conting.table = matrix(c(A,lx-A,lx,t-A,ly-(t-A),ly,t,lxy-t,lxy),3,3)
  col.name <- c("X","Y","X+Y")
  row.name <- c(">MqXY","<MqXY","TOTAL")
  dimnames(conting.table) <- list(row.name,col.name)
  list(contingency.table = conting.table,p.value = pv1,pvnorm = pv2,pvnr = pv3)
}

a = c(698,688,675,656,655,648,640,639,620)
b = c(780,754,740,712,693,680,621)
BMqtest(a,b,0.25,"two.side")
BMqtest(a,b,0.75,"two.side")
