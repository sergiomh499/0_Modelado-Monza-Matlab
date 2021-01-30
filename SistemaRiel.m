%% Programa bote de una pelota
function dx = SistemaRiel(t,x)
global alpha theta g

% Control
theta = x(5);

% Pasamos a coordenadas referenciales
xprima = x(1)*cos(x(5)) + x(3)*sin(x(5));
dxprima = x(2)*cos(x(5)) + x(4)*sin(x(5));
yprima = -x(1)*sin(x(5)) + x(3)*cos(x(5));
dyprima = -x(2)*sin(x(5)) + x(4)*cos(x(5));

% Extraemos el angulo de la pendiente
alpha = atan2(-1.08*xprima,1) + x(5);

% Ecuaciones de estado en sistema inercial
dx1aux = dxprima;
% dx2aux = -g*sin(alpha)-0.01/0.007*dxprima;
dx2aux = -g*sin(alpha)-0.01/0.007*dxprima;
dx3aux = -1.08*xprima*dxprima;
dx4aux = 0;

% Ecuaciones de estado en sistema referencial
dx(1) = dx1aux*cos(x(5)) - dx3aux*sin(x(5));
dx(2) = dx2aux*cos(x(5)) - dx4aux*sin(x(5));
dx(3) = dx1aux*sin(x(5)) + dx3aux*cos(x(5));
dx(4) = dx2aux*sin(x(5)) + dx4aux*cos(x(5));
dx(5) = 0;

dx = dx';
end