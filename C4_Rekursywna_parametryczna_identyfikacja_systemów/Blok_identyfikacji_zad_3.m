function p_out = Blok_identyfikacji_zad_3(u_in)
global p1 p P P1
u = u_in(1);
y = u_in(2);
y1 = u_in(3);
x = u_in(5);
x1 = u_in(6);
fi = [-y1;-y;u];
z = [-x1;-x;u];
P = P1 - (P1*z*fi'*P1)/(1+fi'*P1*z);
k = P * z;
E = u_in(8) - fi'*p1;
p = p1 + k*E;
p1 = p;
P1 = P;
p_out = p;
end