%%Code For One Dimention Heat Diffusion Explicit method

clc
clear all
N=input('Enter Numbber of Grids = ');
dt=0.01;
L=10/1000;
dx=L/(N-1);
alpha=0.25/(2000*1300);
step=1;
time=0;
x=1:1:N;
%boumdry Conditions
for i=1:N
    Tp(i)=30; % Row matrix For Previous Time Step
end
Tp(1)=250;
Tp(N)=250;
Tp
T=Tp; % Row matrix For Next Time Step to be calculated
Tavg=30;
p_time=0;
X=T;
col=0:1:250;
 figure;
 %hold on;
 h_old=plot(0,0);
while(Tavg<=140) % itterate until cetral temp < 140
    for i=2:N-1
        T(i)=(((Tp(i+1)-2*Tp(i)+Tp(i-1))*(alpha*dt)/(dx*dx))+Tp(i));
       % pause(0.1);
        Tp=T;
    end
    
    step=step+1;
    if(mod(N,2)==0)
        Tavg=(T(N/2)+T(N/2+1))/2;
        
    else
        Tavg=T(ceil(N/2));
    end
    X=[X;T];
    time=dt*step;

    if((time-p_time)>=1)  
        %h=plot(T,'-');
%        h=contourf(X);
        %h=imagesc(X);
        h=imagesc(T);
        drawnow;
        %colormap(hot);
        %colorbar;
        %axis([1 N 0 250]);
        %grid;
%        caxis([0,250])
        %temptext = ['Time = ',num2str(dt*step),' sec'];
        %xlabel(temptext) % y-axis label    delete(h_old);
        %h_old=h;
        %drawnow;
    p_time=time;
    end
    X(1,:)=[];
end
%clabel('manual')
%Results
step % Number of steps
time=step*dt  % Time Requred in seconds
%T

%figure
%plot(x,T,'-*');
%title('Time 1-D Heat Conduction');
%xlabel('dx');
%ylabel('Temprature - Deg celcious');