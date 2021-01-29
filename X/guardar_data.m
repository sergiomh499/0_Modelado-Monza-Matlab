xf_input = x_input;
xf_output = x_output;

%%
x_input_aux = X(:,1:4);
x_output_aux = X(:,5);

xf_input = [xf_input;x_input_aux];
xf_output = [xf_output;x_output_aux];

%%

xf_input = [xf_input;x_input];
xf_output = [xf_output;x_output];