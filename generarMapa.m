function [xpar, ypar, xcir, ycir] = generarMapa(nivel, theta)
%% 
xpar = cell(1,7);
ypar = cell(1,7);
R = 0.205;              % Radio circunferencia

% Definicion niveles
riel =  obtenerPuntoFinalRiel(nivel);

% Variables auxiliares
k = [0.1143, 0.0686, 0.03, -0.03, -0.0686, -0.1143, -0.16];
sol = [-0.18, 0.198, -0.205, 0.198, -0.185, 0.159, -0.118];

% syms ox
for i = 1:7
%     sol = solve(0.205^2==ox^2+(0.54*ox^2+k(i))^2, ox,'Real',true);
    if mod(i,2) == 1
        xpar{i} = sol(i):0.001:riel(i,1);
    else
        xpar{i} = riel(i,1):0.001:sol(i);
    end 
    
    % Definición de parábolas
    ypar{i} = -0.54*xpar{i}.^2+k(i);
    
    % Aplicamos angulo theta
    xpar_aux = xpar{i}*cos(theta) - ypar{i}*sin(theta);
    ypar_aux = xpar{i}*sin(theta) + ypar{i}*cos(theta);
    
    xpar{i} = xpar_aux;
    ypar{i} = ypar_aux;
end


% Definicion circunferencia
xcir = -R:0.005:R;
ycir{1} = sqrt((R)^2 - xcir.^2);
ycir{2} = -sqrt((R)^2 - xcir.^2);


end