clear all; clc;
%G�sto�ci widmowe mocy N - elementowych sekwencji sygna��w

%Dane:
Tp = 0.001; %okres pr�bkowania
H = tf([0.1],[1 -0.9],Tp); 
N = 2000; % Defaultowa warto��

sigma_kwadrat = 0.64; %z zadania 1.3
sigma = sqrt(sigma_kwadrat); 

x = zeros(1,N);
v = zeros(1,N);

tn = (0:N-1)*Tp;

%Sygna�y (sko�czone sekwencje ich pr�bek):
e = sigma * randn(1,N); %szum bia�y 
for n = 1:N
    x(n) = (sin(2*pi*5*n*Tp) + 0.5*sin(2*pi*10*n*Tp) + 0.25*sin(2*pi*30*n*Tp));
    v = (lsim(H,e,tn))'; %transpozycja aby by� wymiar 1x2000

    e_auto_korelacja(n)=Covar([e' e'], n-1); %autokorelacja do dalszych zada�, 
    %Covar przy zakomentowanej roznicy warto�ci �rednich okre�la korelacj� 
end 
    
% 2.1.1 Wy�wietlanie wykres�w:
subplot(3,1,1)
plot(e)
title('Szum bia�y e(n)')
subplot(3,1,2);
plot(x)
title('Spr�bkowany w czasie sygna� - x(nTp)')
subplot(3,1,3)
plot(v)
title('Szum kolorowy')

% 2.1.2 Obliczenie i wy�wietlenie dyskretnego widma amplitudowego:
DFT = fft(x); % Dla Tp = 1
DFT_Tp = Tp*DFT; % Wynik wymno�ony *Tp
m = abs(DFT_Tp); % |X_N|
m2 = abs(DFT); %do kropki 4 
f = 0:1/(Tp*N):(1/Tp - 1/(Tp*N)); %wektor cz�stotliwo�ci

% Przeskalowane modu�y, aby uzyska� zgodno�� wysoko�ci pr��k�w z A
% sk�adowych sinusoidalnych:
przeskalowane_XN = (2*m/(N*Tp)); 

figure
subplot(2,1,1)
plot(f,m)
title('DFT (XN) nieprzeskalowane')
subplot(2,1,2)
plot(f, przeskalowane_XN)
title('Przeskalowane modu�y X_N')

%Interpretacja wynik�w zadania 2.1.2:
%Dlaczego nieprzeskalowane i przeskalowane s� takie same?

% 2.1.3 Wp�yw N na jako�� widma amplitudowego:
% Wnioski dla N = 1000
% Wnioski dla N = 200
% Wnioski dla N = 100

% 2.1.4. Spe�nienie twierdzenia Parsevala (je�li s� sobie r�wne - spe�nione twierdzenie):
sum_x2=sum(x.^2);
E_1 = Tp*sum_x2; %ca�kowita energia, wz�r pierwszy po znaku r�wna si�

periodogram=m2.^2/(N); % estymator - periodogram
sum_per=sum(periodogram); % suma, wz�r na ca�kowit� energi�

%Wniosek: warto�ci s� sobie r�wne, spe�nione jest twierdzenie Parsevala

% 2.1.5 Estymatory (14) i (16) - g�sto�� widmowa:
%Estymator (14) - periodogram:
fe_periodogeam = fft(e);
e_m = abs(fe_periodogeam);
gestosc_periodogram_e=e_m.^2/(N*Tp); % estymator g�sto�ci widmowej mocy - periodogram

%Estymator (16) wyznaczany metod� korelogramow� - okno prostok�tne:

Mw = N/5; % zalecane wg instrukcji

z = zeros(N-Mw);
o = ones(Mw);
okno_prostok = [o(1,:) z(1,:)];
%okno_prostokatne = rectwin(Mw);
for k=0:N-1
    omega_k(k+1) = ((2*pi)/N)*k;
    %fe_okno2 = sum(e_auto_korelacja.*okno_prostok*ep)
end
fe_okno = fft(e_auto_korelacja.*okno_prostok, N);
gestosc_okno_e=abs(fe_okno);

figure
subplot(2,1,1)
plot(gestosc_periodogram_e)
title('G�sto�� widmowa mocy - estymator (14)')
subplot(2,1,2)
plot(gestosc_okno_e)
title('G�sto�� widmowa mocy - estymator (16) - okno prostok�tne')

% Jaki wp�yw ma warto�� wariancji ?^2 szumu na estymat� g�sto�ci widmowej mocy
