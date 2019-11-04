%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% MAE 290A HW 1: Nonminimal 4-bar Prism %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SETUP
clc; clear; close all;

% Geometry
    b = 4;
    s = 20;
    q = 4;
    p = 4;
    dim = 3;
    m = b+s;
    
% CONNECTIVITY
    J = [1:4 1:8 2,3,4 1,3,4 1,2,4 1,2,3];
    K = [5:8 2,3,4,1 6,7,8,5 5,5,5 6,6,6 7,7,7 8,8,8];
    C = zeros(m,q);
    for i = 1:m
        C( i , J(i) ) = -1;
        C( i , K(i) ) = 1;
    end
    clear i;

% FORCES
    U = zeros(dim,q);
    U(3,1:4) = [-10;-10;-10;-10];

%% NODES
    % Base Square
        P = [1 1 0
             -1 1 0
             -1 -1 0
             1 -1 0]';
    % Rotated top
        % Loop through various twist angles to determine behavior
            a_range = 175 %[134:.2:138, 175]; % degrees
            c_vec = zeros(1,length(a_range)); % initial vector of bar compressions
            t_vec = zeros(1,length(a_range));
        for i = 1:length(a_range)
            clc;
            % calculate top points
            a = a_range(i)*pi/180; % radians
            R = [cos(a) -sin(a) 0
                 sin(a)  cos(a) 0
                 0       0      1];
            T = [0 0 0 0 ; 0 0 0 0 ; 1 1 1 1];
            % counterclockwise rotation of angle t and upward translation of 1
            Q = R*P + T;  
            % Calculate tensegrity statistics
                [c_bars, t_strings, V] = tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
                slack = 0;
                if any(t_strings <= 0) ~= 0
                    slack = 1; 
                end
                c_vec(i) = c_bars(1);
                t_vec(i) = slack;
        end
        figure;
        plot(a_range(1:end-1),c_vec(1:end-1),'r','linewidth',1.5); % plot bar compression values
        grid on; xlabel('Twist Angle of Top \alpha (deg.)'),ylabel('Ratio of Bar Compression to Applied Force (non-dim.)');
        title('Variation of Bar Compression with Relative Prism Twist Angle');    
        
        
        
        
        
% VISUALIZE TENSEGRITY SYSTEM for a specific case
figure;
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); 
grid on; xlabel('x'),ylabel('y'),zlabel('z');
ttl = ['Nonminimal 4-bar Prism: Vertical Load at Each Top Node: \alpha = ' num2str(a_range(end)) char(176)];
title(ttl);