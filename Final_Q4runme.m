% 
% Question 3 assignment 5 (Final)
clear all;
clf;

global v1 v1L v2A v2B v2L v3 v4; % units nM/h, Supplementary Table 1
global k1L k1D k2 k3 k4 p1 p1L p2 p3 p4; % units /h, Supplementary Table 1
global d1 d2D d2L d3D d3L d4D d4L ; % units /h, Supplementary Table 1
global K1 K2 K3 K4 K5 K6 K7 K8 K9 K10; % units nM, Supplementary Table 1
global period daytime nighttime; % in hours
global D L; % either 1 or 0 
global ymax; % for normalization
global A; %introduce Alpha = 1/average delay

v1= 4.6; v1L= 3.0; v2A = 1.3; v2B = 1.5; v2L =5.0; v3 = 1.0; v4 = 1.5;
k1L=0.53; k1D=0.21; k2=0.35; k3=0.56; k4=0.57; p1=0.76; p1L=0.42; p2=1.0; p3=0.64; p4=1.0;
d1=0.68; d2D=0.50; d2L=0.30; d3D=0.48; d3L=0.78; d4D=1.2; d4L=0.38;
K1=0.16; K2=1.2; K3=0.24; K4=0.23; K5=0.3; K6=0.46; K7=2.0; K8=0.36; K9=1.9; K10=1.9;
A = 0.2;



for n=20:20                              % use for question 3(i)
%for n=23:33                             % use for question 3(ii)
    
    period = 24;                        % for Q3(i)    
    daytime = n;                        % for Q3(i)
    nighttime = 24 - n;                 % for Q3(i)
    color = [(n)/24,0.5,(25-n)/24];     % for Q3(i)
    %color = [0.5+(n/48),0.5,0.5+((25-n)/48)];     % for Q3(i)
    
%     period = n;                          % for Q3(ii)
%     daytime = n/2;                       % for Q3(ii)
%     nighttime = n/2;                     % for Q3(ii)
%     %color=[0.85,0.9,0.9]*(n/50)^(1/3)+[0.5,0,0]*((60-n)/50)^3;% for Q3(ii)
%     color=[0.9,0.9,0.9]*(1-(n/50)^3)+[0,0,0.5]*(n/50)^3;      % for Q3(ii)
     

    % Using initial conditions and normalization data for equal days (12L:12D)
    % and now using y(10) initial = Alpha = 0.5
    ystart = [1.8549 1.7622 0.3607 0.4959 0.2726 0.7247 0.0011 0.0017 0.9727 A]; 
    hours = 0
     
while hours < 600
    hold on
    L=1; D=0;
    %disp(ystart);

    [t,y]=ode45(@Final_Q4L,[hours:0.01:hours+daytime],ystart); %evaluates current day
    %disp(ystart);
    %disp(y(end,:));
    disp(max(y(:,:)));
        
    axis([0 480 0 4])     
    %title('Expression Profiles for varying light cycles over 5 days')
    title('expression profiles for alpha = 0.2')
    xlabel('ZT (hours)')
    ylabel('Expression')
        
    plot (t,y(:,1), 'Color', color); % to display raw abundance (q3(i))
    %plot (t*24/n,y(:,1), 'Color', color); % for varying day length (q3(ii))   
    %plot (t*24/n,y(:,1), 'r'); % for varying day length (q3(ii))   
    
    hours = hours+daytime; % end of daytime shift
    ystart = y(end,:); % sets start values for night shift
    
    D=1; L=0;
    [t,y]=ode45(@Final_Q4L,[hours:0.01:hours+nighttime],ystart); %evaluates current day
    %disp(ystart);
    %disp(y(end,:));
    disp(max(y(:,:)));

    plot (t,y(:,1), 'Color', color); % for varying light/dark ratios (q3(i))    
    %plot (t*24/n,y(:,1), 'Color', color); % for varying day length (q3(ii))
    %plot (t*24/n,y(:,1), 'r'); % for varying day length (q3(ii))
    
    %plot (t,y(:,1)/ymax(:,1), 'r'); % Normalized to respective maximum (q2,q3)
    %plot (t,y(:,2)/ymax(:,2), 'b'); % Normalized to respective maximum (q2,q3)
    
   
    hours = hours+nighttime; % end of night shift
    ystart = y(end,:); % sets start values for new day

end % ends while loop plotting ODEs 


end

% %shading bars for short days (8L:16D)
% patch([8 24 24 8],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([32 48 48 32],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([56 72 72 56],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([80 96 96 80],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([104 120 120 104],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([128 144 144 128],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([152 168 168 152],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([176 192 192 176],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([200 216 216 200],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([224 240 240 224],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% set(gca,'children',flipud(get(gca,'children')))

% %shading bars for equal days (12L:12D)
% patch([12 24 24 12],[0.005 0.005 10 10], [1,1,1]*0.9, 'linestyle', 'none')
% patch([36 48 48 36],[0.005 0.005 10 10], [1,1,1]*0.9, 'linestyle', 'none')
% patch([60 72 72 60],[0.005 0.005 10 10], [1,1,1]*0.9, 'linestyle', 'none')
% patch([84 96 96 84],[0.005 0.005 10 10], [1,1,1]*0.9, 'linestyle', 'none')
% patch([108 120 120 108],[0.005 0.005 10 10], [1,1,1]*0.9, 'linestyle', 'none')
% set(gca,'children',flipud(get(gca,'children')))

% %shading bars for long days (16L:8D)
% patch([16 24 24 16],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([40 48 48 40],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([64 72 72 64],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([88 96 96 88],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% patch([112 96 96 112],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
% set(gca,'children',flipud(get(gca,'children')))

%shading bars every 24h for long cycles (8L:16D)
patch([24 48 48 24],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([72 96 96 72],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([120 144 144 120],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([168 192 192 168],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([216 240 240 216],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([264 288 288 264],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([312 336 336 312],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([360 384 384 360],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([408 432 432 408],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([456 480 480 456],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
set(gca,'children',flipud(get(gca,'children')))


%------------------------------------------------------------------
%unused code down here
%was line 32
%color = [0.5, 0, 0.5]+[((50-n)/50)^3, (sin((n/50)*pi))^3,((n)/50)^3]*0.499; 

%[t,y]=ode45(@Final_Q1,[hours/n:0.01:(hours+daytime)/n],ystart); %evaluates current day
