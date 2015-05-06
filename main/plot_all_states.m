global num_states x target_history t

% Can plot up to 7 states
state_styles = {'bx';'rx';'gx';'cx';'mx';'yx';'kx'};
target_styles = {'b-';'r-';'g-';'c-';'m-';'y-';'k-'};

figure
hold on;
title('States and Setpoints')
xlabel('Time')
ylabel('State/Setpoint')
     
if num_states <= 7
    for i=1:num_states
        plot( t, x(:,i), state_styles{i});
        plot( t, target_history(:,i), target_styles{i});
    end
end


legend_matrix=cell(2*num_states,1);
legend_matrix{1}='x1';
legend_matrix{2}='setpt1';
legend_matrix{3}='x2';
legend_matrix{4}='setpt2';
legend_matrix{5}='x3';
legend_matrix{6}='setpt3';
legend_matrix{7}='x4';
legend_matrix{8}='setpt4';
legend_matrix{9}='x5';
legend_matrix{10}='setpt5';
legend_matrix{11}='x6';
legend_matrix{12}='setpt6';
legend_matrix{13}='x7';
legend_matrix{14}='setpt7';

legend(legend_matrix,'Location','southoutside','Orientation','Horizontal')