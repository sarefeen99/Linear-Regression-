close all
clear all
clc

%% Linear Regression w/ Closed Form Solution

load carbig;
Weight(isnan(Horsepower(:,1)),:) = [];
Horsepower(isnan(Horsepower(:,1)),:) = [];
t = Horsepower (:,1);
x = Weight (:,1);
J = [x ones(length(x),1)];
W1 = (inv(J'*J)) * (J'*t);  
LR = J * W1;
scatter(x, t, 'x', 'r');
hold on;
z = plot(x, LR, 'b');
figure(1)
xlabel('Weight');
ylabel('Horsepower');
title('Matlab "Carbig" Data');
grid on;
legend (z, 'Closed Form');

%% Gradient Descent Method


W2= [60 10]';
Learning_Rate= 0.001;
x_norm = [J(:,1)./(max(x)) J(:,2)];
t_norm = t/(max(t));
loop = [1 1]'
while (loop(1) >= 10^-9 && loop(2) >= 10^-9)
     Old_W2 = W2;
     W2 = W2-Learning_Rate*(2*(x_norm')*(x_norm*W2-t_norm));
     loop = abs(W2-Old_W2);
end
GD = (x_norm * W2).* max(t);
figure(2);
scatter(x, t, 'x', 'r');
hold on;
A = plot (x, GD, 'g');
xlabel('Weight');
ylabel('Horsepower');
title('Matlab "Carbig" Data');
grid on;
legend (A, 'Gradient Decent');

