%%Code For One Dimention Heat Diffusion Explicit method
clc
clear all
L=10/1000;
B=40/1000;
N=input('Enter Numbber of Grids = ');
M=N*B/L;
dt=0.1;
dx=L/(N-1);
dy=B/(M-1);
alpha=0.25/(2000*1300);
ax=(alpha*dt)/(dx*dx);
ay=(alpha*dt)/(dy*dy);
step=1;
%boumdry Conditions
Tp=ones(N,M)*30; % Row matrix For Previous Time Step

Tp(1,:)=250;
Tp(N,:)=250;
Tp(2:N-1,1)=100;
Tp(2:N-1,M)=100;
Tn=Tp;   % Row matrix For Next Time Step to be calculated
Tp1=Tp;
Tn1=Tn;
Tn(2:N-1,2:M-1)=0;
Tavg=30;
t=0;
t2=0;
%T(i)=(((Tp(i+1)-2*Tp(i)+T(i-1))*(alpha*dt)/(dx*dx))+Tp(i));
X=Tp;
h=imagesc(X);
while Tavg<=140
    Tn=Tn1;
    tempT=Tp1*0;
    error=1;
    while error >=0.00001
        error=0;
        for i=2:N-1
            for j=2:M-1
                tempT(i,j)=Tn(i,j);
                xx=(ax*(Tn(i+1,j) - 2*Tn(i,j) + Tn(i-1,j)));
                yy=(ay*(Tn(i,j+1) - 2*Tn(i,j) + Tn(i,j-1)));
                Tn(i,j) =  xx+yy+ Tp(i,j); %itteration to solve N-2 unknowns from N-2 Equations
                error = error + abs(Tn(i,j) - tempT(i,j));
            end
        end
    end
    Tp=Tn;
    %even odd grid check
%    if mod(N,2)==0
%        Tavg=(Tn(N/2,ceil(M/2))+Tn(N/2,ceil(M/2)))*0.5;
%    else
        Tavg=Tn(ceil(N/2),ceil(M/2));
%    end
    t=t+dt;
    %plot generation is done on each second to improve speed of execution
    if((t-t2) >= 5)
        t2=t;
        %delete(h);
        %        h=imagesc(X);
        h=contourf(Tn);
        xlabel(num2str(step*dt));
        drawnow;
    end
    step=step+1;
end
step*dt
        h=contourf(Tn);
        xlabel(num2str(step*dt));
        drawnow;