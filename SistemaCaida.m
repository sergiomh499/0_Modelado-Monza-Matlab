%% Programa bote de una pelota
function dx = SistemaCaida(t,x)
global g theta

% Control
theta = x(5);

% Ecuaciones de estado de caida de la bola
dx(1) = x(2);
dx(2) = 0;
dx(3) = x(4);
dx(4) = -g;
dx(5) = 0;


dx = dx';