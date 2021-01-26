%% CONTROLADOR
function theta = controlador(x)
global parabola se e_ant tau control_fuzzy  theta

tipo_control = 4;

switch tipo_control
    
    case 1 % Control adaptativo
        
        if mod(parabola,2) == 1
            if x(1) > 0
              
                theta = 1.4*x(1);
             
            else
                t2=theta;
                theta = 4*x(1);
                if abs(t2-theta)>0.08
                    theta=(theta+t2)/2;
                   
                end
            end
        else
            if x(1) < 0
                theta = 1.4*x(1);
            else
                 t2=theta;
                theta = 4*x(1);
                if abs(t2-theta)>0.08
                    theta=(t2+theta)/2;
                  
                end
            end
        end
        
    case 2 % Controlador PID
        
        Kp = 0.05*180/pi;
        Ki = 2.1*0.045*180/pi;
        Kd = 2e-4*180/pi;
        
        se = se + x(1);
        theta = Kp*x(1) + Ki*se*tau + Kd*(x(1) - e_ant)/tau;
        
    case 3 % Controlador Fuzzy
        
        se = real(se + x(1));
        sumaE = real(se*tau);
        x(1) = real(x(1));
        theta = evalfis(control_fuzzy, [x(1) sumaE]);
        
    case 4 % Controlador neuro-fuzzy
        
        theta = evalfis(control_fuzzy, real([x(1),x(2),x(3),x(4)]));
        
    otherwise
        return
end


end