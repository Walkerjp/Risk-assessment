clc,clear

%��ȡ��Ӧ������ָ����ϵ����
%���ݵ�1-35����ָ��
% ��36��Ϊ��������ҵ�Ƿ񻹿��Լ��������0��ʾ�����ΥԼ����1��ʾ�����Լ����
to=load('to.txt');
%��ԭʼ���ݽ������ɷַ���
data=zscore(to(:,1:35)); %���ݱ�׼��
r=corrcoef(data);  %�������ϵ������
%�����������ϵ������������ɷַ�����vec1����Ϊr�����������������ɷֵ�ϵ��
[vec1,lamda,rate]=pcacov(r) %lamdaΪr������ֵ��rateΪ�������ɷֵĹ�����
contr=cumsum(rate) %�����ۻ�������
f=repmat(sign(sum(vec1)),size(vec1,1),1);%������vec1ͬά����Ԫ��Ϊ��1�ľ���
vec2=vec1.*f  %�޸����������������ţ�ʹ��ÿ�����������ķ�����Ϊ��
num=10;  %numΪѡȡ�����ɷֵĸ���
df=data*vec2(:,1:num);  %����������ɷֵĵ÷�
tf=df*rate(1:num)/100; %�����ۺϵ÷�
[stf,ind]=sort(tf,'descend');  %�ѵ÷ְ��մӸߵ��͵Ĵ�������
stf=stf', ind=ind'
%ȷ�����ɷַ�����������ڽ�����һ��
PCAdata=df
%ʹ��Logistic �ع�ģ�Ͷ���С��ҵ�������÷�������
% ���ݵ�1-35����ָ�꣬��
% ��36��Ϊ��������ҵ�Ƿ񻹿��Լ��������0��ʾ�����ΥԼ����1��ʾ�����Լ����
x=PCAdata(:,1:5);
y=to(:,36);
b =glmfit(x,y,'binomial', 'link', 'logit');%b�ǲ���
p = glmval(b,x, 'logit');%��Ͻ��
p
