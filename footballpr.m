a=dlmread('14bo.csv',',');
b=dlmread('14result.csv','');
c=dlmread('14bo.csv',',');
d=dlmread('14result.csv','');

A=a;
B=b;
C=c;
D=d;
%{
%for shuffling data
dat=a;
lab=b;
n=length(dat);
str=randperm(n);
for i=1:n/2
    A(i)=dat(str(i));
    B(i)=lab(str(i));
end

for i=(1+n/2):n
    C(i)=dat(str(i));
    D(i)=lab(str(i));
end
%}

x=[ones(size(A,1),1),A];
y=(B==1);
options=optimset('GradObj','on','MaxIter',100);
iniTheta=zeros(size(x,2),1);
[optThetaW, functionVal,exitFlog]=fminunc(@(iniTheta)(costFunction(iniTheta,x,y)),iniTheta,options);

y2=((B==-1));
options=optimset('GradObj','on','MaxIter',100);
iniTheta=zeros(size(x,2),1);
[optThetaL, functionVal,exitFlog]=fminunc(@(iniTheta)(costFunction(iniTheta,x,y2)),iniTheta,options);

%predict
C=dlmread('14bo.csv',',');
D=dlmread('14result.csv','');
xx=[ones(size(C,1),1),C];
yy=D;
[accuracyw accyract]=intest(optThetaW,optThetaL,xx,yy)