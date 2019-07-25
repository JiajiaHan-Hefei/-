# -*- coding: utf-8 -*-
"""
Created on Wed Jan 23 22:15:21 2019

@author: 师傅是徒儿
"""

#from turtle import *
import turtle as t

def nose(x,y):#鼻子
    t.pu()#抬笔
    t.goto(x,y)#从当前位置开始
    t.pd()#落笔
    t.seth(-30)#逆时针旋转
    t.begin_fill()#准备开始填充图形
    a=0.4
    for i in range(120):
        if 0<=i<30 or 60<=i<90:
            a=a+0.08
            t.lt(3) #向左转3度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.08
            t.lt(3)
            t.fd(a)
    t.end_fill()#填充完成

    t.pu()
    t.seth(90)
    t.fd(25)#前进
    t.seth(0)
    t.fd(10)
    t.pd()
    t.pencolor(255,155,192)#设置画笔颜色
    t.seth(10)
    t.begin_fill()
    t.circle(5)#画圆
    t.color(160,82,45)#同时设置pencolor和fillcolor
    t.end_fill()

    t.pu()
    t.seth(0)
    t.fd(20)
    t.pd()
    t.pencolor(255,155,192)
    t.seth(10)
    t.begin_fill()
    t.circle(5)
    t.color(160,82,45)
    t.end_fill()

def head(x,y):#头
    t.color((255,155,192),"pink")
    t.pu()
    t.goto(x,y)
    t.seth(0)
    t.pd()
    t.begin_fill()
    t.seth(180)
    t.circle(300,-30)
    t.circle(100,-60)
    t.circle(80,-100)
    t.circle(150,-20)
    t.circle(60,-95)
    t.seth(161)
    t.circle(-300,15)
    t.pu()
    t.goto(-100,100)
    t.pd()
    t.seth(-30)
    a=0.4
    for i in range(60):
        if 0<=i<30 or 60<=i<90:
            a=a+0.08
            t.lt(3) #向左转3度
            t.fd(a) #向前走a的步长
        else:
            a=a-0.08
            t.lt(3)
            t.fd(a)
    t.end_fill()

def ears(x,y): #耳朵
    t.color((255,155,192),"pink")
    t.pu()
    t.goto(x,y)
    t.pd()
    t.begin_fill()
    t.seth(100)
    t.circle(-50,50)
    t.circle(-10,120)
    t.circle(-50,54)
    t.end_fill()

    t.pu()
    t.seth(90)
    t.fd(-12)
    t.seth(0)
    t.fd(30)
    t.pd()
    t.begin_fill()
    t.seth(100)
    t.circle(-50,50)
    t.circle(-10,120)
    t.circle(-50,56)
    t.end_fill()

def eyes(x,y):#眼睛
    t.color((255,155,192),"white")
    t.pu()
    t.seth(90)
    t.fd(-20)
    t.seth(0)
    t.fd(-95)
    t.pd()
    t.begin_fill()
    t.circle(15)
    t.end_fill()

    t.color("black")
    t.pu()
    t.seth(90)
    t.fd(12)
    t.seth(0)
    t.fd(-3)
    t.pd()
    t.begin_fill()
    t.circle(3)
    t.end_fill()

    t.color((255,155,192),"white")
    t.pu()
    t.seth(90)
    t.fd(-25)
    t.seth(0)
    t.fd(40)
    t.pd()
    t.begin_fill()
    t.circle(15)
    t.end_fill()

    t.color("black")
    t.pu()
    t.seth(90)
    t.fd(12)
    t.seth(0)
    t.fd(-3)
    t.pd()
    t.begin_fill()
    t.circle(3)
    t.end_fill()

def cheek(x,y):#腮
    t.color((255,155,192))
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(0)
    t.begin_fill()
    t.circle(30)
    t.end_fill()

def mouth(x,y): #嘴
    t.color(239,69,19)
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(-80)
    t.circle(30,40)
    t.circle(40,80)

def body(x,y):#身体
    t.color("red",(255,99,71))
    t.pu()
    t.goto(x,y)
    t.pd()
    t.begin_fill()
    t.seth(-130)
    t.circle(100,10)
    t.circle(300,30)
    t.seth(0)
    t.fd(230)
    t.seth(90)
    t.circle(300,30)
    t.circle(100,3)
    t.color((255,155,192),(255,100,100))
    t.seth(-135)
    t.circle(-80,63)
    t.circle(-150,24)
    t.end_fill()

def hands(x,y):#手
    t.color((255,155,192))
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(-160)
    t.circle(300,15)
    t.pu()
    t.seth(90)
    t.fd(15)
    t.seth(0)
    t.fd(0)
    t.pd()
    t.seth(-10)
    t.circle(-20,90)

    t.pu()
    t.seth(90)
    t.fd(30)
    t.seth(0)
    t.fd(237)
    t.pd()
    t.seth(-20)
    t.circle(-300,15)
    t.pu()
    t.seth(90)
    t.fd(20)
    t.seth(0)
    t.fd(0)
    t.pd()
    t.seth(-170)
    t.circle(20,90)

def foot(x,y):#脚
    t.pensize(10)
    t.color((240,128,128))
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(-90)
    t.fd(40)
    t.seth(-180)
    t.color("black")
    t.pensize(15)
    t.fd(20)

    t.pensize(10)
    t.color((240,128,128))
    t.pu()
    t.seth(90)
    t.fd(40)
    t.seth(0)
    t.fd(90)
    t.pd()
    t.seth(-90)
    t.fd(40)
    t.seth(-180)
    t.color("black")
    t.pensize(15)
    t.fd(20)

def tail(x,y):#尾巴
    t.pensize(4)
    t.color((255,155,192))
    t.pu()
    t.goto(x,y)
    t.pd()
    t.seth(0)
    t.circle(70,20)
    t.circle(10,330)
    t.circle(70,30)

def setting():          #参数设置
    t.pensize(4)
    t.hideturtle()
    t.colormode(255)
    t.color((255,155,192),"pink")
    t.setup(840,500)
    t.speed(10)

def main():
    setting()           #画布、画笔设置
    nose(-100,100)      #鼻子
    head(-69,167)       #头
    ears(0,160)         #耳朵
    eyes(0,140)         #眼睛
    cheek(80,10)        #腮
    mouth(-20,30)       #嘴
    body(-32,-8)        #身体
    hands(-56,-45)      #手
    foot(2,-177)        #脚
    tail(148,-155)      #尾巴
    t.done()              #结束

main()