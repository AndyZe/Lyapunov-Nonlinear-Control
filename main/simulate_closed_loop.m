function simulate_closed_loop

global x y t u delta_t
global V_dot_target V_dot_target_initial V
global u_max u_min epoch stiff_system
global num_inputs num_states
global plant_file target_x target_history
global LPF % Apply LPF if ==1
global filtered_u
global c % LPF parameter
global integral_gain
global using_V1 using_V2
global dV_dot_du

% Record the target for plotting later.
target_history(epoch) = eval(target_x);

% The nonlinear change of variable
xi = [0; 0];

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
    
    r = 2; % Relative degree of the system
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the Lie derivatives we will need
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % TODO: an extensible method of making these calculations
    dh_dx = [0 1 0]; % 1x3
    
    f = [ -x(epoch,1);
        x(epoch,3);
        x(epoch,1)*x(epoch,3) ];
    % 3x1
    
    Lf_h = dh_dx * f; % scalar
    
    dLf_h_dx = [0 0 1]; % 1x3
    
    Lf_2_h = dLf_h_dx*f; % scalar
    
    g = [(2+x(epoch,3)^2)/(1+x(epoch,3)^2); 0; 1]; % 3x1
    
    Lg_Lf_h = dLf_h_dx * g; % scalar, dLf_h/dx*g
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % For convenience, put the system in normal form.
    % Again, we ignore the ROM and zero dynamics, 'z'.
    % Assume they are stable.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO: an extensible method of making these calculations
    xi(1) = x(epoch,2)-target_history(epoch);  % xi(1) = h(x) = x2
    xi(2) = Lf_h;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the Vi with the largest dVi_dot/du (V1 or V2)
    % Use it for this epoch
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dV1_dot_du = xi(r)*Lg_Lf_h;
    
    dV2_dot_du = (xi(r)*(0.9+0.1*abs(xi(r)-1)) + 0.1*V(epoch)*sign( xi(r)-1 ) )*Lg_Lf_h;
    
    dV_dot_du(epoch,:) = [dV1_dot_du dV2_dot_du];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate the stabilizing u
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [M,I] = max(abs(dV_dot_du));
    
    if ( I==1 ) % use V1
        using_V1(epoch) = y(epoch);
        u(epoch,1) = (V_dot_target - xi(1)*Lf_h - xi(r)*Lf_2_h) /...
            dV1_dot_du;
    else %use V2
        using_V2(epoch) = y(epoch);
        u(epoch,1) = (V_dot_target -...
            xi(1)*(0.9+0.1*abs(xi(r)-1))*Lf_h-... % for xi(1)
            (xi(r)*(0.9+0.1*abs(xi(r)-1) )+0.1*V(epoch)*sign(xi(r)-1))*Lf_2_h )/... % for xi(r)
            dV2_dot_du;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply LPF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if LPF == 1 % if user requested it
    if epoch>2  % Let some data build up so we don't get (-) indices
        
        filtered_u(epoch) = (1/(1+c^2+1.414*c))*(...
            u(epoch-2)+2*u(epoch-1)+u(epoch)-...
            (c^2-1.414*c+1)*filtered_u(epoch-2)-...
            (-2*c^2+2)*filtered_u(epoch-1)...
            );
    else
        filtered_u(epoch) = u(epoch);
    end
else
    filtered_u(epoch) = u(epoch);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check control effort saturation on filtered_u
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if filtered_u(epoch) > u_max
    filtered_u(epoch) = u_max;
elseif filtered_u(epoch) < u_min
    filtered_u(epoch) = u_min;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate the plant. Get a new x-position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_span= [t(epoch) t(epoch)+delta_t];
options=odeset('RelTol',1e-2,'AbsTol',1e-4,'NormControl','on',...
    'Vectorized','on');

if stiff_system
    [time, x_traj] = ode23s( str2func(plant_file), t_span,...
        [x(epoch,:)'; y(epoch,:)'; filtered_u(epoch)'], options );
else
    [time, x_traj] = ode23( str2func(plant_file), t_span,...
        [x(epoch,:)'; y(epoch,:)'; filtered_u(epoch)'], options );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update quantities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

epoch=epoch+1; % Count another epoch

t(epoch) = time(end); % Update time for the next epoch

y(epoch) = x_traj(end,2);
V(epoch)= 0.5*dot(xi,xi);

for i=1 : num_states
    x(epoch,i) = x_traj(end,i);
end