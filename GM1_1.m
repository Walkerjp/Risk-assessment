clc,clear
%��ȡ����
x=load('C:\Users\wjp\Desktop\data1.txt')%ʱ�䣬��������������װ�䣨���׼�䣩
Y=load('C:\Users\wjp\Desktop\data2.txt')%��ȡ���·��������ˮ�˻�����ת������ֹ���)

%GM��1,1��ģ��
x0=Y(:,3);
% x0(1)=[];%ע������Ϊ������,ɾ��2005������ݣ�ʹ��2007��֮�������

n=length(x0);
lamda=x0(1:n-1)./x0(2:n)  %���㼶��
range=minmax(lamda')  %���㼶�ȵķ�Χ
x1=cumsum(x0)  %�ۼ�����
B=[-0.5*(x1(1:n-1)+x1(2:n)),ones(n-1,1)];
Y=x0(2:n);
u=B\Y  %��ϲ���u(1)=a,u(2)=b
syms x(t)
x=dsolve(diff(x)+u(1)*x==u(2),x(0)==x0(1)); %��΢�ַ��̵ķ��Ž�
xt=vpa(x,6) %��С����ʽ��ʾ΢�ַ��̵Ľ�
yuce1=subs(x,t,[0:n-1]); %����֪���ݵ�Ԥ��ֵ
yuce1=double(yuce1); %������ת������ֵ���ͣ������޷����������
yuce=[x0(1),diff(yuce1)]  %������㣬��ԭ����
yuce=round(yuce) %��������ȡ����
epsilon=x0'-yuce    %����в�
delta=abs(epsilon./x0')  %����������
rho=1-(1-0.5*u(1))/(1+0.5*u(1))*lamda'  %���㼶��ƫ��ֵ��u(1)=a


yuce2=subs(x,t,[0:n-1+20]); %����֪���ݵ�Ԥ��ֵ
yuce2=double(yuce2); %������ת������ֵ���ͣ������޷����������
yuce2=[x0(1),diff(yuce2)]  %������㣬��ԭ����
yuce2=round(yuce2) %��������ȡ����