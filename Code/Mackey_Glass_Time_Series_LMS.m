clc
clear all
close all

%% Load Mackey Glass Time series data
load Dataset\Data.mat 

%% Training and Testing datasets
% For training
Tr=1:4000;    % First 4000 samples for training
Xr(Tr)=Data(Tr);      % Selecting a chuck of series data x(t)
% For testing
Ts=4000:5000;   % Last 1000 samples for testing
Xs(Ts)=Data(Ts);      % Selecting a chuck of series data x(t)

%% LMS Parameters
% We run the LMS algorithm for different learning rates
etaValues = [5e-4 1e-3 5e-3 0.01]; % Learning rate
M=5;    % Order of LMS filter
W_init=randn(M+1,1); % Initialize weights

figure(2)
plot(Tr(2*M:end-M),Xr(Tr(2*M:end-M)));      % Actual values of mackey glass series

figure(3)
plot(Ts,Xs(Ts));        % Actual unseen data

for eta = etaValues
      
    U=zeros(1,M+1); % Initialize values of taps
    W=W_init; % Initialize weights
    E=[];         % Initialize squared error vector
    
    %% Learning weights of LMS (Training)
    for i=Tr(1):Tr(end)-1
        U(1:end-1)=U(2:end);    % Shifting of tap window
        U(end)=Xr(i);           % Input (past/current samples)
        
        Y(i)=W'*U';             % Predicted output
        e(i)=Xr(i+1)-Y(i);        % Error in predicted output

        W=W+eta*e(i)*U';     % Weight update rule of LMS

        E(i)=e(i).^2;   % Concatenate current squared error
    end

    %% Prediction of a next outcome of series using previous samples (Testing)
    for i=Ts(1):Ts(end)
        U(1:end-1)=U(2:end);    % Shifting of tap window
        U(end)=Xs(i);           % Input (past/current samples)

        Y(i)=W'*U';             % Calculating output (future value)
        e(i)=Xs(i)-Y(i);        % Error in predicted output

        E(i)=e(i).^2;   % Current mean squared error (MSE)
    end
    
    % Plot the squared error over the training sample iterations
    figure(1),hold on;
    plot(Tr(1:end-1),E(:,Tr(1:end-1)));   % MSE curve
    hold off;
    
    % Plot the predicted training data
    figure(2), hold on;
    plot(Tr(2*M:end-M),Y(Tr(2*M:end-M))')   % Predicted values during training
    hold off;


%   Comment out the following parts to plot prediction of the test data    
    figure(3), hold on; 
    plot(Ts(2*M:end),Y(Ts(2*M:end))');  % Predicted values of mackey glass series (testing)
    hold off;
    
    MSEtr= mean(E(Tr));  % MSE of training
    MSEts= mean(E(Ts));  % MSE of testing

    disp(['MSE for test samples (Learning Rate: ' num2str(eta) '):' num2str(MSEts)]);
    
end

% Add labels after all the graphs are plotted for the first figure
figure(1);
grid minor;
title(['Training error for different learning rates  (#Taps=' num2str(M) ')']);
xlabel('Iterations (samples)');
ylabel('Squared Error');
legend({num2str(etaValues')});

figure(2);
legend('Training Phase (desired)',['Predicted (Learning Rate:' num2str(etaValues(1)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(2)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(3)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(4)) ')']);
xlabel('Time: t');
ylabel('Output: Y(t)');
title(['Predicted and Actual Values during Training (M=' num2str(M) ')'])

figure(3);
 xlabel('Time: t');
ylabel('Output: Y(t)');
% legend('Actual (Training)','Predicted (Training)','Actual (Testing)','Predicted (Testing)');
title(['Predicted and Actual Values of Test Data(M=' num2str(M) ')'])
ylim([min(Xs)-0.5, max(Xs)+0.5])
legend('Test Phase (desired)',['Predicted (Learning Rate:' num2str(etaValues(1)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(2)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(3)) ')']...
    ,['Predicted (Learning Rate:' num2str(etaValues(4)) ')']); 
