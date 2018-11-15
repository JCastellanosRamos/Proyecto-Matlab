function varargout = FiltroPasaTodo(varargin)
% FILTROPASATODO MATLAB code for FiltroPasaTodo.fig
%      FILTROPASATODO, by itself, creates a new FILTROPASATODO or raises the existing
%      singleton*.
%
%      H = FILTROPASATODO returns the handle to a new FILTROPASATODO or the handle to
%      the existing singleton*.
%
%      FILTROPASATODO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTROPASATODO.M with the given input arguments.
%
%      FILTROPASATODO('Property','Value',...) creates a new FILTROPASATODO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FiltroPasaTodo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FiltroPasaTodo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FiltroPasaTodo

% Last Modified by GUIDE v2.5 09-May-2018 07:50:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FiltroPasaTodo_OpeningFcn, ...
                   'gui_OutputFcn',  @FiltroPasaTodo_OutputFcn, ...
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


% --- Executes just before FiltroPasaTodo is made visible.
function FiltroPasaTodo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FiltroPasaTodo (see VARARGIN)

% Choose default command line output for FiltroPasaTodo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FiltroPasaTodo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FiltroPasaTodo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f1=get(handles.radiobutton1,'Value')
f2=get(handles.radiobutton3,'Value')
if f1==1 && f2==0
    cla(handles.axes1,'reset');
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    K = get(handles.slider10,'Value');
    RC= R*C;
    num = [1 (-1/RC)];
    den = [1 (1/RC)];
    gs= tf(num,den);
    gs = gs.*(K)
    axes(handles.axes1);
    h=rlocusplot(gs);
    p=getoptions(h);
    p.Title.String = 'Polos y Zeros';
    p.Grid = 'on';
    setoptions(h,p);
elseif f1==0 && f2==1
    cla(handles.axes1,'reset');
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    L = get(handles.slider9,'Value');
    K = get(handles.slider10,'Value');
    LC= L*C;
    RL= R/L;
    num = [1 (-1*RL) (1/LC)];
    den = [1 (1*RL) (1/LC)];
    gs= tf(num,den);
    gs = gs.*(K)
    axes(handles.axes1);
    h=rlocusplot(gs);
    p=getoptions(h);
    p.XLabel.String = 'Reales';
    p.YLabel.String = 'Imaginarios';
    p.Title.String = 'Polos y Zeros';
    p.Grid = 'on';
    setoptions(h,p);
elseif f1==1 & f2==1
    msgbox('Solo puede seleccionar una función a la vez','Mensaje');
else
    msgbox('Seleccione al menos una función de transferencia','Mensaje');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f1=get(handles.radiobutton1,'Value')
f2=get(handles.radiobutton3,'Value')
if f1==1 && f2==0
    r = 0:.01:20;
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    K = get(handles.slider10,'Value');
    RC= R*C;
    num = [1 (-1/RC)];
    den = [1 (1/RC)];
    gs= tf(num,den);
    gs = gs.*(K)
    y1 = step(gs,r);
    axes(handles.axes1);
    plot(r,y1,'-');
    title('Respuesta u(t)');
    xlabel('Time (sec)');
    ylabel('y(t)');
    grid;
elseif f1==0 && f2==1
    r = 0:.01:20;
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    L = get(handles.slider9,'Value');
    K = get(handles.slider10,'Value');
    LC= L*C;
    RL= R/L;
    num = [1 (-1*RL) (1/LC)];
    den = [1 (1*RL) (1/LC)];
    gs= tf(num,den);
    gs = gs.*(K)
    y1 = step(gs,r);
    axes(handles.axes1);
    plot(r,y1,'-');
    title('Respuesta u(t)');
    xlabel('Time (sec)');
    ylabel('y(t)');
    grid;
elseif f1==1 & f2==1
    msgbox('Solo puede seleccionar una función a la vez','Mensaje');
else
    msgbox('Seleccione al menos una función de transferencia','Mensaje');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f1=get(handles.radiobutton1,'Value')
f2=get(handles.radiobutton3,'Value')
if f1==1 && f2==0 %%este se modifica
    %%leyendas el rojo es señal de entrada = x(t)
    %%azul es salida y(t)
    %% axis dinamicos
    syms t s H B A w
    cla(handles.axes3,'reset');
    r = 0:.01:1000;
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    K = get(handles.slider10,'Value');
    RC= R*C;
    A=str2double(get(handles.edit1,'String'))
    u=get(handles.edit1,'String')
    w=str2double(get(handles.edit2,'String'))
    n=get(handles.edit2,'String')
    B=str2double(get(handles.edit3,'String'))
    q=get(handles.edit3,'String')
    if isempty(u) || isempty(n) || isempty(q)
        msgbox('Se deben llenar los campos','Mensaje');
    else
    B=((B*pi)/180)
    a=A;
    W=w;
    b=B;
    x1 = a*cos(W*r+b);
    x=A*cos(w*t+B);
    X=laplace(x);
    fprintf('X(s)\n');
    pretty(X)
    H=(K.*(s-1./RC)./(s+1./RC));
    fprintf('Funcion de Transferencia\n');
    pretty(H)
    Y=H*X;
    fprintf('Y(s)\n');
    pretty(Y)
    y=ilaplace(Y);
    fprintf('y(t)\n');
    pretty(y)
    axes(handles.axes3);
    if W>=10
       ezplot(y,[0,1]); 
    end
    if W>1
        ezplot(y,[0,10]);
    end
    if W<= 1
    ezplot(y,[0,50]);
    end
    if W <= .1
            ezplot(y,[0,100]);
    end
    if W <= .01
                ezplot(y,[0,1000]);
    end
   
  
    hold on
    plot (r,x1,'red');
    if W>=10
    axis([0 1 -1 2])
    end
    if W> 1
    axis([0 10 -1 2])
     end
     if W<= 1
    axis([0 50 -1 2])
     end
     if W <= .1
            axis([0 100 -1 2])
     end
     if W <= .01
                axis([0 1000 -1 2])
     end
    
    legend('señal out = y(t)','señal in = x(t)');
    title('Señal de entrada vs Señal de salida');
    xlabel('Time (sec)');
    ylabel('y(t)');
        
    grid;
    end
elseif f1==0 && f2==1
    syms t s H B A w
    cla(handles.axes3,'reset');
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    L = get(handles.slider9,'Value');
    K = get(handles.slider10,'Value');
    LC= L*C;
    RL= R/L;
    A=str2double(get(handles.edit1,'String'))
    u=get(handles.edit1,'String')
    w=str2double(get(handles.edit2,'String'))
    n=get(handles.edit2,'String')
    B=str2double(get(handles.edit3,'String'))
    q=get(handles.edit3,'String')
    if isempty(u) || isempty(n) || isempty(q)
        msgbox('Se deben llenar los campos','Mensaje');
    else
        r = 0:.01:1000;
    B=((B*pi)/180)
    a=A;
    W=w;
    b=B;
    x1 = a*cos(W*r+b);
    x=A*cos(w*t+B);
    X=laplace(x);
    fprintf('X(s)\n');
    pretty(X)
    H=(K.*(s.^2-(s.*RL)+(1./LC))./(s.^2+(s.*RL)+(1./LC)));
    fprintf('Funcion de Transferencia\n');
    pretty(H)
    Y=H*X;
    fprintf('Y(s)\n');
    pretty(Y)
    y=ilaplace(Y);
    fprintf('y(t)\n');
    pretty(y)
    axes(handles.axes3);
    if W>=10
       ezplot(y,[0,1]); 
    end
    if W>1
        ezplot(y,[0,10]);
    end
    if W<= 1
    ezplot(y,[0,50]);
    end
    if W <= .1
            ezplot(y,[0,100]);
    end
    if W <= .01
                ezplot(y,[0,1000]);
    end
    hold on
    plot (r,x1,'red');
    if W>=10
    axis([0 1 -1 2])
    end
    if W> 1
    axis([0 10 -1 2])
     end
     if W<= 1
    axis([0 50 -1 2])
     end
     if W <= .1
            axis([0 100 -1 2])
     end
     if W <= .01
                axis([0 1000 -1 2])
     end
     
    legend('señal out = y(t)','señal in = x(t)');
    title('Señal de entrada vs Señal de salida');
    xlabel('Time (sec)');
    ylabel('y(t)');
    grid;
    end
elseif f1==1 & f2==1
    msgbox('Solo puede seleccionar una función a la vez','Mensaje');
else
    msgbox('Seleccione al menos una función de transferencia','Mensaje');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f1=get(handles.radiobutton1,'Value')
f2=get(handles.radiobutton3,'Value')
if f1==1 && f2==0
    cla(handles.axes3,'reset');
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    K = get(handles.slider10,'Value');
    RC= R*C;
    num = [1 (-1/RC)];
    den = [1 (1/RC)];
    gs= tf(num,den);
    gs = gs.*(K)
    axes(handles.axes3);
    f=bodeplot(gs);
    p=getoptions(f);
    p.Title.String = 'Bode de la Función de Transferencia';
    p.Grid = 'on';
    setoptions(f,p);
elseif f1==0 && f2==1
    cla(handles.axes3,'reset');
    C = get(handles.slider7,'Value');
    R = get(handles.slider8,'Value');
    L = get(handles.slider9,'Value');
    K = get(handles.slider10,'Value');
    LC= L*C;
    RL= R/L;
    num = [1 (-1*RL) (1/LC)];
    den = [1 (1*RL) (1/LC)];
    gs= tf(num,den);
    gs = gs.*(K)
    axes(handles.axes3);
    f=bodeplot(gs);
    p=getoptions(f);
    p.Title.String = 'Bode de la Función de Transferencia';
    p.Grid = 'on';
    setoptions(f,p);
elseif f1==1 & f2==1
    msgbox('Solo puede seleccionar una función a la vez','Mensaje');
else
    msgbox('Seleccione al menos una función de transferencia','Mensaje');
 end
        
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1
f1=get(handles.radiobutton1,'Value')
if f1==1
 set(handles.slider9,'Enable','off')
else
 set(handles.slider9,'Enable','on')
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
c=get(handles.slider7,'Value')
set(handles.text4,'String',c)



% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'sliderstep',[0.0001 0.0001]);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
k=get(handles.slider10,'Value')
set(handles.text7,'String',k)


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'sliderstep',[0.01 0.01]);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
b=get(handles.slider9,'Value')
set(handles.text6,'String',b)


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'sliderstep',[0.001 0.001]);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
r=get(handles.slider8,'Value')
set(handles.text5,'String',r)


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'sliderstep',[0.0001 0.0001]);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes10
axes(hObject)
imshow('F1.tif');


% --- Executes during object creation, after setting all properties.
function axes11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes11
axes(hObject)
imshow('q1.tif');


% --- Executes during object creation, after setting all properties.
function axes12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes12
axes(hObject)
imshow('f2.tif');


% --- Executes during object creation, after setting all properties.
function axes13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes13
axes(hObject)
imshow('q3.tif');


% --- Executes during object creation, after setting all properties.
function axes14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes14
axes(hObject)
imshow('flecha.tif');


% --- Executes during object creation, after setting all properties.
function axes15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes15
axes(hObject)
imshow('flecha1.tif');


% --- Executes during object creation, after setting all properties.
function axes16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes16
axes(hObject)
imshow('F1.tif');


% --- Executes during object creation, after setting all properties.
function axes17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes17
axes(hObject)
imshow('F2.tif');


% --- Executes during object creation, after setting all properties.
function axes18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes18
axes(hObject)
imshow('q1.tif');


% --- Executes during object creation, after setting all properties.
function axes19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes19
axes(hObject)
imshow('q3.tif');


% --- Executes during object creation, after setting all properties.
function axes20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes20
axes(hObject)
imshow('flecha.tif');


% --- Executes during object creation, after setting all properties.
function axes21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes21
axes(hObject)
imshow('flecha1.tif');
