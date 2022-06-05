% Identyfikacja parametrow modelu czasu dyskretnego metoda LS
clear variables; clc;

% Zaladowanie danych
load('dane_.mat')

% Podstawowe dane
Tp = 0.01; % [s] Okres pr�bkowania
N = length(u_); % Ilo�� pr�bek w eksperymencie
d = 3; % Liczba parametrow
% t_, y_, u_ - czas, odpowiedz, pobudzenie z danych

% Podzia� danych pomiarowych na 2 podzbiory
Z_est_u = u_(1:(length(u_)/2)); % Dane estymuj�ce u 
Z_est_y = y_(1:(length(u_)/2)); % Dane estymuj�ce y 

Z_wer_u = u_((1+(length(u_)/2)):end); % Dane weryfikuj�ce u 
Z_wer_y = y_((1+(length(u_)/2)):end); % Dane weryfikuj�ce y 

N_est = length(Z_est_u);
N_wer = length(Z_wer_u);
%% Delta +
% Identyfikacja parametr�w metod� LS:
    % Regresor
y_n_1 = [0;Z_est_y(1:end-1)];
y_n_2 = [0;0;Z_est_y(1:end-2)];
u_n_2 = [0;0;Z_est_u(1:end-2)];
fi_C = [y_n_1,-y_n_2,u_n_2];
% fi_C = zeros(N_est,3);
% for i = 3:N_est
%     fi_C(i, :) = [Z_est_y(i-1), -Z_est_y(i-2), Z_est_u(i-2)];
% end
    % Estymator LS parametrow modelu
p_N_LS = pinv(fi_C)*Z_est_y;
%% Tustin
y_n_1 = [0;Z_est_y(1:end-1)];
y_n_2 = [0;0;Z_est_y(1:end-2)];
u_n_2 = [0;0;Z_est_u(1:end-2)];
u_n_1 = [0;Z_est_u(1:end-1)];
u_n = Z_est_u;
u_n_cal = u_n_2+2.*u_n_1+u_n;
fi_C = [y_n_1,-y_n_2,u_n_cal];
    % Estymator LS parametrow modelu
p_N_LS = pinv(fi_C)*Z_est_y;