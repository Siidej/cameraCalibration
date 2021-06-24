% Etalonnage de la camera a partir du fichier uv_xyz
% Un modele de stenoppe classique est utilise
%
% Chargement de donnees 3D de la mire (cube) 
m=eval(['uv_xyz']);
n=max(size(m));

% Affectation des donnees du fichier aux varaiables
u=m(:,1);
v=m(:,2);
x=m(:,3);
y=m(:,4);
z=m(:,5);

% construction des matrices A et B
for i = 1:2:2*n
    k=(i+1)/2
    A(i,:)  =[x(k),y(k),z(k),1,0,0,0,0,-u(k)*x(k),-u(k)*y(k),-u(k)*z(k);];
    A(i+1,:)=[0,0,0,0,x(k),y(k),z(k),1,-v(k)*x(k),-v(k)*y(k),-v(k)*z(k);];
    B(i,1)=u(k);
    B(i+1,1)=v(k);
end
% Impression de A et B pour verifier
A
B
% Calcul du mod?le avec la pseudo inverse
X=pinv(A)*B;

% Le modele complet
C=[X(1:4)'; X(5:8)'; X(9:11)',1]