% 1.3
N = 2000;
sigma_kwa = 0.64;
Tp = 0.001;
sigma = sqrt(sigma_kwa);
e = sigma*randn(1,N);
x = zeros(1,N);
y = zeros(1,N);
v = zeros(1,N);
H = tf(0.1,[1 -0.9],Tp);
tn = (0:N-1)*Tp;
tn(1) = 0;
for n = 1:N
    x(n) = sin(2*pi*5*n*Tp);
    y(n) = sin(2*pi*5*n*Tp)+e(n);
end
    v = lsim(H,e,tn);
%     v(n) = v_(n);
% Wy�wietlenie sygna��w
figure
subplot(2,1,1)
plot(y)
hold on
plot(x)
hold off
legend('y','x')
subplot(2,1,2)
plot(v)
legend('v')
% Warto�ci estymatora funkcji autokorelacji estymator obciazony:
[rxx,rxxx] = xcorr(x);
[ryy,ryyy] = xcorr(y);
[rvv,rvvv] = xcorr(v);
[ree,reee] = xcorr(e);
% Wy�wietlenie wynik�w:
N = length(rxx);
N_ = (-N+1):(N);
figure
subplot(4,1,1)
plot(rxxx,rxx)
title('xcorr(x)')
subplot(4,1,2)
plot(ryyy,ryy)
title('xcorr(y)')
subplot(4,1,3)
plot(reee,ree)
title('xcorr(e)')
subplot(4,1,4)
plot(rvvv,rvv)
title('xcorr(v)')
% Sprawdzi� r�nice w przebiegu funkcji autokorelacji przy zastosowaniu estymatora obci��onego i nieobci��onego.
[rxx_nieob,rxxx_nieob] = xcorr(x,'unbiased');
[ryy_nieob,ryyy_nieob] = xcorr(y,'unbiased');
[rvv_nieob,rvvv_nieob] = xcorr(v,'unbiased');
[ree_nieob,reee_nieob] = xcorr(e,'unbiased');
figure
subplot(4,1,1)
plot(rxxx_nieob,rxx_nieob)
title('xcorr(x) Nieobciazony')
subplot(4,1,2)
plot(ryyy_nieob,ryy_nieob)
title('xcorr(y)')
subplot(4,1,3)
plot(reee_nieob,ree_nieob)
title('xcorr(e)')
subplot(4,1,4)
plot(rvvv_nieob,rvv_nieob)
title('xcorr(v)')
% Por�wna� przebieg estymaty funkcji autokorelacji v z e:
figure
plot(ree)
hold on
plot(rvv)
hold off
legend('xcorr(e)','xcorr(v)')
% Dla x i y obliczy� i wykre�li� korelacj� wzajemn� 
[ryx,ryx_]=xcorr(y,x);
figure
plot(ryx_,ryx)
title('Korelacja wzajemna ryx')