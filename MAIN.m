%% MAIN - Modelado del sistema MONZA
clear all; clc;
%% Inicializacion
% Variables globales
global xpar ypar;
global theta;
global nivel;
global parabola;
global g;
global value;
global se tau e_ant;
global control_fuzzy;

% Lectura del controlador
control_fuzzy = readfis('controlFPI2');
% control_fuzzy = readfis('fuzzy_control_net_2');
% control_fuzzy = readfis('NeuroController');
% control_fuzzy = readfis('fuzzy_control_net_2');
% load('train_net4.mat');

% Inicializacion variables
theta = 0;
t_ini = 0;
t_fin = 10;
se = 0;
e_ant = 0;

% Parametros

nivel = 1;
condIni = [-0.075, 0, 0.16, 0, theta];
% nivel = 4;
% condIni = [-0.1, 0, 0.16, 0, theta];
g = 9.81;

%% Generar mapa
[xpar, ypar, xcir, ycir] = generarMapa(nivel, theta);

%% Inicializacion de la Simulacion
% Establecer comportamiento de ODE
options1 = odeset(  'RelTol',1e-4,...
                    'AbsTol', 1e-6,...
                    'MaxStep',0.01,...
                    'Events', @EventoChoque);
                
options2 = odeset(  'RelTol',1e-4,...
                    'AbsTol', 1e-6,...
                    'MaxStep',0.05,...
                    'Events', @EventoSalir);
                
% Inicializacion                
X = condIni;
T = 0;
parabola = 0;
tSim = [t_ini, t_fin];
h = 0.01;
tau = h;

%% Simulacion
tic
while 1
    % Caemos en una nueva parabola
    parabola = parabola + 1;
    if parabola > 7
        break
    end
    
    t_aux = 0;
    while t_aux<t_fin
        
        % Caida de la moneda
        condIni = real([X(end,1),X(end,2),X(end,3),X(end,4),X(end,5)]);
        
        % CONTROLADOR
        condIni(5) = controlador(condIni);
