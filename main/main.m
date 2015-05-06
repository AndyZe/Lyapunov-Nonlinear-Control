% A controller for nonlinear systems. Based on my PhD work
% Andy Zelenak, 2014

system_global_variables    % Do not modify.

open_loop_sim_from_ICs

disp(' ')
disp('Applying control input and simulating.')

tic

while (check_for_stop)
    simulate_closed_loop; % Apply the input and simulate for a short time
end
 
toc

disp(' ')
disp('Done.')

plots
save('results/datafile.mat','x','t','u','switched_Lyap')