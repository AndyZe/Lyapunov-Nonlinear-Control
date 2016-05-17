function simulate_closed_loop

global x y t u delta_t
global V_dot_target V_dot_target_initial V
global u_max u_min epoch stiff_system
global num_inputs num_states
global plant_file target_x target_history
global LPF % Apply LPF if ==1
global filtered_u
global c % LPF parameter
global integral_gain model_file

% Record the target for plotting later.
target_history(epoch,:) = eval(target_x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adjust the Lyapunov damping
% Less damping as we get closer to origin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V_dot_target = (V(epoch)/V(1))^2*V_dot_target_initial - integral_gain*V(epoch);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calc. u to force V_dot<0 at each grid point.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Let one data point accumulate w/ no control effort
if epoch == 1
    u(epoch,:) = zeros(num_inputs,1);
    
else % We're past the first epoch, go normally
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Find the relative degree of the system (we ignore the ROM and zero dynamics
    % and assume they are stable).
    % Differentiate until u appears in y^[i]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    num_differentiations = 0;
    r = 0; % Relative degree of the system
    x_OL = x(epoch,:);
    x_CL = x(epoch,:);
    while r == 0 % Continue until the relative degree has been calculated
        
        OL = eval( strcat(model_file, '(t(epoch), x_OL, 0)') );
        
        CL = eval( strcat(model_file, '(t(epoch), x_CL, u_max(1) )') );
        
        x_OL = OL(1:num_states);
        x_CL = CL(1:num_states);
        y_OL = OL(num_states+1);
        y_CL = CL(num_states+1);

        num_differentiations = num_differentiations+1;
        
        if ( y_OL ~= y_CL )
            r = num_differentiations;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the Lie derivatives we will need
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % For convenience, put the system in normal form.
    % Again, we ignore the ROM and zero dynamics, 'z'.
    % Assume they are stable.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % zvi =    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the Vi with the largest dVi_dot/du (V1, V2, or V3)
    % Use it for this epoch
        % For V1:  ksi_r1*Lg_Lf_r1_h
        % For V2:  (ksi_r+2*Beta1*ksi_1^2*ksi_r*e^V1) * Lg_Lf_r1_h
        % For V3:  (ksi_r+2*Beta2*ksi_1^2*ksi_r*e^V1) * Lg_Lf_r1_h
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %dV1_dot_du = zvi(end)*
    
    %dV2_dot_du = 
    
    %dV3_dot_du = 
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the stabilizing u    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply LPF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if LPF == 1 % if user requested it
    % For each control effort, u
    for i=1 : num_inputs
        if epoch>2  % Let some data build up so we don't get (-) indices
            
            filtered_u(epoch,i) = (1/(1+c^2+1.414*c))*(...
                u(epoch-2,i)+2*u(epoch-1,i)+u(epoch,i)-...
                (c^2-1.414*c+1)*filtered_u(epoch-2,i)-...
                (-2*c^2+2)*filtered_u(epoch-1,i)...
                );
        else
            filtered_u(epoch,i) = u(epoch, i);
        end
    end
else % No LPF
    for i=1 : num_inputs
        filtered_u(epoch,i) = u(epoch, i);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check control effort saturation on filtered_u
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1: num_inputs
    if filtered_u(epoch,i) > u_max(i)
        filtered_u(epoch,i) = u_max(i);
    elseif filtered_u(epoch,i) < u_min(i)
        filtered_u(epoch,i) = u_min(i);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate the plant. Get a new x-position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_span= [t(epoch) t(epoch)+delta_t];
options=odeset('RelTol',1e-2,'AbsTol',1e-4,'NormControl','on',...
    'Vectorized','on');

if stiff_system
    [time, x_traj] = ode23s( str2func(plant_file), t_span,...
        [x(epoch,:)'; y(epoch,:)'; filtered_u(epoch,:)'], options );
else
    [time, x_traj] = ode23( str2func(plant_file), t_span,...
        [x(epoch,:)'; y(epoch,:)'; filtered_u(epoch,:)'], options );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update quantities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

epoch=epoch+1; % Count another epoch

t(epoch) = time(end); % Update time for the next epoch

y(epoch) = x_traj(end,num_states+1);
V(epoch)= V(epoch)+0.5*(y(epoch)-target_history(epoch-1))^2;

for i=1 : num_states
    x(epoch,i) = x_traj(end,i);
end