%         condIni(5) = net(real(X(end,1:4))');
        
%         % ----------------------------------------------
%         % Control manual
%         figure(1);
%         [xpar, ypar, xcir, ycir] = generarMapa(nivel, X(end,5));
%         for i = 1:7
%             plot(xpar{i},ypar{i},'k');
%             hold on
%         end
%         plot(xcir,ycir{1},'k');
%         plot(xcir,ycir{2},'k');
%         plot(X(end,1),X(end,3),'or');
%         hold off
%         
%        aux_inc_theta1 = input('Theta:[1 o 0] ');
%        if isempty(aux_inc_theta1)
%            aux_inc_theta1 = aux_inc_theta2;
%        else
%            if aux_inc_theta1 == 0
%                condIni(5) = condIni(5) - pi/2/20;
%                aux_inc_theta2 = aux_inc_theta1;
%            elseif aux_inc_theta1 == 1
%                condIni(5) = condIni(5) + pi/2/20;
%                aux_inc_theta2 = aux_inc_theta1;
%            end
%        end
%         % ----------------------------------------------

        [taux,xaux] = ode45(@SistemaCaida,[0 h],condIni,options1);
        tau = taux(end) - taux(1);

        % Almacenamos trayectoria
        T = [T; T(end)+taux];
        X = [X; xaux];
        
        e_ant = X(end,1);
        
        % Incrementamos tiempo
        t_aux = t_aux+h;
        
        % Comprobamos paso por cero
        if value(1) >= -1e-6 || value(2) >= -1e-6 || value(3) <= 1e-6
            break
        end         
    end

    % Establecemos condiciones tras choque
    % Pasamos a coordenadas referenciales
    xprima = X(end,1)*cos(theta) + X(end,3)*sin(theta);
    yprima = -X(end,1)*sin(theta) + X(end,3)*cos(theta);
    dxprima = X(end,2)*cos(theta) + X(end,4)*sin(theta);
    dyprima = -X(end,2)*cos(theta) + X(end,4)*sin(theta);

    % Disminucion de la velocidad
    e = 0.2;
    alpha = atan2(-0.54*2*xprima,1)+theta;
    R = [...
    cos(alpha)  sin(alpha);
    -sin(alpha) cos(alpha)];
    E = [e 0; 0 0]; 
    % Normal and Tangential velocity components
    velNT = E*(R*[X(end,2);X(end,4)]);
    % Rotate the velocity back to the inertial coordinates
    velOut = R\velNT;
    % Pack up the position and velocity and then return
    X(end,2) = velOut(1);
    X(end,4) = velOut(2);

%     % Comprobamos que seguimos dentro del monza
%     xpar_aux = xpar{parabola};
%     ypar_aux = ypar{parabola};
%     % Dentro en eje X
%     if mod(parabola,2) == 0 && X(end,1) >= xpar_aux(end)
%         break
%     elseif mod(parabola,2) == 1 && X(end,1) <= xpar_aux(1)
%         break
%     end

    % Dentro en eje Y
    if X(end,3) <= -0.205
        break
    end
    
    % Moneda por riel
    t_aux = 0;
    while t_aux<t_fin
        condIni = real([X(end,1),X(end,2),X(end,3),X(end,4),X(end,5)]);
        e_ant = X(end,1);
        [taux,xaux] = ode45(@SistemaRiel,[0 h],condIni,options2);
        tau = taux(end) - taux(1);
        
        % CONTROLADOR
        xaux(end,5) = controlador(xaux(end,:));
%         xaux(end,5) = net(real(X(end,1:4))');

%         % ----------------------------------------------
%         % Control manual
%         figure(1);
%         [xpar, ypar, xcir, ycir] = generarMapa(nivel, X(end,5));
%         for i = 1:7
%             plot(xpar{i},ypar{i},'k');
%             hold on
%         end
%         plot(xcir,ycir{1},'k');
%         plot(xcir,ycir{2},'k');
%         plot(X(end,1),X(end,3),'or');
%         hold off
%         
%         aux_inc_theta1 = input('Theta:[1 o 0] ');
%         if isempty(aux_inc_theta1)
%             aux_inc_theta1 = aux_inc_theta2;
%         else
%             if aux_inc_theta1 == 0
%                 xaux(end,5) = condIni(5) - pi/2/20;
%                 aux_inc_theta2 = aux_inc_theta1;
%             elseif aux_inc_theta1 == 1
%                 xaux(end,5) = condIni(5) + pi/2/20;
%                 aux_inc_theta2 = aux_inc_theta1;
%             end
%         end
%         % ----------------------------------------------

        
        x1 = xaux(end,1);
        x2 = xaux(end,2);
        x3 = xaux(end,3);
        x4 = xaux(end,4);
        
        % Translacion de bola al girar
        xaux(end,1) = x1*cos(xaux(end,5)-xaux(1,5)) - x3*sin(xaux(end,5)-xaux(1,5));
        xaux(end,3) = x1*sin(xaux(end,5)-xaux(1,5)) + x3*cos(xaux(end,5)-xaux(1,5));
        
        % Linealizacion
        xaux(:,1) = linspace(xaux(1,1),xaux(end,1),length(taux));
        xaux(:,2) = linspace(xaux(1,2),xaux(end,2),length(taux));
        xaux(:,3) = linspace(xaux(1,3),xaux(end,3),length(taux));
        xaux(:,4) = linspace(xaux(1,4),xaux(end,4),length(taux));
        xaux(:,5) = linspace(xaux(1,5),xaux(end,5),length(taux));
        
        % Almacenamos trayectoria
        T = [T; T(end)+taux];
        X = [X; xaux];
        
        % Incrementamos tiempo
        t_aux = t_aux+h;
        
        % Comprobamos paso por cero
        if value(1) >= -1e-6 || value(2) <= 1e-6
            break
        end
    end
    
    % Comprobamos si se ha pasado el tiempo y salimos de la simulacion
    if t_aux >= t_fin
        break;
    end
    
    % Comprobamos que seguimos dentro del monza
    xpar_aux = xpar{parabola};
    ypar_aux = ypar{parabola};
    % Dentro en eje X
    if mod(parabola,2) == 0 && X(end,1) >= xpar_aux(end)
        break
    elseif mod(parabola,2) == 1 && X(end,1) <= xpar_aux(1)
        break
    end
    % Dentro en eje Y
    if X(end,3) <= -0.205
        break
    end 
end
toc

%% Ploteo
drawArrow = @(x,y,Vx,Vy) quiver( x(1),y(1),Vx(2)-Vx(1),Vy(2)-Vy(1),0 );

% Representacion
figure(1);
[xpar, ypar, xcir, ycir] = generarMapa(nivel, X(end,5));
for i = 1:7
    plot(xpar{i},ypar{i},'k');
    hold on
end
plot(xcir,ycir{1},'k');
plot(xcir,ycir{2},'k');
plot(X(:,1),X(:,3),'r');
plot(X(1,1),X(1,3),'bo');
hold off

% % Velocidades
% figure(2)
% for k = 1:length(T)-1
% Vx(1) = real(X(k,2));
% Vx(2) = real(X(k+1,2));
% Vy(1) = real(X(k,4));
% Vy(2) = real(X(k+1,4));
% drawArrow(Vx,Vy,Vx,Vy);
% hold on
% end
% hold off

% Representacion + Velocidades
% figure(3)
% for i = 1:7
%     plot(xpar{i},ypar{i},'k');
%     hold on
% end
% plot(xcir,ycir{1},'k');
% plot(xcir,ycir{2},'k');
% for k = 1:length(T)-1
% plot(X(k,1),X(k,3),'r');
% Vx(1) = real(X(k,2));
% Vx(2) = real(X(k+1,2));
% Vy(1) = real(X(k,4));
% Vy(2) = real(X(k+1,4));
% x = real(X(k,1));
% y = real(X(k,3));
% drawArrow(x,y,Vx,Vy);
% end
% hold off

for j = 1:length(T)-1
    [xpar, ypar, xcir, ycir] = generarMapa(nivel, X(j,5));
    
    xpar_plot_1(:,j) = xpar{1};
    xpar_plot_2(:,j) = xpar{2};
    xpar_plot_3(:,j) = xpar{3};
    xpar_plot_4(:,j) = xpar{4};
    xpar_plot_5(:,j) = xpar{5};
    xpar_plot_6(:,j) = xpar{6};
    xpar_plot_7(:,j) = xpar{7};
    
    ypar_plot_1(:,j) = ypar{1};
    ypar_plot_2(:,j) = ypar{2};
    ypar_plot_3(:,j) = ypar{3};
    ypar_plot_4(:,j) = ypar{4};
    ypar_plot_5(:,j) = ypar{5};
    ypar_plot_6(:,j) = ypar{6};
    ypar_plot_7(:,j) = ypar{7};
end


% Representacion modelo dinamico

% fig=figure(1);
% for j = 1:length(T)-1
%     
% %     CIRCULO
%     plot(xcir,ycir{1},'k');
%     hold on
%     plot(xcir,ycir{2},'k');
%     
% %     PARABOLAS
%     plot(xpar_plot_1(:,j),ypar_plot_1(:,j),'k');
%     plot(xpar_plot_2(:,j),ypar_plot_2(:,j),'k');
%     plot(xpar_plot_3(:,j),ypar_plot_3(:,j),'k');
%     plot(xpar_plot_4(:,j),ypar_plot_4(:,j),'k');
%     plot(xpar_plot_5(:,j),ypar_plot_5(:,j),'k');
%     plot(xpar_plot_6(:,j),ypar_plot_6(:,j),'k');
%     plot(xpar_plot_7(:,j),ypar_plot_7(:,j),'k');
%   
%     plot(X(1:j,1),X(1:j,3),'g');
% 
% %     MONEDA
%     rectangle('Position', [X(j,1)-0.01, X(j,3), 0.02, 0.02],'Curvature', [1 1],'EdgeColor', 'r', 'FaceColor', 'r') 
%     
%     pause(0.01*(T(j+1)-T(j)))
%     axis([-0.25 0.25 -0.25 0.25])
%     hold off
%     MM(j) = getframe(fig);
% end


% writerObj = VideoWriter('test2.avi');
% open(writerObj);
% writeVideo(writerObj, MM)
% close(writerObj);