

% Modified system for weak delay kernel

function F = Final_Q4(t,y)
% y will be a vector holding 9 reactions, t is time
% Note variables come in pairs except for [P]

% y(1)= [CL]_m -- this is still true post modification
% y(10)=I -- this is a new variable required by the linear chain trick 
% y(2)= [CL]_p 

% y(3)= [P97]_m
% y(4)= [P97]_p

% y(5)= [P51]_m
% y(6)= [P51]_p

% y(7)= [EL]_m
% y(8)= [EL]_p

% y(9)= [P]

% sources and units for global variables in Final_Q1b.m
global v1 v1L v2A v2B v2L v3 v4;            
global k1L k1D k2 k3 k4 p1 p1L p2 p3 p4;
global d1 d2D d2L d3D d3L d4D d4L ;
global K1 K2 K3 K4 K5 K6 K7 K8 K9 K10;
global period;
global D L;
global A  %new constant Alpha = 1/average delay

%[CL] = CCA1 and LHY ARE NOW MODIFIED:
dy1dt = (v1+v1L*L*y(9))*(1/(1+(y(4)/K1)^2 + (y(6)/K2)^2))-(k1L*L+k1D*D)*y(10);
dy2dt = (p1+p1L*L)*y(10) - d1*y(2);

%I = NEW EQUATION
dy10dt= A*y(1) - A*y(10);

%[P97] = PRR9 and PRR7
dy3dt = (v2L*L*y(9)+v2A+  v2B*(y(2)^2/(K3^2+y(2)^2)))* (1/(1+(y(6)/K4)^2 + (y(8)/K5)^2)) - k2*y(3);
dy4dt = p2*y(3)-(d2D*D + d2L*L)*y(4);

%[P51] = PRR5 and TOC1
dy5dt = v3*(1/(1+(y(2)/K6)^2 + (y(6)/K7)^2)) - k3*y(5);
dy6dt = p3*y(5)-(d3D*D + d3L*L)*y(6);

%[EL] = ELF4 and LUX
dy7dt = L*v4*(1/(1+(y(2)/K8)^2 + (y(6)/K9)^2 + (y(8)/K10)^2 )) - k4*y(7);
dy8dt = p4*y(7) - (d4D*D + d4L*L)*y(8);

% dark accumulating protein [P]
dy9dt = 0.3*(1-y(9))*D-y(9)*L;


F = [dy1dt; dy2dt; dy3dt; dy4dt; dy5dt; dy6dt; dy7dt; dy8dt; dy9dt; dy10dt];
end