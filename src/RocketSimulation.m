clear all; close all, clc;

%% dimensions
M = 3000;              % mass of the rocket [kg]
L = 15;                % length of the rocket [m]
r = 0.25;              % width of the rocket [m]
g = 9.8;              % gravity constant [m/s^2]
% F1 = 1;            % F1 thrust value [N] Controlled by PI controller
F2 = 0;
T = 55000;
I = (1/12)*M*(3*r^2 + L^2); % Mass moment of inertia [kg-m^2]
p = 1.225 ; % kg / m^3
Cd = 0.25 ; % coefficient of drag
A = 3.14*r^2 ; % cross-sectional area of circle rocket body

%%Intial conditions
Xi = 0;       % intial position of xg
Yi = 0;       % intial position of yg
thetai = 0;    % intial theta position 
Xidot = 0;    % intial x velocity
Yidot = 0;    % intial y velocity
thetaidot = 0; % intial theta dot

%%PID Controller Parameters
thetaref = 30*(3.14/180); % deg * deg to radians
Kp = 90; % proportional gain
Ki = 12; % integral gain

%% Simulation parameters
tf = 10;   % plot of x from t=0 to t=tf (s)
dt = 0.005; % time-step (s)

%% Run simulink
sim('RocketSimulation_sim');  %% run simulink
simoutput = ans;    %% save simulink answers

%% Plot simulink data
figure(1); hold on; grid on; 
subplot(4,1,1); hold on; grid on; 
plot(simoutput.tout,simoutput.xarray);  %% plot of x vs t
legend('x');
xlabel('time (s)');
ylabel('meters (m)');

subplot(4,1,2); hold on; grid on; 
plot(simoutput.tout,simoutput.yarray);  %% plot of y vs t
legend('y');
xlabel('time (s)');
ylabel('meters (m)');

subplot(4,1,3); hold on; grid on; 
plot(simoutput.tout,simoutput.F1array);  %% plot of F1 vs t
legend('F1');
xlabel('time (s)');
ylabel('Force (N)');

subplot(4,1,4); hold on; grid on; 
plot(simoutput.tout,simoutput.thetaarray*(180/3.14));  %% plot of theta vs t
plot(simoutput.tout,simoutput.thetarefarray*(180/3.14));  %% plot of thetaref vs t
legend('theta', 'thetaref');
xlabel('time (s)');
ylabel('degrees');
