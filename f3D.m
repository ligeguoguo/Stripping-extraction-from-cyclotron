function [dydt]=f(t,y,~,arrayz,gx,gy,cox,coy,a,ed)
    [phi,r]=cart2pol(y(1),y(3));
    if 180/180*pi<phi<225/180*pi
        Ex=ed*cos(phi);
        Ey=ed*sin(phi);
    elseif 270/180*pi<phi<315/180*pi
        Ex=ed*cos(phi);
        Ey=ed*sin(phi);
    else
            Ex=0;
            Ey=0;
    end
    Bz=interp2(cox,coy,arrayz,r,phi);
    Bx=y(5)*interp2(cox,coy,gx,r,phi);
    By=y(5)*interp2(cox,coy,gy,r,phi);
   dydt=[y(2)
      a*(y(4)*Bz+Ex)
      y(4)
      a*(-y(2)*Bz+Ey)
      y(6)
      a*((y(2)*By-y(4)*Bx))
      ];
