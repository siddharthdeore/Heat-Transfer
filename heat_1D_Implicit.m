%%Code For One Dimention Heat Diffusion Explicit method
clc
clear all
N=input('Enter Numbber of Grids = ');
dt=0.1;
L=10/1000;
dx=L/(N-1);
alpha=0.25/(2000*1300);
kapa=(alpha*dt)/(dx*dx);
step=1;
x=1:1:N;
%boumdry Conditions
for i=1:N
    Tp(i)=30; % Row matrix For Previous Time Step
end
Tp(1)=250;
Tp(N)=250;
Tn=Tp;   % Row matrix For Next Time Step to be calculated
Tn(2:N-1)=0;
Tavg=30;
t=0;
t2=0;
%T(i)=(((Tp(i+1)-2*Tp(i)+T(i-1))*(alpha*dt)/(dx*dx))+Tp(i));
X=Tp;
h=imagesc(X);
while Tavg<=140
    Tn=Tp*0;
    tempT=Tp*0;
    Tn(1)=250;
    Tn(N)=250;
    error=1;
    while error >=0.1
        error=0;
        for i=2:N-1
            tempT(i)=Tn(i);
            Tn(i) = (kapa*(Tn(i+1) - 2*Tn(i) + Tn(i-1))) + Tp(i); %itteration to solve N-2 unknowns from N-2 Equations
            error = error + abs(Tn(i) - tempT(i));
        end
    end
    Tp=Tn;
    %even odd grid check
    if mod(N,2)==0
        Tavg=(Tn(N/2)+Tn(N/2))*0.5;
    else
        Tavg=Tn(ceil(N/2));
    end
    t=t+dt;
    %plot generation is done on each second to improve speed of execution 
    if((t-t2) >= 5)
        X=[X;Tn];
        t2=t;
        %delete(h);
%        h=imagesc(X);
        h=contourf(X);
        xlabel(num2str(step*dt));
        drawnow;
    end
    step=step+1;
end
step*dt