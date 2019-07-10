clc,clear
%读取数据
x=load('C:\Users\wjp\Desktop\data1.txt')%时间，货物吞吐量、集装箱（万标准箱）
Y=load('C:\Users\wjp\Desktop\data2.txt')%年度、铁路货运量、水运货物周转量（万吨公里)

%GM（1,1）模型
x0=Y(:,3);
% x0(1)=[];%注意这里为列向量,删除2005年的数据，使用2007年之后的数据

n=length(x0);
lamda=x0(1:n-1)./x0(2:n)  %计算级比
range=minmax(lamda')  %计算级比的范围
x1=cumsum(x0)  %累加运算
B=[-0.5*(x1(1:n-1)+x1(2:n)),ones(n-1,1)];
Y=x0(2:n);
u=B\Y  %拟合参数u(1)=a,u(2)=b
syms x(t)
x=dsolve(diff(x)+u(1)*x==u(2),x(0)==x0(1)); %求微分方程的符号解
xt=vpa(x,6) %以小数格式显示微分方程的解
yuce1=subs(x,t,[0:n-1]); %求已知数据的预测值
yuce1=double(yuce1); %符号数转换成数值类型，否则无法作差分运算
yuce=[x0(1),diff(yuce1)]  %差分运算，还原数据
yuce=round(yuce) %四舍五入取整数
epsilon=x0'-yuce    %计算残差
delta=abs(epsilon./x0')  %计算相对误差
rho=1-(1-0.5*u(1))/(1+0.5*u(1))*lamda'  %计算级比偏差值，u(1)=a


yuce2=subs(x,t,[0:n-1+20]); %求已知数据的预测值
yuce2=double(yuce2); %符号数转换成数值类型，否则无法作差分运算
yuce2=[x0(1),diff(yuce2)]  %差分运算，还原数据
yuce2=round(yuce2) %四舍五入取整数