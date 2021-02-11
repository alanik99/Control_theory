ww = tf([K*T1 K], [T^2 2*eps*T 1]);

w1 = feedback(ww, I2);

w2 = I1*w1*tf([1], [1 0]);

w3 = feedback(w2, 1);

% figure; step(w3); grid on
% figure; impulse(w3); grid on
% figure; bode(w2); grid on
figure; nyquist(w2); axis([-1 7 -8000 8000]); grid on
% figure; margin(w2); grid on
% figure; pzmap(w3);
% zero(w3)
% pole(w3)