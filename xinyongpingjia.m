clc,clear

%读取供应链金融指标体系数据
%数据的1-35列是指标
% 第36列为若融资企业是否还款（履约），例如0表示不还款（违约），1表示还款（履约）。
to=load('to.txt');
%对原始数据进行主成分分析
data=zscore(to(:,1:35)); %数据标准化
r=corrcoef(data);  %计算相关系数矩阵
%下面利用相关系数矩阵进行主成分分析，vec1的列为r的特征向量，即主成分的系数
[vec1,lamda,rate]=pcacov(r) %lamda为r的特征值，rate为各个主成分的贡献率
contr=cumsum(rate) %计算累积贡献率
f=repmat(sign(sum(vec1)),size(vec1,1),1);%构造与vec1同维数的元素为±1的矩阵
vec2=vec1.*f  %修改特征向量的正负号，使得每个特征向量的分量和为正
num=10;  %num为选取的主成分的个数
df=data*vec2(:,1:num);  %计算各个主成分的得分
tf=df*rate(1:num)/100; %计算综合得分
[stf,ind]=sort(tf,'descend');  %把得分按照从高到低的次序排列
stf=stf', ind=ind'
%确认主成分分析结果可用于进行下一步
PCAdata=df
%使用Logistic 回归模型对中小企业进行信用风险评价
% 数据的1-35列是指标，，
% 第36列为若融资企业是否还款（履约），例如0表示不还款（违约），1表示还款（履约）。
x=PCAdata(:,1:5);
y=to(:,36);
b =glmfit(x,y,'binomial', 'link', 'logit');%b是参数
p = glmval(b,x, 'logit');%拟合结果
p

