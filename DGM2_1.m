%DGM��2,1��ģ��
clc,clear
%��ȡ����
x=load('C:\Users\wjp\Desktop\data1.txt')%ʱ�䣬��������������װ�䣨���׼�䣩
Y=load('C:\Users\wjp\Desktop\data2.txt')%��ȡ���·��������ˮ�˻�����ת������ֹ���)
x0=x(:,3)';
x0(1)=[];%ע������Ϊ������,ɾ��2005������ݣ�ʹ��2007��֮�������
n=length(x0);
a_x0=diff(x0)';  %��1���ۼ����У���1����ǰ���
B=[-x0(2:end)',ones(n-1,1)]; 
u=B\a_x0  %��С���˷���ϲ���
syms x(t)
d2x=diff(x,2); dx=diff(x); %����һ�׵�������Ϊ�����渳��ֵ
x=dsolve(d2x+u(1)*dx==u(2),x(0)==x0(1),dx(0)==x0(1));  %�����΢�ַ��̷��Ž�
xt=vpa(x,6) %��ʾС����ʽ�ķ��Ž�
yuce=subs(x,'t',0:n-1+20); %����֪���ݵ�1���ۼ����е�Ԥ��ֵ
yuce=double(yuce) %������ת������ֵ���ͣ������޷����������
x0_hat=[yuce(1),diff(yuce)] %����֪���ݵ��Ԥ��ֵ
x0_hat=round(x0_hat) %��������ȡ����
% epsilon=x0-x0_hat %��в�
% delta=abs(epsilon./x0)  %��������
