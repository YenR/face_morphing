function varargout = InterpolateGUI(varargin)
% INTERPOLATEGUI MATLAB code for InterpolateGUI.fig
%      INTERPOLATEGUI, by itself, creates a new INTERPOLATEGUI or raises the existing
%      singleton*.
%
%      H = INTERPOLATEGUI returns the handle to a new INTERPOLATEGUI or the handle to
%      the existing singleton*.
%
%      INTERPOLATEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERPOLATEGUI.M with the given input arguments.
%
%      INTERPOLATEGUI('Property','Value',...) creates a new INTERPOLATEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InterpolateGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InterpolateGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InterpolateGUI

% Last Modified by GUIDE v2.5 27-Nov-2014 09:50:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InterpolateGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @InterpolateGUI_OutputFcn, ...
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


% --- Executes just before InterpolateGUI is made visible.
function InterpolateGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InterpolateGUI (see VARARGIN)

% Choose default command line output for InterpolateGUI
handles.output = hObject;


% UIWAIT makes InterpolateGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


handles.image1 = cell2mat(varargin(1));
handles.image2 = cell2mat(varargin(2));
handles.xA = cell2mat(varargin(3));
handles.yA = cell2mat(varargin(4));
handles.xB = cell2mat(varargin(5));
handles.yB = cell2mat(varargin(6));

    
handles.f = 0;

% Update handles structure
guidata(hObject, handles);

imshow(handles.image1, 'Parent', handles.axes1);


% --- Outputs from this function are returned to the command line.
function varargout = InterpolateGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%Sets the percentage for interpolation on slider movement
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.f = get(hObject,'Value');
set(handles.edit1, 'String', handles.f);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1. (OK-Button)
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

make_image(hObject, handles);


%Creates a new image, saves it in handles.i and shows it in the GUI
function make_image(hObject, handles)
image1 = handles.image1;
image2 = handles.image2;
f = handles.f;

image1 = interpolativeScale(image1,[handles.yA,handles.xA],[handles.yB,handles.xB],f,1);
image1 = interpolativeScale(image1,[handles.yA,handles.xA],[handles.yB,handles.xB],f,2);
image2 = interpolativeScale(image2,[handles.yB,handles.xB],[handles.yA,handles.xA],1-f,1);
image2 = interpolativeScale(image2,[handles.yB,handles.xB],[handles.yA,handles.xA],1-f,2);

handles.i = interpolateImages(image1, image2, f);

% Update handles structure
guidata(hObject, handles);

imshow(handles.i, 'Parent', handles.axes1);


%Sets the percentage for interpolation, when the textbox is used
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.f = str2double(get(handles.edit1,'String'));
set(handles.slider1, 'Value', handles.f);

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', 0);


% --- Executes on button press in pushbutton2. (Save-Button)
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time = clock; % Gets the current time as a 6 element vector
imwrite(handles.i, ['../output/' num2str(time(1))... % Returns year as character
    num2str(time(2))... % Returns month as character
    num2str(time(3))... % Returns day as char
    num2str(time(4))... % returns hour as char..
    num2str(time(5))... %returns minute as char
    num2str(floor(time(6)))... % returns seconds as char
    '.png']);


% --- Executes on button press in pushbutton3. (Animate-Button)
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for n = 0:0.05:1
    handles.f = n;
    set(handles.slider1, 'Value', handles.f);
    set(handles.edit1, 'String', handles.f);
    make_image(hObject, handles);
    pause(0.05);
end
for n = 1:-0.05:0
    handles.f = n;
    set(handles.slider1, 'Value', handles.f);
    set(handles.edit1, 'String', handles.f);
    make_image(hObject, handles);
    pause(0.05);
end

