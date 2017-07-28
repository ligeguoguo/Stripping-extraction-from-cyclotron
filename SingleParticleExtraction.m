
a=load('./O 65AMeV MEASURED.mat');

Bz=a.BZMES(1:120,:)*1E3;

for i=1:1:2
    Bz(i*120+1:i*120+120,:)=Bz(1:120,:);
end
Bz(361,:)=Bz(1,:);
Bz=flipud(Bz);

[R,PHI]=meshgrid(0.01:0.01:2.35,-pi:2*pi/360:pi); 
px=R.*cos(PHI);
py=R.*sin(PHI);

[Gr,Ga]=gradient(Bz);
Ga=Ga/2*pi/360./R;
Gr=Gr/0.01;
Gx=Gr.*cos(PHI)-Ga.*sin(PHI);
Gy=Gr.*sin(PHI)+Ga.*cos(PHI);

AQI=AI/QI;
AQT=AT/QT;
e0=1.60218e-19;
m0=1.67262171e-27;
m=gama*m0;
v=sqrt(1-(1/gama)^2)*0.299792458;
a=e0/m/1e9/AQI;
at=e0/m/1e9/AQT;
Ed=0;

r0=-0.9;
vr=0;
theta=0;
options=odeset('reltol',1e-7);

for i=1:100    
y0=[r0
    v*sin(theta)
    0
    v*cos(theta)
    ];
tspan=[0:0.002:55];
[t0,y]=ode45('f',tspan,y0,options,Bz/1e4,R,PHI,a);
qua=find(abs(y(:,3))==min(abs(y(20000:end,3))));
if((abs(y(qua,1)-r0))/(-r0)<1/20000 && abs(atan(y(qua,4)/((-y(qua,2)))-theta))<1/40000)
    break;
else
    r0=(r0+y(qua,1))/2
    theta=(atan(y(qua,2)/(y(qua,4)))+theta)/2
end
end
y0=y(1,:);
tspan=[0:0.005:80];
[t0,y]=ode45('f',tspan,y0,options,Bz/1e4,R,PHI,a);

[OT,OR]=cart2pol(y(1:10000,1),y(1:10000,3));
OT=(-OT+pi)/pi*180;

y0=y(find(abs((OT(:)-88))<0.005),:);
tspan=[0:0.005:80];
[t0,y]=ode45('f',tspan,y0,options,Bz/1e4,R,PHI,at);

s_orbit=y(1:10000,:);
[Theta0,R0]=cart2pol(s_orbit(2:10000,1),s_orbit(2:10000,3));
start=zeros(9,6);
start(1,1:4)=y0;
start(1,5)=0;
start(1,6)=0;

mcall=zeros(361,235);