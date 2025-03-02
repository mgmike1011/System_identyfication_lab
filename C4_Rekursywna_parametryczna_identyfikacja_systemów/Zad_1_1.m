clear all; close all;
% Zad 1.1.1

% Zad 1.1.2
% Zapis w postaci regresji liniowej: 
    % y(n) = [-y(n-1) -y(n-2) u(n-2) e(n-1)]*[a1; a2; b2; c1] + e(n)
    
% Zad 1.1.3
Tp = 0.1; % [s] - okres pr�bkowania
Tend = 1000; % [s] - horyzont czasowy symulacji 
Td = 1500; % [s] - czas zmiany parametru b2

% Zad 1.1.4
% Deklaracja zmiennych
global c1o;
c1o = 0;
% Symulacja
global P1_ p1_
P1_ = eye(3);
p1_ = [0;0;0];
sim('SystemARMAX.mdl')
% Dane z symulacji
u = simout(:,1);
y = simout(:,2);
% Parametry 
y1 = 0;
y2 = 0;
u2 = 0;
u1 = 0;
P1 = eye(3);
p1 = [0;0;0];
b2o = simout(:,3);
yo = simout(:,4);
% Wektor estymat
p = zeros(3,length(u)); 
% Przebieg �ladu macierzy P^(LS):
P_trace = trace(P1);
for i = 1:length(u)
    fi = [-y1;-y2;u2]; % Regresor
    P = P1 - (((P1*fi)*fi'*P1)/(1+fi'*P1*fi)); % Macierz kowariancyjna
    k = P*fi; % Wzmocnienie
    E = y(i)-fi'*p1; % B��d predykcji jednokrokowej
    p_ = p1 + k*E; % Wektor parametr�w 
    p(1,i) = p_(1);
    p(2,i) = p_(2);
    p(3,i) = p_(3);
% Aktualizacja danych
    p1 = p_;
    P1 = P;
    y2 = y1;
    y1 = y(i);
    u2 = u1;
    u1 = u(i);
    P_trace = [P_trace; trace(P)];
end
% Symulator
t = Tp*(0:length(u)-1);
ym = lsim(filt([0 0 p_(3)],[1 p_(1) p_(2)],Tp),u,t);
% Predyktor jednokrokowy:
yn = (1 - (1 + (p(1,end))*[0;y(1:end-1)] + p(2,end)*[0;0;y(1:end-2)])) + ((p(3,end))*[0;0;u(1:end-2)]); 
% Wy�wietlenie danych:
subplot(3,1,1)
plot(u)
hold on
plot(y)
grid on
hold off
legend('u(n)','y(n)')
subplot(3,1,2)
plot(p(1,:))
hold on
plot(p(2,:))
plot(p(3,:))
hold off
legend('a1','a2','b2')
subplot(3,1,3)
grid on
plot(y)
hold on
plot(simout(:,4))
plot(ym)
grid on
plot(yn)
legend('y(n)','yo(n)','ym','yn')
%sgtitle('Wyniki identyfikacji')
% Zad 1.1.5
    % dla ro = 1
p_hat_LS_ro_1 = p;
    % dla ro = 10

% Parametry 
y1 = 0;
y2 = 0;
u2 = 0;
u1 = 0;
P1 = 10*eye(3);
p1 = [0;0;0];
% Wektor estymat
p = zeros(3,length(u)); 
for i = 1:length(u)
    fi = [-y1;-y2;u2]; % Regresor
    P = P1 - (((P1*fi)*fi'*P1)/(1+fi'*P1*fi)); % Macierz kowariancyjna
    k = P*fi; % Wzmocnienie
    E = y(i)-fi'*p1; % B��d predykcji jednokrokowej
    p_ = p1 + k*E; % Wektor parametr�w 
    p(1,i) = p_(1);
    p(2,i) = p_(2);
    p(3,i) = p_(3);
% Aktualizacja danych
    p1 = p_;
    P1 = P;
    y2 = y1;
    y1 = y(i);
    u2 = u1;
    u1 = u(i);
end
p_hat_LS_ro_10 = p;
    % dla ro = 0.1
    % Parametry 
y1 = 0;
y2 = 0;
u2 = 0;
u1 = 0;
P1 = 0.10*eye(3);
p1 = [0;0;0];
% Wektor estymat
p = zeros(3,length(u)); 
for i = 1:length(u)
    fi = [-y1;-y2;u2]; % Regresor
    P = P1 - (((P1*fi)*fi'*P1)/(1+fi'*P1*fi)); % Macierz kowariancyjna
    k = P*fi; % Wzmocnienie
    E = y(i)-fi'*p1; % B��d predykcji jednokrokowej
    p_ = p1 + k*E; % Wektor parametr�w 
    p(1,i) = p_(1);
    p(2,i) = p_(2);
    p(3,i) = p_(3);
% Aktualizacja danych
    p1 = p_;
    P1 = P;
    y2 = y1;
    y1 = y(i);
    u2 = u1;
    u1 = u(i);
end
p_hat_LS_ro_01 = p;
% Wy�wietlenie:
figure
subplot(3,1,1)
plot(p_hat_LS_ro_1(1,:))
hold on
plot(p_hat_LS_ro_1(2,:))
plot(p_hat_LS_ro_1(3,:))
hold off
title('1')
legend('a1','a2','b2')
subplot(3,1,2)
plot(p_hat_LS_ro_10(1,:))
hold on
plot(p_hat_LS_ro_10(2,:))
plot(p_hat_LS_ro_10(3,:))
hold off
title('10')
legend('a1','a2','b2')
subplot(3,1,3)
plot(p_hat_LS_ro_01(1,:))
hold on
plot(p_hat_LS_ro_01(2,:))
plot(p_hat_LS_ro_01(3,:))
hold off
title('0.1')
legend('a1','a2','b2')
%sgtitle('Por�wnanie metod estymacji dla r�nych warunk�w pocz�tkowych ro')
% Zad 1.1.6
figure
plot(P_trace)
title('�lad macierzy P^{LS} podczas estymacji')

% Zad 1.1.7
    % Model symulowany:
ym_biezace = zeros(1,length(u));
for i = 1:length(u)
    out = lsim(filt([0 0 p(3,i)],[1 p(1,i) p(2,i)],Tp),u,t);
    ym_biezace(i) = out(i);
end
    % Predyktor jednokrokowy:
yn_biezace = zeros(1,length(u));
y1__ = [0;y];
y2__ = [0;0;y];
u2__ = [0;0;u];
for i=1:length(u)
    A = 1 + p(1,i)*y1__(i) + p(2,i)*y2__(i);
    B = p(3,i)*u2__(i);
    yn_biezace(i) = (1-A)+B;
end
% Wy�wietlenie wynik�w:
figure
subplot(3,1,1)
%sgtitle('Zad 1.1.7 - por�wnanie wynik�w')
plot(ym_biezace)
hold on
plot(yo)
legend('ym','yo')
title('Odpowiedz modelu symulowanego ym(n) z odpowiedzia niezak��cona yo(n)')
subplot(3,1,2)
plot(yn_biezace)
hold on
plot(y)
legend('y(n|n-1)','y')
title('Odpowiedz predyktora jednokrokowego ?y(n|n ? 1) z zak��cona odpowiedzia y(n) systemu')
subplot(3,1,3)
plot(ym_biezace)
hold on
plot(y)
legend('ym','y')
title('Odpowiedz modelu symulowanego ym(n) z odpowiedzia y(n) systemu.')