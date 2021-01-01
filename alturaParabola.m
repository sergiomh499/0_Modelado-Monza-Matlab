function y = alturaParabola(x,parabola)
%% Obtiene la altura de la parabola
k = [0.1143, 0.0686, 0.03, -0.03, -0.0686, -0.1143, -0.16];
y = -0.54*x^2 + k(parabola);
end