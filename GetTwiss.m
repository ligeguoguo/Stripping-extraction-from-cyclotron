
rplane=[-2.06756	0.300906189
      -1.34366	1.175781297
      0.1651	1.362462026
      1.57734	0.752271465
      2.06756	-0.300903026
      1.34366	-1.175732995
      -0.1651	-1.362397168
      -1.57734	-0.752251692];
zplane=[0.6794625	1.882019389
        1.41104	0.927038743
        1.316049	-0.570987506
        0.45013476	-1.734537336
        -0.6794625	-1.882019389
        -1.41104	-0.927038743
        -1.316049	0.570987506
        -0.45013476	1.734537336];
 emmitdefr=polyarea(rplane(:,1),rplane(:,2))/pi;
 emmitdefz=polyarea(zplane(:,1),zplane(:,2))/pi;
 betar=max(rplane(:,1))^2/emmitdefr;
 gamar=max(rplane(:,2))^2/emmitdefr;
 alphar=rplane(find(max(rplane(:,1))),1)*rplane(find(max(rplane(:,1))),2)/abs(rplane(find(max(rplane(:,1))),1)*rplane(find(max(rplane(:,1))),2))*sqrt((betar*gamar)-1);
 betaz=max(zplane(:,1))^2/emmitdefz;
 gamaz=max(zplane(:,2))^2/emmitdefz;
 alphaz=zplane(find(max(zplane(:,1))),1)*zplane(find(max(zplane(:,1))),2)/abs(zplane(find(max(zplane(:,1))),1)*zplane(find(max(zplane(:,1))),2))*sqrt((betaz*gamaz)-1);