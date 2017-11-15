% 
% Questions 1 and 2, assignment 5 (Final)
clear all;
clf;

global v1 v1L v2A v2B v2L v3 v4; % units nM/h, Supplementary Table 1
global k1L k1D k2 k3 k4 p1 p1L p2 p3 p4; % units /h, Supplementary Table 1
global d1 d2D d2L d3D d3L d4D d4L ; % units /h, Supplementary Table 1
global K1 K2 K3 K4 K5 K6 K7 K8 K9 K10; % units nM, Supplementary Table 1
global period daytime nighttime; % in hours
global D L; % either 1 or 0 
global ymax; % for normalization

v1= 4.6; v1L= 3.0; v2A = 1.3; v2B = 1.5; v2L =5.0; v3 = 1.0; v4 = 1.5;
k1L=0.53; k1D=0.21; k2=0.35; k3=0.56; k4=0.57; p1=0.76; p1L=0.42; p2=1.0; p3=0.64; p4=1.0;
d1=0.68; d2D=0.50; d2L=0.30; d3D=0.48; d3L=0.78; d4D=1.2; d4L=0.38;
K1=0.16; K2=1.2; K3=0.24; K4=0.23; K5=0.3; K6=0.46; K7=2.0; K8=0.36; K9=1.9; K10=1.9;

period = 24;  % hours in a day
daytime = 8;
nighttime = period - daytime;


% % Initial conditions and normalization data for short days (8L:16D)
% ystart= [1.6446 1.7340 0.5207 0.6646 0.2194 0.5805 0.0001 0.0002 0.9918]; 
% ymax = [1.6830 2.0426 3.7918 8.9969 1.2626 1.5350 1.0964 1.4976 0.9918];
% hours = 0

% Initial conditions and normalization data for equal days (12L:12D)
ystart = [1.8549 1.7622 0.3607 0.4959 0.2726 0.7247 0.0011 0.0017 0.9727]; 
ymax = [1.8549 2.268 3.7028 8.7691 1.3722 1.5609 1.1555 2.4778 0.9727];
hours = 0


    
while hours < 480
    hold on
    L=1; D=0;
    %disp(ystart);

    [t,y]=ode45(@Final_Q1,[hours:0.01:hours+daytime],ystart); %evaluates current day
    %disp(ystart);
    %disp(y(end,:));
    disp(max(y(:,:)));
        
    axis([0 48 0 1])     
    title('Simulated expression profiles in short days(8L:16D)')
    %title('Simulated expression profiles for equal days(12L:12D)')
    %title('Simulated expression profiles in long days(16L:8D)')
    xlabel('ZT (hours)')
    ylabel('Relative abundance')
    
    %plot (t,y(:,1), 'r'); % to display raw abundance (q1)   
    plot (t,y(:,1)/ymax(:,1), 'r'); % Normalized to respective maximum (q2)
    %plot (t,y(:,2)/ymax(:,2), 'b'); % Normalized to respective maximum (q2)
    
    %also-ran plotting ideas since abandoned
    %plot(t,y(:,1)/max(y(:,1)), 'r'); 
    %plot(t,y/max(y(:,1)),'m');  % 
    %plot(t,y/max(y(:,2)),'r');  % 

    hours = hours+daytime; %starts new day
    ystart = y(end,:); %sets start values for new day
    
    D=1; L=0;
    [t,y]=ode45(@Final_Q1,[hours:0.01:hours+nighttime],ystart); %evaluates current day
    %disp(ystart);
    %disp(y(end,:));
    disp(max(y(:,:)));

    %plot (t,y(:,1), 'r'); % to display raw abundance (q1)
    plot (t,y(:,1)/ymax(:,1), 'r'); % Normalized to respective maximum (q2,q3)
    %plot (t,y(:,2)/ymax(:,2), 'b'); % Normalized to respective maximum (q2,q3)
    
    
    %also-ran plotting ideas since abandoned
    %plot (t,y(:,1)/max(y(:,1)), 'r');
    %plot(t,y/max(y(:,1)),'m');  % y1, MKKK
    %plot(t,y/max(y(:,2)),'r');  % y2, MKKK-P

    hours = hours+nighttime; %starts new day
    ystart = y(end,:); %sets start values for new day

end % ends while loop plotting ODEs 


%shading bars for short days (8L:16D)
patch([8 24 24 8],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([32 48 48 32],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([56 72 72 56],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([80 96 96 80],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
patch([104 96 96 104],[0.005 0.005 4 4], [1,1,1]*0.9, 'linestyle', 'none')
set(gca,'children',flipud(get(gca,'children')))

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

