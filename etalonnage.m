function etalonnage(C)
%calcul des trois lignes c1 c2 c3    
c1=C(1,1:3);
c2=C(2,1:3);
c3=C(3,1:3);
%facteur d'echelle lambda (note L ici)
L=norm(c3);
%parametres intrinseques uo vo alpha_u alpha_v
uo=c1*c3'/L^2
vo=c2*c3'/(L^2)
alpha_u=sqrt(c1*c1'/L^2-uo^2)
alpha_v=sqrt(c2*c2'/L^2-vo^2)
%parametres extrinseques 
r1= (c1-uo*c3)/(L*alpha_u);
r2= (c2-vo*c3)/(L*alpha_v);
%normalisation deux premieres lignes pour obtenir R
r1n=r1/norm(r1);
r2n=r2/norm(r2);
r3=c3/L;
R = [r1n;r2n;r3]
%translations tx ty tz
tx=(C(1,4)-uo*C(3,4))/(L*alpha_u);
ty=(C(2,4)-vo*C(3,4))/(L*alpha_v);
tz=C(3,4)/L;
t=[tx;ty;tz]

%affichage des reperes camera et objet
figure;
hold on;
%repere camera
O_cam = [0;0;0];
X_cam = [1;0;0];
Y_cam = [0;0;-1];
Z_cam = [0;1;0];
plot3([O_cam(1) X_cam(1)],[O_cam(2) X_cam(2)],[O_cam(3) X_cam(3)],'Color', [1, 0, 0]);
plot3([O_cam(1) Y_cam(1)],[O_cam(2) Y_cam(2)],[O_cam(3) Y_cam(3)],'Color', [0, 1, 0]);
plot3([O_cam(1) Z_cam(1)],[O_cam(2) Z_cam(2)],[O_cam(3) Z_cam(3)],'Color', [0, 0, 1]);
%repere objet (on le transforme par rapport au repere world de matlab)
Rwc = [1 0 0; 0 0 1; 0 -1 0];
O_obj = Rwc * t;
X_obj = Rwc * (t + R(:,1));
Y_obj = Rwc * (t + R(:,2));
Z_obj = Rwc * (t + R(:,3));
hold on;
plot3([O_obj(1) X_obj(1)],[O_obj(2) X_obj(2)],[O_obj(3) X_obj(3)],'Color', [1, 0, 0]);
plot3([O_obj(1) Y_obj(1)],[O_obj(2) Y_obj(2)],[O_obj(3) Y_obj(3)],'Color', [0, 1, 0]);
plot3([O_obj(1) Z_obj(1)],[O_obj(2) Z_obj(2)],[O_obj(3) Z_obj(3)],'Color', [0, 0, 1]);
grid on;
