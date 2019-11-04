%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% MAE 290A HW 1: Mitchell Truss %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear;

b = 20;
s = 0;
q = 10;
p = 5; 
dim = 2;

% NODES
Nx = [1 .743 .743 .531 .575 .531 .363 .428 .428 .363 .233 .305 .33 .305 .233];
Ny = [0 .148 -.148 .22 0 -.22 .242 .085 -.085 -.242 .233 .126 0 -.126 -.233];
N = [Nx' Ny'];
Q = N(1:10,:)';
P = N(11:15,:)';

% GENERATE CONNECTIVITY MATRIX
i = (1:b)';
j = [1 2 3 4 4 5 6 7 7 8 8 9 10 11 11 12 12 13 13 14]';
j = j+1;
k = reshape([1:10 ; 1:10],[],1);
C = zeros(b,length(N));                 % Populate connectivity
for n = 1:b
    C( i(n) , j(n) ) = -1;
    C( i(n) , k(n) ) = 1;
end

% FORCES
U = zeros(2,length(Q));
U(:,1) = [0 ; -10];

% CALCULATE TENSEGRITY STATICS AND PLOT RESULTS
[c_bars, t_strings, V] = tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); 
grid on; xlabel('x'),ylabel('y');
title('Mitchell Truss: Vertical Load at Node 1')
legend('Bars');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%