function convert_user_input(handles)

global start_time stop_time
start_time = str2num( get(handles.Start_Time_Input,'String') );
stop_time = str2num( get(handles.Stop_Time_Input,'String') );

global delta_t
delta_t = str2num( get(handles.Time_Step_Input,'String') );

global num_states num_inputs
num_states = str2num( get(handles.Num_States_Input,'String') );
num_inputs = str2num( get(handles.Num_Inputs_Input,'String') );

global stiff_system
stiff_system = get(handles.Stiff_System_Input,'Value');

global default_deriv_calc
default_deriv_calc = get(handles.Partial_Derivative_Input,'Value');

global target_x
target_x = get(handles.x_Target_Input,'String');

global x_IC
x_IC = str2num( get(handles.IC_Input,'String') );

global u_max u_min
u_min = str2num(get(handles.Min_Saturation_Input,'String'));
u_max = str2num(get(handles.Max_Saturation_Input,'String'));

global V_dot_target_initial
V_dot_target_initial = -10^(str2num(get(handles.V_Dot_Input,'String'))/-20);

global plant_file model_file
plant_file = get(handles.Browse_For_Plant,'String');
model_file = get(handles.Browse_For_Model,'String');

global switching_threshold
switching_threshold = str2num( get(handles.Switching_Threshold_Input,'String') );

global gamma % V2 step location
gamma = str2num( get(handles.Gamma_Input,'String') );

global LPF % Apply a LPF if ==1
LPF = get(handles.LPF_Input,'Value');

% Make the c calculation for the filter
cutoff_freq = str2num( get(handles.Cutoff_Input,'String') );
global c 
c = cot( cutoff_freq*6.2832*delta_t/2 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Error checking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (num_inputs<0 || num_states<1)
    error('Must have at least 1 state and 0 inputs.')
end

% Some temporary parameters so we can evaluate if target_x is
% the correct length
epoch=1;
t=0;
if numel( eval(target_x) ) ~= num_states
    error('The target vector length must match #states.')
end

if numel(x_IC) ~= num_states
    error('The initial condition vector length must match #states.')
end

if str2num(get(handles.Max_Saturation_Input,'String')) < str2num(get(handles.Min_Saturation_Input,'String'))
    error('Upper saturation limit cannot be less than the lower limit.')
end

if (V_dot_target_initial >= 0)
    error('Controller aggressiveness must be negative. Change this parameter.')
end

if strcmp(plant_file,'Browse')
    error('Select a file to define the system plant.')
end

if strcmp(model_file,'Browse')
    error('Select a file to define the system model.')
end

