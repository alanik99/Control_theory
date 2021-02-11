clc; close all;

mza = -0.019;
mzd = -0.0102;
mzw = -0.015;
Jz = 59616.24;

y = 5000;
ro = 1.22*exp(-y/10000);

v = 111.11;

q = (ro * v^2) / 2;
S = 16.1;
L = 1.71;
qSL = q * S * L;

Mza = mza * qSL;
Mzd = mzd * qSL;
Mzw = mzw * qSL;

a11 = -Mzw / Jz
a12 = -Mza / Jz
a13 = -Mzd / Jz

R = 5400;
Cya = 0.128;
Ya = (Cya * ro * S * v^2) / 2;
m = 4000;

a42 = (R + Ya) / m / v


K = -a13 * a42 / (a11*a42 + a12)

T = 1 / sqrt(a11*a42 + a12)

eps = (a11 + a42) / 2 / sqrt(a11*a42 + a12)

T1 = 1 / a42

I1 = -10000; I2 = -1500;

w = 0 : 0.001 : 1000;

%
% K = -0.212; 
% T = 0.0294;
% T1 = 0.4275;
% eps = 0.1253;


for i = 1 : length(w)
    i1(i) = (2*eps*T*(w(i)^2) - T1*(w(i)^2) + T1*(T^2)*(w(i)^4)) / (K + K*(T1^2)*(w(i)^2) );
    i2(i) = ((T^2)*(w(i)^2) - 1 - 2*eps*T*(w(i)^2)*T1) / (K + K*(T1^2)*(w(i)^2) );
end

plot(i1, i2, 'r'); grid on
xlabel('{\it i_1}'); ylabel('{\it i_2}');
%axis([-1000 100 0 0.5]);
%axis([-100 20 0 0.7]);

%axis([-600 100 -3 3]); % область1

%axis([-7000 100 -1000 300]); %область2

line([0,0], ylim);


% figure;
% plot(w, i1); grid on
% xlabel('\omega'); ylabel('i_1');
% 
% figure;
% plot(w, i2); grid on
% xlabel('\omega'); ylabel('i_2');
% axis([0 10 0 58]);
