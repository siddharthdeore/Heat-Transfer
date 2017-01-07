clc
clear all
N=input('Enter no of grids = ')
M=input('Enter no of grids = ')
T=ones(N,M);
T(1,:)=250;
T(N,:)=250;
T(2:N-1,:)=30;
Tn=T
dt=0.1;
L=10/1000;
B=30/1000;
dx=L/(N-1);
dy=B/(M-1);
alpha=0.25/(2000*1300);
ax=alpha*dt/(dx*dx);
ay=alpha*dt/(dy*dy);
X=T;
pos=ceil(N/2);
c1=1000;
step=0;

%for plots and graphs
for i=1:N
    for j=1:M
        p(i,j)=i;
    end
end
p;
q=p';
t=0;
t2=0;
% Main Program
while(Tn(pos,pos)<=140)
    for i=2:N-1
        for j=1:M
            if(j==1) % left boundry values
                x=ax*(T(i+1,j)-2*T(i,j)+T(i-1,j));
                y=ay*(T(i,j+1)-2*T(i,j)+2*dx*c1);
                Tn(i,j)=x+y+T(i,j);
            elseif(j==M) % right boundry values
                x=ax*(T(i+1,j)-2*T(i,j)+T(i-1,j));
                y=ay*(2*dx*c1-2*T(i,j)+T(i,j-1));
                Tn(i,j)=x+y+T(i,j);
            else % central values
                x=ax*(T(i+1,j)-2*T(i,j)+T(i-1,j));
                y=ay*(T(i,j+1)-2*T(i,j)+T(i,j-1));
                Tn(i,j)=x+y+T(i,j);
            end
        end
    end
    t=t+dt;
    if((t-t2) > 1)
        t2=t;
        surf(T,'EdgeColor','none');
        xlabel(num2str(step*dt));
        drawnow;
    end
    
    step=step+1;
    T=Tn;
    
end

xlabel(num2str(step*dt));
t

%contour3(q,p,T,10)
%plot3(q,p,T)
