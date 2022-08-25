%computing the viab kernel by numerical approach
tic
tspan= 0:0.1:30;
%%{
hold all
x1=0;x2=-6;
while x1<12
    x2=-6;
    while x2<6
        [t,y1] = ode45(@vdp_Car,tspan,[x1;x2]);
        [t,y2] = ode45(@vdp_Car,tspan,[x1;x2+1]);
        [t,y3] = ode45(@vdp_Car,tspan,[x1+1;x2]);
        [t,y4] = ode45(@vdp_Car,tspan,[x1+1;x2+1]);
        A1=(0>y1(:,1)); B1=(y1(:,1)>12);
        A2=(0>y2(:,1)); B2=(y2(:,1)>12);
        A3=(0>y3(:,1)); B3=(y3(:,1)>12);
        A4=(0>y4(:,1)); B4=(y4(:,1)>12);
        if A1+B1+A2+B2+A3+B3+A4+B4==0
            bool=true;m=10*x1+1;
            for i=x1:0.1:x1+1
                n=10*(x2+6)+1;
                for j=x2:0.1:x2+1
                    plot(i,j,'*',"Color",'g');
                    table(m,n)=bool;
                    n=n+1;
                end
                m=m+1;
            end
        elseif ((A1+B1~=0)&(A2+B2~=0)&(A3+B3~=0)&(A4+B4~=0))
            bool=false;m=10*x1+1;
            for i=x1:0.1:x1+1
                n=10*(x2+6)+1;
                for j=x2:0.1:x2+1
                    plot(i,j,'*',"Color",'r');
                    table(m,n)=bool;
                    n=n+1;
                end
                m=m+1;
            end
        else
            m=10*x1+1;
            for i=x1:0.1:x1+1
                n=10*(x2+6)+1;
                for j=x2:0.1:x2+1
                    [t,y] = ode45(@vdp_Car,tspan,[i;j]);
                    A=(0>y(:,1)); B=(y(:,1)>12);
                    bool=false;
                    if A+B==0
                        bool=true;
                        plot(i,j,'*',"Color",'g');
                    else
                        plot(i,j,'*',"Color",'r');
                    end
                    table(m,n)=bool;
                    n=n+1;
                end
                m=m+1;
            end
        end
        x2=x2+1;
    end
    x1=x1+1;
end
%table
plot(13,0,'*',"Color",'r')
hold off


s_dot=-6:0.1:6;
for i=1:length(table(1,:))
    a=find(table(:,i)==1,1,"first");
    s_dot1(i)=s_dot(a);
    b=find(table(:,i)==1,1,"last");
    s_dot2(i)=s_dot(b);
end

s=0:0.1:12;
figure
hold all
plot(s,s_dot1)
plot(s,s_dot2)
patch([s fliplr(s)], [s_dot1 fliplr(s_dot2)], 'g')
hold off

%[t,y] = ode45(@vdp_Car,tspan,[2.35;-4]);
toc

%%
function dydt = vdp_Car(t,y)
dydt = [y(2); -9.81*sin(0.55*sin(1.2*y(1))-0.6*sin(1.1*y(1)))-0.7*y(2)];
end