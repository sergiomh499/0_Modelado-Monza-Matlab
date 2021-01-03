x_aux_data = x_input;
theta = x_output;
x_input(:,1) = x_aux_data(:,1).*cos(theta) + x_aux_data(:,3).*sin(theta);
x_input(:,3) = -x_aux_data(:,1).*sin(theta) + x_aux_data(:,3).*cos(theta);
x_input(:,2) = x_aux_data(:,2).*cos(theta) + x_aux_data(:,4).*sin(theta);
x_input(:,4) = -x_aux_data(:,2).*cos(theta) + x_aux_data(:,4).*sin(theta);