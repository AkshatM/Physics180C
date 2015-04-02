width1 = [NaN 6.472-5.056 3.742-3.640 3.034-2.629 2.225-2.225; NaN 6.270-5.157 3.640-3.640 3.034-2.730 2.225-2.225; NaN 6.067-5.461 3.742-3.742 2.933-2.831 2.225-2.225];

plot2 = [NaN, 6.472-5.056, 6.270-5.157, 6.067-5.461, NaN];
plot4 = [NaN, 3.034-2.629, 3.034-2.730, 2.933-2.831, NaN];

temp = [1,2,4,7,8];

plot(temp,plot2,'ro', 'MarkerSize',8)
hold on
plot(temp,plot4,'ko', 'MarkerSize',8)
plot(temp,plot2,'--')
plot(temp,plot4,'--')
hold off
xlabel('Temperature (K)','FontSize',12)
ylabel('Plateau Widths (T)', 'FontSize',12)
legend('\nu = 2', '\nu = 4', 'Location', 'northeast')