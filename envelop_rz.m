AQI=17.9992/6;
AQT=17.9992/8;
E=65;
gama=(E+938.27203)/938.27203;
e0=1.60218e-19;
m0=1.67262171e-27;
m=gama*m0;
v=sqrt(1-(1/gama)^2)*0.299792458;
a=e0/m/1e9/AQI;
at=e0/m/1e9/AQT;
Ed=0;

[R,PHI]=meshgrid(0.01:0.01:2.35,-pi:2*pi/360:pi); 
[Gr,Ga]=gradient(Bz);
Ga=Ga/2*pi/360./R;
Gr=Gr/0.01;
Gx=Gr.*cos(PHI)-Ga.*sin(PHI);
Gy=Gr.*sin(PHI)+Ga.*cos(PHI);


phasetheta=[0:1:7]*0.7854;
phasegama=(alphar^2+1)/betar;
phasephi=atan(1/alphar);
[ttemp,rtemp]=cart2pol(start(1,1),start(1,3));
zstart=sqrt(emmitdefr*betar)*cos(phasetheta)/10+100*rtemp;
tstart=sqrt(emmitdefr*phasegama)*cos(phasetheta+phasephi)+1000*atan(start(1,2)/(start(1,4)));

start(2:end,1)=zstart/100*cos(ttemp);
start(2:end,2)=v*sin(tstart/1000);
start(2:end,3)=zstart/100*sin(ttemp);
start(2:end,4)=v*cos(tstart/1000);
start(2:end,5)=0;
start(2:end,6)=0;

[R,PHI]=meshgrid(0.01:0.01:2.35,-pi:2*pi/360:pi);  

options=odeset('reltol',1e-7);
tspan=[0:0.005:50];

for i=1:9
y0=start(i,:);
[t0,y]=ode45('f3D',tspan,y0,options,Bz/1e4,Gx/1e4,Gy/1e4,R,PHI,at,0);
orbit(:,:,i)=y;
end

thetav=atan(-orbit(2:10000,2,1)./orbit(2:10000,4,1));
s=sum(sqrt((orbit(3:10001,1,1)-orbit(2:10000,1,1)).^2+(orbit(3:10001,3,1)-orbit(2:10000,3,1)).^2));

for i=1:9
[Theta,R]=cart2pol(orbit(2:10000,1,i),orbit(2:10000,3,i));
[Theta0,R0]=cart2pol(orbit(2:10000,1,1),orbit(2:10000,3,1));
envr(i,:)=(R-R0)*1000;%.*cos(thetav-Theta0);
end



phasetheta=[0:1:7]*0.7854;
phasegama=(alphaz^2+1)/betaz;
phasephi=atan(1/alphaz);
zstart=sqrt(emmitdefz*betaz)*cos(phasetheta)/10;
tstart=sqrt(emmitdefz*phasegama)*cos(phasetheta+phasephi);

start(:,1)=start(1,1);
start(:,2)=start(1,2);
start(:,3)=start(1,3);
start(:,4)=start(1,4);
start(2:end,5)=zstart/100;
start(2:end,6)=v*sin(tstart/1000);

options=odeset('reltol',1e-7);
tspan=[0:0.005:50];

[R,PHI]=meshgrid(0.01:0.01:2.35,-pi:2*pi/360:pi);  

for i=1:9
y0=start(i,:);
[t0,y]=ode45('f3D',tspan,y0,options,Bz/1e4,Gx/1e4,Gy/1e4,R,PHI,at,Ed);
orbit(:,:,i)=y;
end
for i=1:9
envz(i,:)=orbit(2:10000,5,i)*1000;
end

