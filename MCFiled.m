Bz=Bz-mcall*1000;

[R,PHI]=meshgrid(0.01:0.01:2.35,-pi:2*pi/360:pi); 
px=R.*cos(PHI);
py=R.*sin(PHI);
mcint=zeros(361,235);
mcall=mcint;

trans=[R0(find(abs(Theta0-(180-MC1THETA0)*pi/180)<0.00023))   Theta0(find(abs(Theta0-(180-MC1THETA0)*pi/180)<0.00023)) R0(find(abs(Theta0-(180-MC1THETA1)*pi/180)<0.0003))   Theta0(find(abs(Theta0-(180-MC1THETA1)*pi/180)<0.0003))  MC1G      MC1D
       R0(find(abs(Theta0(5001:9999)-(180-MC2THETA0)*pi/180)<0.00016)+5000)   max(Theta0(find(abs(Theta0-(180-MC2THETA0)*pi/180)<0.0001))) R0(find(abs(Theta0-(180-MC2THETA1)*pi/180)<0.0001))   Theta0(find(abs(Theta0-(180-MC2THETA1)*pi/180)<0.0001))  MC2G      MC2D];
   

for x=1:2;
    ang=atan((trans(x,3)-trans(x,1))*100*pi/(trans(x,4)-trans(x,2))/180)*180/pi;
    dis=[(trans(x,3)+trans(x,1))*50 (trans(x,4)+trans(x,2))*90/pi+180];
    length=floor(sqrt((trans(x,1)-trans(x,3))^2+((trans(x,2)-trans(x,4))*(trans(x,1)+trans(x,3)))^2/4)*100), 
   
MC1=zeros(length,5);
for i=1:5;
    for j=1:length;          
            MC1(j,i)=trans(x,5)*(i-3)+trans(x,6);    
    end

end

mcmap=mcint;

mctemp=imrotate(MC1,ang, 'bicubic');
[a,b]=size(mctemp);
for i=1:a;
    for j=1:b;
        mcmap(i,j)=mctemp(i,j);
    end
end
mcmap=imtranslate(mcmap,dis-[(b-1)/2 (a+1)/2],'cubic');
mcall=mcall+mcmap;
end
a=load('./O 65AMeV MEASURED.mat');

Bz=a.BZMES(1:120,:)*1E3;

for i=1:1:2
    Bz(i*120+1:i*120+120,:)=Bz(1:120,:);
end
Bz(361,:)=Bz(1,:);
Bz=flipud(Bz);
Bz=Bz+mcall*1000;
