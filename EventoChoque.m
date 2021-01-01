function [value,isterminal,direction] = EventoChoque(t,x)
%% Se comprueba el punto de choque
global parabola value

% Pasamos a coordenanas inerciales
xprima = x(1)*cos(x(5)) + x(3)*sin(x(5));
yprima = alturaParabola(xprima, parabola);
% Calculamos el punto en altura que corresponde para la posicion X de la
% moneda
y = -xprima*sin(-x(5)) + yprima*cos(-x(5));

% Comprobamos paso por cero
value = [y - x(3); ...      % Choque de bola con riel
        -0.205 - x(1);...   % Salida de bola por el lado
        0.205 - x(1)];      % Salida de bola por el lado

% Terminacion de simulacion
isterminal =   [1;...
                1;...
                1];
            
% Direccion del paso por cero        
direction =    [1;...
                0;...
                0];
end