# -*- coding: utf-8 -*-
"""
Created on Thu Jan 24 14:30:13 2019

@author: 师傅是徒儿
"""
import turtle as t


def body(x,y):
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(-90)
    t.begin_fill()
    t.fd(200)
    a=0.4
    for i in range(90):
        if 0<=i<45:
            a=a+0.08
            t.lt(2) #向左转2度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.08
            t.lt(2)
            t.fd(a)

    t.fd(200)
    a=0.4
    for i in range(178):
        if 0<=i<20 or 45<=i<80 or 110<i<135 or 160<=i<180:
            a=a+0.08
            t.lt(1) #向左转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.08
            t.lt(1)
            t.fd(a)
    t.color(240,222,76)
    t.end_fill()#填充完成



def eyes(x,y):#眼睛
    t.pensize(4)
    t.color((0,0,0),"white")
    t.pu()
    t.goto(x,y)
    t.seth(90)
    t.fd(-20)
    t.pd()
    t.begin_fill()
    t.circle(25)
    t.end_fill()#填充完成
    
    t.pu()
    t.seth(-50)
    t.fd(15)
    t.pd()
    t.begin_fill()
    t.circle(25)
    t.end_fill()#填充完成
    
    t.color("black")
    t.pu()
    t.seth(-10)
    t.fd(-30)
    t.pd()
    t.begin_fill()
    t.circle(10)
    t.end_fill()
    
    t.color("black")
    t.pu()
    t.seth(0)
    t.fd(40)
    t.pd()
    t.begin_fill()
    t.circle(10)
    t.end_fill()

def bangdai(x,y):
    t.pensize(4)
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(0)
    t.fd(28)
    
    t.pu()
    t.goto(x,y-20)
    t.pd()
    t.seth(0)
    t.fd(29)
    
    t.pu()
    t.goto(x+127,y)
    t.pd()
    t.seth(0)
    t.fd(28)
    
    t.pu()
    t.goto(x+122,y-20)
    t.pd()
    t.seth(0)
    t.fd(29)

def hair(x,y):
    t.pensize(2)
    #第一根头发
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(90)
    #t.begin_fill()
    a=0.2
    for i in range(60):
        if 0<=i<40:
            a=a+0.05
            t.rt(2) #向左转2度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.rt(1)
            t.fd(a)
    #t.end_fill()#填充完成

    #第二根头发    
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(90)
    #t.begin_fill()
    a=0.2
    for i in range(60):
        if 0<=i<30:
            a=a+0.05
            t.rt(3) #向左转2度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.rt(2)
            t.fd(a)
    #t.end_fill()#填充完成
    
    #第三根头发
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(90)
    #t.begin_fill()
    a=0.1
    for i in range(60):
        if 0<=i<30:
            a=a+0.05
            t.lt(2) #向左转2度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(2)
            t.fd(a)
    
    #第四根头发
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(90)
    #t.begin_fill()
    a=0.1
    for i in range(60):
        if 0<=i<30:
            a=a+0.05
            t.lt(3) #向左转3度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(2)
            t.fd(a)


def mouth(x,y):
    t.pensize(4)
    t.color((0,0,0),"white")
    #下嘴唇
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(-90)
    t.begin_fill()
    a=0.1
    for i in range(50):
        if 0<=i<30:
            a=a+0.05
            t.lt(4) #向左转4度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(3)
            t.fd(a)        
    #上嘴唇
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(20)
    t.fd(35)
    t.end_fill()#填充完成
    
def dress(x,y):
    t.pensize(4)
    t.pu()
    t.goto(x,y)
    t.pd()
    t.begin_fill()
    t.seth(0)
    t.fd(30)
    t.seth(90)
    t.fd(45)
    t.seth(0)
    t.fd(95)
    t.seth(-90)
    t.fd(45)
    t.seth(0)
    t.fd(30)
    t.seth(-90)
    t.fd(65)
    a=0.4
    for i in range(90):
        if 0<=i<45:
            a=a+0.08
            t.rt(2) #向右转2度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.08
            t.rt(2)
            t.fd(a)
    t.fd(65)
    t.color(37,141,178)
    t.end_fill()

def kudai(x,y): 
    t.pensize(2)
    t.color((0,0,0),"black")
    #左带    
    t.pu()
    t.goto(0,y)
    t.pd()
    t.begin_fill()
    t.seth(-30)
    t.fd(40)
    t.seth(45)
    t.fd(13)
    t.seth(150)
    t.fd(50)
    t.seth(-90)
    t.fd(20)
    t.color((37,141,178))
    t.end_fill()
    
    t.color((0,0,0),"black")   
    #右带
    t.pu()
    t.goto(150,y+12)
    t.pd()
    t.begin_fill()
    t.seth(210)
    t.fd(48)
    t.seth(-45)
    t.fd(13)
    t.seth(30)
    t.fd(40)
    t.seth(90)
    t.fd(18)
    t.color((37,141,178))
    t.end_fill()
    
    #左扣
    t.color("black")
    t.pu()
    t.goto(x,y-7)
    t.seth(90)
    t.pd()
    t.begin_fill()
    t.circle(3)
    t.end_fill()
    
    #右扣
    t.color("black")
    t.pu()
    t.goto(x+95,y-10)
    t.seth(90)
    t.pd()
    t.begin_fill()
    t.circle(3)
    t.end_fill()
    
    
