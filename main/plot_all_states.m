global num_states x t

% Can plot up to 7 states
state_styles = {'bo';'ro';'go';'co';'mo';'yo';'ko'};
target_styles = {'b.';'r.';'g.';'c.';'m.';'y.';'k.'};

figure
set(gcf,'color','w')
hold on;
title('States and Setpoints')
xlabel('Time')
ylabel('State [x]')

if num_states <= 7
    for i=1:num_states
        plot( t, x(:,i), state_styles{i},'markerSize',2);
    end
end


legend_matrix=cell(2*num_states,1);
legend_matrix{1}='x1';
legend_matrix{2}='x2';
legend_matrix{3}='x3';
legend_matrix{4}='x4';
legend_matrix{5}='x5';
legend_matrix{6}='x6';
legend_matrix{7}='x7';

legend(legend_matrix,'Location','southoutside','Orientation','Horizontal')