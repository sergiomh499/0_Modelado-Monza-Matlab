function [value,isterminal,direction] = EventoSalir(t,x)
%% Se comprueba que sale del riel
global nivel parabola value

% Caracteristicas de los rieles
riel = obtenerPuntoFinalRiel(nivel);
k = [0.1143, 0.0686, 0.03, -0.03, -0.0686, -0.1143,-0.16];
sol = [-0.18, 0.198, -0.205, 0.198, -0.185, 0.159, -0.118];

% Obtenemos el punto final del riel y pasamos a coordenadas inerciales
posXFinal = riel(parabola,1)*cos(x(5)) - riel(parabola,2)*sin(x(5));

% Comprobamos paso por cero
if mod(parabola,2) == 0
    value = [posXFinal - x(1);...   % Rebasa el final del riel
        sqrt((0.205)^2-x(1)^2)];    % Toca circunferencia del monza
else
    value = [x(1) - posXFinal;...   % Rebasa el final del riel
        sqrt((0.205)^2-x(1)^2)];    % Toca circunferencia del monza
end

% Terminacion de simulacion
isterminal =   [1;...
                1];
            
% Direccion del paso por cero             
direction =    [1;...
                0];

end