%Initialize the constants for the RCAM Simulation:
clear
clc
close all 

%%Define Constants:
x0 = [85;     %Approximately 165 knots
      0;
      0;
      0;
      0;
      0;
      0.1;
      0;    %Approximately 5.73 degrees
      0];

u = [0;
    -0.1;     %Approximately -5.73 degrees
     0;
     0.08;    %Recall minimum for throttles are 0.5*(pi/180) = 0.0087
     0.08];

TF = 60;      %Final Simulation Time


%Define max/min control values:
umin(1) = -25; % Min aileron deflection [deg]
umax(1) = 25;  % Max aileron deflection [deg]
umin(2) = -25; % Min stabilizer deflection [deg]
umax(2) = 10;  % Max stabilizer deflection [deg]
umin(3) = -30; % Min rudder deflection [deg]
umax(3) = 30;  % Max rudder deflection [deg]
umin(4) = 0.5; % Min throttle setting (engine 1) [deg]
umax(4) = 10;  % Max throttle setting (engine 1) [deg]
umin(5) = 0.5; % Min throttle setting (engine 2) [deg]
umax(5) = 10;  % Max throttle setting (engine 2) [deg]

umin = deg2rad(umin);
umax = deg2rad(umax);

%Run the model:
res = sim("RCAMSimulation.slx");

%% Plot Results
%% Plot Results
t = res.tout;

u_res = res.simU.Data;
x_res = res.simX.Data;

% Names of controls
control_names = ["dA (Aileron deflection)", ...
                 "dT (Stabilizer deflection)", ...
                 "dR (Rudder deflection)", ...
                 "dth1 (Throttle - Engine 1)", ...
                 "dth2 (Throttle - Engine 2)"];

% Names of states
state_names = ["u (Longitudinal Velocity)", ...
               "v (Lateral Velocity)", ...
               "w (Vertical Velocity)", ...
               "p (Roll rate)", ...
               "q (Pitch rate)", ...
               "r (Yaw rate)", ...
               "phi (Bank angle)", ...
               "theta (Pitch angle)", ...
               "psi (Heading angle)"];

% Plot Control History
figure('Name', 'Control History')
for i = 1:5
    subplot(5, 1, i)
    plot(t, u_res(:, i))
    legend(control_names(i))
    title(control_names(i))
    grid on
end

% Plot State History
figure('Name', 'State History')
for i = 1:9
    subplot(3, 3, i)
    plot(t, x_res(:, i))
    legend(state_names(i))
    title(state_names(i))
    grid on

end

