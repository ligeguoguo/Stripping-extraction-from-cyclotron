function [dydt]=f(t,y,~,arrayz,cox,coy,a)
    [phi,r]=cart2pol(y(1),y(3));
    Bz=interp2(cox,coy,arrayz,r,phi);
   dydt=[y(2)
      a*(y(4)*Bz)
      y(4)
      a*(-y(2)*Bz)
      ];