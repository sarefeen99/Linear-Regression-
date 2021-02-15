close all;
clear all;
clc;
%%
rng(19);
k = 1;

for i = [10 100]
    N_train = i;
    X_train = rand(N_train,1);
    eps = normrnd(0,0.3,N_train,1);
    t_train = sin(2*pi*X_train);
    t_train = t_train + eps;
% t_train = (t_train - min(t_train))/(max(t_train) - min(t_train));

    N_test = 100;
    X_test = rand(N_test,1);
    eps2 = normrnd(0,0.3,N_test,1);
    t_test = sin(2*pi*X_test);
    t_test = t_test + eps2;
% t_test = (t_test - min(t_test))/(max(t_test) - min(t_test));

        t_train_reg = [];
        t_test_reg = [];
        delta_train = [];
        delta_test = [];
for m=0:9
    [beta, S1] = polyfit(X_train, t_train, m);
    [new_row, delta1] = polyval(beta, X_train, S1);
    t_train_reg = [t_train_reg
                    new_row'];
    delta_train = [delta_train
                    sqrt(mean(delta1))];
   
    [new_row_test, delta2] = polyval(beta, X_test, S1);            
    t_test_reg = [t_test_reg
                new_row_test'];
    delta_test = [delta_test
                    sqrt(mean(delta2))];
end

% error calculation
t_train = t_train';
new_t_train = repmat(t_train,10,1);
error = (new_t_train-t_train_reg).^2;
mean_train = mean(error');
rms_train = sqrt(mean_train);

t_test = t_test';
new_t_test = repmat(t_test,10,1);
error = (new_t_test-t_test_reg).^2;
mean_test = mean(error');
rms_test = sqrt(mean_test);

%plot
figure(k);
k = k+1;
plot (0:9, rms_train, '-o');
hold on; grid on;
plot (0:9, rms_test, '-x');
ylim([0 1]);
xlim([-1 10]);
xlabel('M');
ylabel('Erms');
legend('Training','Test');
end