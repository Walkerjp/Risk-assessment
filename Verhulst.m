%DGM��2,1��ģ��
clc,clear
%��ȡ����
x=load('C:\Users\wjp\Desktop\data1.txt')%ʱ�䣬��������������װ�䣨���׼�䣩
Y=load('C:\Users\wjp\Desktop\data2.txt')%��ȡ���·��������ˮ�˻�����ת������ֹ���)
x0=Y(:,3)';
% x0(1)=[];%ע������Ϊ������,ɾ��2005������ݣ�ʹ��2007��֮�������
x1=cumsum(x0);  %��1���ۼ�����
n=length(x0);
z=0.5*(x1(2:n)+x1(1:n-1));   %��x1�ľ�ֵ��������
B=[-z',z'.^2];
Y=x0(2:end)';
u=B\Y     %���Ʋ���a,b��ֵ
syms x(t)
x=dsolve(diff(x)+u(1)*x==u(2)*x^2,x(0)==x0(1));  %����Ž�
xt=vpa(x,6) %��ʾС����ʽ�ķ��Ž�
yuce=subs(x,'t',[0:n-1+20]); %����֪���ݵ�1���ۼ����е�Ԥ��ֵ
yuce=double(yuce) %������ת������ֵ���ͣ������޷����������
x0_hat=[yuce(1),diff(yuce)] %����֪���ݵ��Ԥ��ֵ
x0_hat=round(x0_hat) %��������ȡ����
% epsilon=x0-x0_hat    %��в�
% delta=abs(epsilon./x0)  %��������
% xlswrite('book4.xls',[x0',x0_hat',epsilon',delta'])
