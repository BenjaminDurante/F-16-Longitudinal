%stability_controller_design
clc; close all; clear all;
format short
A = [-0.0089 -0.1474 0 -9.75; -0.0216 -0.3601 5.9470 -0.151; 0 -0.00015 -0.0224 0.0006; 0 0 1 0];
B = [-2.682 9.748; 29 3.77; -3.847 -0.034; 0 0];
C = diag([1 1 1 1]);
I = diag([1 1 1 1]);
D = zeros(4,2);
%n = states, p = outputs, p2 = controlled outputs
n = 4; p = 4; p2 = 2; 

states = {'del u', 'del w', 'del q', 'del tht'};
inputs = {'thr', 'elev'};
outputs = {'del u', 'del w', 'del q', 'del tht'};

%state space model
sys_oloop = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);
sys_TF = tf(sys_oloop);

%TF1 = thrust to del_u, TF2 = elev to del_theta
TF1 = sys_TF(1,1);
TF2 = sys_TF(4,2);

%TF3 = thrust to del_theta, TF4 = elev to del_u
TF3 = sys_TF(1,2);
TF4 = sys_TF(4,1);

% subplot(1,2,1)
% step(TF1)
% ylabel('Delta u')
% subplot(1,2,2)
% step(TF2)
% ylabel('Delta theta')

%open-loop stability
r = eig(A);
for i = 1:length(r)
    if r(i) <= 0
        fprintf('Open Loop system is unstable at eig: %0.3f \n', r(i))
        P(i) = r(i);
    else
    end
end

%ctrb, obsv, stab, detect
R = rank(ctrb(A,B));
R2 = rank(obsv(A,C));
R3 = n+p2;

if R==4
    fprintf('System is controllable \n')
else
    fprintf('System is not controllable \n')
end
    
if R2==4
    fprintf('System is observable and detectable\n')
else
    fprintf('System is not observable \n')
end

for j = 1:length(r)
    if r(j) < 0
        if rank([r(j)*I-A B])==4
            fprintf('System is stabilizable at: %0.3f  \n' , r(j))
        end
    end
end
fprintf('\n')

%check for state feedback
if rank([A B; -C D])== R3
    fprintf('System is completely controllable via feedback \n')
end
    
%pole placement (will not use LQR) [-4 -6 -8 -9];
p = [-4 -6 -8 -9]; 
K = place(A,B,p);
norm = norm(transpose(K)*K);

%cloop 
sys_cl = ss(A-B*K,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

%look at TF again
sys_TFcl = tf(sys_cl);

%TF1 = thrust to del_u, TF2 = elev to del_theta
TF1_cl = sys_TFcl(1,1);
TF2_cl = sys_TFcl(4,2);

%TF3 = thrust to del_theta, TF4 = elev to del_u
TF3_cl = sys_TFcl(1,2);
TF4_cl = sys_TFcl(4,1);

%transmission zeros of Gcl(s)
ZEROS = tzero(sys_TFcl);
%for LQI (paper page 13)
for k = 1:length(ZEROS)
    if (ZEROS(k)) == 0
    fprintf('Transmission zeros present, cannot use LQI')
    end
end

%initialize trim values {S.I. UNITS}
u_tr = 155;
w_tr = 0;
tht_tr = 6.30*(pi/180); %rad
ZE_0 = -2000;
XE_0 = 0;

%runway heading (deg)
h = 57.3;






