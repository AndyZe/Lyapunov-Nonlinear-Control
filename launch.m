function varargout = launch(varargin)

% LAUNCH MATLAB code for launch.fig
%      LAUNCH, by itself, creates a new LAUNCH or raises the existing
%      singleton*.
%
%      H = LAUNCH returns the handle to a new LAUNCH or the handle to
%      the existing singleton*.
%
%      LAUNCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCH.M with the given input arguments.
%
%      LAUNCH('Property','Value',...) creates a new LAUNCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launch

% Last Modified by GUIDE v2.5 29-Aug-2015 12:41:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launch_OpeningFcn, ...
                   'gui_OutputFcn',  @launch_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

addpath(genpath(pwd))

% --- Executes just before launch is made visible.
function launch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to launch (see VARARGIN)

% Choose default command line output for launch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = launch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Clos Fig. 1 in case the program ran previously
figure(1)
close 1
figure(2)
close 2

clc
convert_user_input(handles)
main


% --- Executes on button press in title_question.
function title_question_Callback(hObject, eventdata, handles)
% hObject    handle to title_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Simulate a nonlinear dynamic system and calculate the control effort to stabilize it. Andy Zelenak, 2014');


% --- Executes on button press in run_question.
function run_question_Callback(hObject, eventdata, handles)
% hObject    handle to run_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Run the simulation after all options have been configured.');


% --- Executes on button press in start_time_question.
function start_time_question_Callback(hObject, eventdata, handles)
% hObject    handle to start_time_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Simulation start time. This quantity is unitless -- it could be seconds or hours, depending on your system definition.');


% --- Executes on button press in end_time_question.
function end_time_question_Callback(hObject, eventdata, handles)
% hObject    handle to end_time_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Simulation end time. This quantity is unitless -- it could be seconds or hours, depending on your system definition.');


% --- Executes on button press in time_step_question.
function time_step_question_Callback(hObject, eventdata, handles)
% hObject    handle to time_step_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Simulation time step. A smaller time step will give more accurate results and may do a better job of stabilizing the system, but it will take longer to run.');


% --- Executes on button press in num_states_question.
function num_states_question_Callback(hObject, eventdata, handles)
% hObject    handle to num_states_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('What is the order of the dynamic system? 1,2,3, etc');


% --- Executes on button press in num_inputs_question.
function num_inputs_question_Callback(hObject, eventdata, handles)
% hObject    handle to num_inputs_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('How many inputs does the system have? For example, if there is only one motor, there is probably just 1 input.');


% --- Executes on button press in stiff_system_question.
function stiff_system_question_Callback(hObject, eventdata, handles)
% hObject    handle to stiff_system_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Are the system equations stiff? Check if so to use a stiff ode solver. Indications that it_s a stiff system include: 1. The non-stiff solver is slower than the stiff solver. 2. There is a mix of large and relatively small coefficients. 3. Some state variables vary much more rapidly than others. For stiff systems, ode23s is used, otherwise ode23.');


% --- Executes during object creation, after setting all properties.
function Picture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Picture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Picture



function Start_Time_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Time_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Time_Input as text
%        str2double(get(hObject,'String')) returns contents of Start_Time_Input as a double


% --- Executes during object creation, after setting all properties.
function Start_Time_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Time_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Stop_Time_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_Time_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stop_Time_Input as text
%        str2double(get(hObject,'String')) returns contents of Stop_Time_Input as a double


% --- Executes during object creation, after setting all properties.
function Stop_Time_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop_Time_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Time_Step_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Step_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_Step_Input as text
%        str2double(get(hObject,'String')) returns contents of Time_Step_Input as a double


% --- Executes during object creation, after setting all properties.
function Time_Step_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_Step_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Num_States_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Num_States_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_States_Input as text
%        str2double(get(hObject,'String')) returns contents of Num_States_Input as a double


% --- Executes during object creation, after setting all properties.
function Num_States_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_States_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Num_Inputs_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Num_Inputs_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_Inputs_Input as text
%        str2double(get(hObject,'String')) returns contents of Num_Inputs_Input as a double


% --- Executes during object creation, after setting all properties.
function Num_Inputs_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_Inputs_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stiff_System_Input.
function Stiff_System_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Stiff_System_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Stiff_System_Input



function x_Target_Input_Callback(hObject, eventdata, handles)
% hObject    handle to x_Target_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_Target_Input as text
%        str2double(get(hObject,'String')) returns contents of x_Target_Input as a double


% --- Executes during object creation, after setting all properties.
function x_Target_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_Target_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Target_Location_Question.
function Target_Location_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Target_Location_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Where do you want to regulate the system to? This can be a static coordinate like [3] or a time-varying expression, expressed in terms of t(epoch).');


