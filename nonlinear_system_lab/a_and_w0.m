clc; clear all; close all;

c22 = -1.9;  c23 = 3.9;  i1 = 1;  tau = 0.1;  Ke = -c23/c22;  Te = -1/c22;  d0 = 10;  e0 = 2;

%% Однозначное реле
T1 = @(i2) i2/i1;

w0 = @(i2) 1 / sqrt(tau*Te - (Te+tau)*T1(i2));

a_intersects = @(i2) 4*d0*Ke*i1*(tau*Te - (Te+tau)*T1(i2)) / pi / (Te+tau);


T1_star = tau*Te / (tau+Te);
i2_star = T1_star * i1;
i2_star

i2_arr = [0, i2_star, 0.2, 0.4];
 
for k = 1:length(i2_arr)
    w0(i2_arr(k))
    a_intersects(i2_arr(k))
end
 
%% Неоднозначное реле
w_arr = 0:0.1:1000;
a_arr = e0:0.1:20;
 
for i = 1:length(a_arr) %Wн
    U_n(i) = -pi/(4*d0) * sqrt(a_arr(i)^2 - e0^2);
    V_n(i) = -pi*e0/(4*d0);
end

figure;
kft = pi/(4*d0);
for j = 1:length(i2_arr) %Wл
    
    i2 = i2_arr(j);
    for i = 1:length(w_arr)
        U_l(i) = Ke*i1*(T1(i2) - Te) / (Te^2 *w_arr(i) + 1);
        V_l(i) = -Ke*i1*( 1 + T1(i2)*Te* w_arr(i)^2 ) / (Te^2 * w_arr(i)^3 + w_arr(i));
    end
    
    [xx(j), yy(j)] = polyxpoly(U_n, V_n, U_l, V_l); % точки пересечения j-ой кривой с прямой
    
    amlitude(j) = sqrt(xx(j)^2 + (kft*e0)^2) / kft; % из формулы для Re( -1/Wн(a) ) = xx(j)
    
    omega(j) = (   Ke*i1*( T1(i2) - Te ) - xx(j)   )   /   (xx(j)*Te^2); % из формулы для Re( Wл(jw0) ) = xx(j)
    
    hold on; grid on;
    plot(U_l, V_l);
    
    if j == 2
        legendInfo{j} = 'i_2 = i_2*';
    else
        legendInfo{j} = ['i_2 = ' num2str(i2)];
    end
    
end
xx
yy
amlitude
omega


plot(U_n, V_n);
hold on;
grid on;
title('Метод линеаризации');

xlabel('Re');
xlim([-1 0]);

ylabel('Im');
ylim([-1 0.2]);

legend(legendInfo);

gtext('-1/W_н(a)');
gtext('W_л(j\omega)');