def kuzi(x,y):
    t.color((0,0,0),"black")
    t.pensize(4)
    #口袋
    t.pu()
    t.goto(x+30,y-30)
    t.pd()
    t.seth(0)
    t.fd(35)
    t.pu()
    t.goto(x+30,y-30)
    t.pd()
    t.seth(-90)
    t.fd(24)
    a=0.01
    for i in range(60):
        if 0<=i<30:
            a=a+0.05
            t.lt(3) #向左转3度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(3)
            t.fd(a)
    t.seth(90)
    t.fd(25)
    
    #裤子
    t.pensize(2)
    t.pu()
    t.goto(x+50,y-120)
    t.pd()
    t.seth(-90)
    t.fd(35)
    
    t.pu()
    t.goto(5,y-120)
    t.pd()
    t.seth(0)
    a=0.01
    for i in range(40):
      a=a+0.05
      t.lt(2) #向左转2度
      t.fd(a) #向前走a的步长
    
    t.pu()
    t.goto(150,y-120)
    t.pd()
    t.seth(-180)
    a=0.01
    for i in range(40):
      a=a+0.05
      t.rt(2) #向右转2度
      t.fd(a) #向前走a的步长
        

    
def hand(x,y):
    t.pensize(4)
    #第一个手
    t.color((0,0,0),"black")
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(180)
    t.begin_fill()
    a=0.2
    for i in range(80):
        if 0<=i<40:
            a=a+0.05
            t.lt(2) #向左转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(4)
            t.fd(a)
    t.seth(90)
    t.fd(160)
    t.color(240,222,76)
    t.end_fill()#填充完成  
    
    t.color((0,0,0),"black")
    t.pu()
    t.goto(x,y-20)
    t.pd()
    t.begin_fill()
    t.seth(180)
    a=0.1
    for i in range(40):
        if 0<=i<18:
            a=a+0.05
            t.lt(5) #向左转5度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(3)
            t.fd(a)
    t.seth(90)
    t.fd(15)      
    t.color(0,0,0)
    t.end_fill()#填充完成       

    
    #第二个手
    t.color((0,0,0),"black")
    t.pu()
    t.goto(x+155,y)
    t.pd()
    t.begin_fill()
    t.seth(0)
    a=0.2
    for i in range(80):
        if 0<=i<40:
            a=a+0.05
            t.rt(2) #向右转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.rt(4)
            t.fd(a)
    t.seth(90)
    t.fd(60)
    t.color(240,222,76)
    t.end_fill()#填充完成 
    
    t.color((0,0,0),"black")
    t.pu()
    t.goto(x+155,y-20)
    t.pd()
    t.begin_fill()
    t.seth(0)
    a=0.1
    for i in range(40):
        if 0<=i<18:
            a=a+0.05
            t.rt(5) #向右转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.rt(3)
            t.fd(a)
    t.seth(90)
    t.fd(15)
    t.color(0,0,0)
    t.end_fill()#填充完成
    
def feet(x,y):
    t.pensize(4)
    t.color((0,0,0),"black")#填充完成
    #第一只脚
    t.pu()
    t.goto(x,y)
    t.pd()
    t.begin_fill()
    t.seth(-90)
    t.fd(35)
    t.seth(-180)
    t.fd(50)
    t.seth(90)
    t.fd(10)
    a=0.1
    for i in range(30):
        if 0<=i<15:
            a=a+0.05
            t.rt(3) #向右转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.rt(3)
            t.fd(a)
    t.fd(15)
    t.seth(90)
    t.fd(20)
    
    #第二只脚
    t.pu()
    t.goto(x+10,y)
    t.pd()
    t.seth(-90)
    t.fd(35)
    t.seth(0)
    t.fd(50)
    t.seth(90)
    t.fd(10)
    a=0.1
    for i in range(30):
        if 0<=i<15:
            a=a+0.05
            t.lt(3) #向左转1度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.05
            t.lt(3)
            t.fd(a)
    t.fd(15)
    t.seth(90)
    t.fd(20)
    t.end_fill()

#参数设置    
def setting():
    t.pensize(4)#笔的硬度
    t.hideturtle()#隐藏箭头
    t.colormode(255)#控制颜色体系
    t.color((0,0,0),"black")
    t.setup(840,500)
    t.speed(10)
      
def main():
    setting()#参数设置
    body(0,100)#身体轮廓
    eyes(75,100)#眼睛
    bangdai(0,90)
    mouth(75,30)
    hair(80,150)
    dress(0,-35)
    kudai(30,5)
    kuzi(30,5)
    hand(0,5)
    feet(75,-150)
    t.done()

main()

    
    