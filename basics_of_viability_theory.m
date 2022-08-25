tic
tspan= 0:0.1:30;
%%{
hold all
bool=false;
m=1;
for i=0:0.1:12
    n=1;
    for j=-6:0.1:6
        bool=false;
        [t,y] = ode45(@vdp_Car,tspan,[i;j]);
        A=(0>y(:,1)); B=(y(:,1)>12);
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
%%}
%[t,y] = ode45(@vdp_Car,tspan,[2.35;-4]);
toc

%%
function dydt = vdp_Car(t,y)
dydt = [y(2); -9.81*sin(0.55*sin(1.2*y(1))-0.6*sin(1.1*y(1)))-0.7*y(2)];
end