clear all, close all, clc

%% Cargar datos preprocesados
load ./DATA.mat

%% Crear matrices de observaciones
X = VORTALL(:,1:end-1);
X2 = VORTALL(:,2:end);

%% Descomposición en valores singulares
[U,S,V] = svd(X,'econ');

%%  Calcular DMD (Phi son los vectores propios)
r = 21;  % truncar en 21 modos
U = U(:,1:r);
S = S(1:r,1:r);
V = V(:,1:r);
Atilde = U'*X2*V*inv(S);
[W,eigs] = eig(Atilde);
Phi = X2*V*inv(S)*W;

%% Graficar modos dinámicos
for i=1:21
    x = Phi(:,i);
    plotCylinder(reshape(real(x),nx,ny),nx,ny);
    plotCylinder(reshape(imag(x),nx,ny),nx,ny);
end