% --- Executes during object creation, after setting all properties.
function IC_Question_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in IC_Question.
function IC_Question_Callback(hObject, eventdata, handles)
% hObject    handle to IC_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Where is the system in state-space, initially?');


function IC_Input_Callback(hObject, eventdata, handles)
% hObject    handle to IC_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_Input as text
%        str2double(get(hObject,'String')) returns contents of IC_Input as a double

% --- Executes during object creation, after setting all properties.
function IC_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop_Time_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Min_Saturation_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Min_Saturation_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Min_Saturation_Input as text
%        str2double(get(hObject,'String')) returns contents of Min_Saturation_Input as a double


% --- Executes during object creation, after setting all properties.
function Min_Saturation_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Min_Saturation_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Saturation_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Saturation_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Saturation_Input as text
%        str2double(get(hObject,'String')) returns contents of Max_Saturation_Input as a double


% --- Executes during object creation, after setting all properties.
function Max_Saturation_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Saturation_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function V_Dot_Input_Callback(hObject, eventdata, handles)
% hObject    handle to V_Dot_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V_Dot_Input as text
%        str2double(get(hObject,'String')) returns contents of V_Dot_Input as a double


% --- Executes during object creation, after setting all properties.
function V_Dot_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V_Dot_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in V_Dot_Question.
function V_Dot_Question_Callback(hObject, eventdata, handles)
% hObject    handle to V_Dot_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('How quickly should the controller push towards the target location? A more negative number generally performs better. It must be a negative number. It is -20log(V_dot_target_initial).');


% --- Executes on button press in Input_Saturation_Question.
function Input_Saturation_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Input_Saturation_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Are there physical limits on the input? Enter arrays of u1_limit, u2_limit, etc...');



function Max_Epochs_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Epochs_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Epochs_Input as text
%        str2double(get(hObject,'String')) returns contents of Max_Epochs_Input as a double


% --- Executes during object creation, after setting all properties.
function Max_Epochs_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Epochs_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Gamma_Question.
function Gamma_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Set saturation limits for how quickly the controller adapts.');



function Gamma_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gamma_Input as text
%        str2double(get(hObject,'String')) returns contents of Gamma_Input as a double


% --- Executes during object creation, after setting all properties.
function Gamma_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Adapt_Input.
function Adapt_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Adapt_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Adapt_Input


% --- Executes on button press in Adapt_Question.
function Adapt_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Adapt_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Check to run a model identification adaptive controller. It only works on single input systems. However, there is no mathematical guarantee that the adaptive controller will stabilize the system.');


% --- Executes on button press in Plant_Definition_Question.
function Plant_Definition_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Plant_Definition_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Locate the .m file that defines the dynamic equations of the system. To define your own system, copy one of the existing files and edit the last few lines.');


% --- Executes on button press in Model_Definition_Question.
function Model_Definition_Question_Callback(hObject, eventdata, handles)
% hObject    handle to Model_Definition_Question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Locate the .m file that defines the dynamic equations that model the system. To define your own system, copy one of the existing files and edit the last few lines. Or, select the "No_model.m" file if a model is unknown.');


% --- Executes on button press in Browse_For_Plant.
function Browse_For_Plant_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_For_Plant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cd plant_dynamic_equations
[plant_filename] = uigetfile({'*.m'},'Select Definition for Plant');

% Remove .m from the end of the filename
plant_filename = plant_filename(1:end-2);

set(handles.Browse_For_Plant, 'String', plant_filename);
cd ..


% --- Executes on button press in Browse_For_Model.
function Browse_For_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_For_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd model_dynamic_equations
[model_filename] = uigetfile({'*.m'},'Select Definition for Model');

% Remove .m from the end of the filename
model_filename = model_filename(1:end-2);

set(handles.Browse_For_Model, 'String', model_filename);
cd ..


% --- Executes on button press in partial_derivative_question.
function partial_derivative_question_Callback(hObject, eventdata, handles)
% hObject    handle to partial_derivative_question (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = msgbox('Changes how the code numerically calculates partial derivatives. The default method is faster, but it is not good for integrator systems.');


% --- Executes on button press in Partial_Derivative_Input.
function Partial_Derivative_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Partial_Derivative_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Partial_Derivative_Input


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = msgbox('Determines how often the alternative Lyapunov function should be used.');



function Switching_Threshold_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Switching_Threshold_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Switching_Threshold_Input as text
%        str2double(get(hObject,'String')) returns contents of Switching_Threshold_Input as a double


% --- Executes during object creation, after setting all properties.
function Switching_Threshold_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Switching_Threshold_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
