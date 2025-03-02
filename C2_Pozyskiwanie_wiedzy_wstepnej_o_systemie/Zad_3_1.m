clear variables, close all; %clc;
%% 3.1.2 Zebranie danych pomiarowych i wy�wietlenie w dziedzinie czasu:
sim('AWident_2015'); %Zebranie danych
u = Zdata(:,1)';
y = Zdata(:,2)';
t = (0:N-1)*Tp;
% Wy�wietlenie:
subplot(2,1,1)
plot(t,u)
axis([0 max(t) min(u) max(u)])
xlabel('Czas t')
grid on
title('Sygna� u(t)')
subplot(2,1,2)
plot(t,y)
axis([0 max(t) min(y) max(y)])
xlabel('Czas t')
grid on
title('Sygna� y(t)')
%sgtitle('Odpowiedzi czasowe')
%% 3.1.3 Przeprowadzi� nieparametryczn� identyfikacj� systemu czasu ci�g�ego
% Dla wzoru 15:
DFT_Y = fft(y)*Tp;
DFT_U = fft(u)*Tp;
G_N_gwiazdka = zeros(1,1001);
for i = 1:1001
    G_N_gwiazdka(i) = DFT_Y(i)/DFT_U(i);
end
k = 0:1:(N-1)/2;
wk = ((2*pi)/N)*k; %Wektor warto�ci omega
Lm_G_N_gwiazdka = 20*log10(abs(G_N_gwiazdka(1:501)));
fi_G_N_gwiazdka = angle(G_N_gwiazdka(1:501));
% Charakterystyka Bodego:
subplot(2,1,1)
semilogx(wk,Lm_G_N_gwiazdka);
grid on
title('Lm(w)')
xlabel('w')
subplot(2,1,2)
semilogx(wk,fi_G_N_gwiazdka)
grid on
title('fi(w)')
xlabel('w')
%sgtitle('G_N* - wz�r 15') %zakomentowane dla bieda wersji 2016:(
% Dla wzoru 16
Mw = 200; %Okno Hanninga
ruu = xcorr(u);
ryu = xcorr(y,u);
k = 0:1:(N-1);
wk = ((2*pi)/N)*k; %Omega_k
% Ruu = [ruuP(1:Mw+1) zeros(1,2*N-2*Mw-2) ruuP(Mw+1:-1:2)]

% Okno Hanninga


