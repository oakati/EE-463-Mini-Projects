function [f1 f2 f3] = plotting(s, CDF, distanceaxis)
f1 = figure;
myylabel = {' power (dBm)',' power (W)',' voltage (v)',' voltage (dB \muV)'};
ha1 = tight_subplot(4,1,[.08 .06],[.05 .05],[.12 .06]) %(Nh, Nw, gap, marg_h, marg_w)

axes(ha1(1)); plot(distanceaxis,s.P,"b");
axes(ha1(2)); plot(distanceaxis,s.p,"b");xlabel('Traveled distance (m)');
axes(ha1(3)); plot(distanceaxis,s.v,"r");
axes(ha1(4)); plot(distanceaxis,s.V,"r");

for i =1:2
    axes(ha1(i));
    title('Received power');
end
for i =3:4
    axes(ha1(i));
    title('Received voltage');
end
for i =1:4
    axes(ha1(i));
   xlim([0 350]);
   grid minor;
   ylabel(strcat('Received',myylabel(i)));
   set(gca,'XTickLabel',cellstr(num2str(get(gca,'XTick')')));
   set(gca,'YTickLabel',cellstr(num2str(get(gca,'YTick')')));
end
%% PLOTTING ============================================================
f2 = figure;
ha2 = tight_subplot(5,1,[.04 .03],[.05 .05],[.12 .06]);%(Nh, Nw, gap, marg_h, marg_w)
myylabel = {'(v)','(dB  \muV)','(lin. units)','(dB)','(dB  \muV)'};

axes(ha2(1));plot(distanceaxis,s.vfiltered,"g");title("V_{r}");
axes(ha2(2));plot(distanceaxis,s.VFILTERED,"g");
axes(ha2(3));plot(distanceaxis,s.vfast,"y");
axes(ha2(4));plot(distanceaxis,s.VFAST,"y");
axes(ha2(5));
hold on
plot(distanceaxis,s.V,"r");
plot(distanceaxis,s.VFILTERED,"g");
hold off


for i =1:5
    axes(ha2(i));
    xlim([0 350]);
    grid minor;
    ylabel(myylabel(i));
    set(gca,'XTickLabel',cellstr(num2str(get(gca,'XTick')')));
    set(gca,'YTickLabel',cellstr(num2str(get(gca,'YTick')')));
end
for i = 1:2
    axes(ha2(i));
    subtitle('Slow variations');
end
for i = 3:4
    axes(ha2(i));
    subtitle('Normalized, Fast variations');
end
for i = 5
    axes(ha2(i));
    subtitle('Overall and Slow variations');
    xlabel('Traveled distance (m)');
end
for i = 3
    axes(ha2(i));
    axis([0 distanceaxis(end) 0 5]);
end
%%
f3 = figure;
ha3 = tight_subplot(3,1,[.08 .06],[.05 .05],[.12 .06]);%(Nh, Nw, gap, marg_h, marg_w)

axes(ha3(1));
plot(CDF.x.slow,CDF.y.slow,'g:',CDF.x.slow,CDF.y.Theoretical.slow,"g");
xlabel('Voltage (dB  \muV)');
hleg = legend('Meas.','Theo.');title(hleg,"CDFs of ... slow variations");

axes(ha3(2));hold on;
plot(CDF.x.fast,CDF.y.fast,'y:',"linewidth",2);
plot(CDF.x.fast,CDF.y.Theoretical.fast,"y","linewidth",2);
xlabel('Normalized voltage');ylabel('P(<x)');
hleg = legend('Meas.','Theo.');title(hleg,"CDFs of ... fast variations");

axes(ha3(3));hold on;
plot(CDF.x.slow,CDF.y.slow,"g");
plot(CDF.x.overall,CDF.y.overall,"r");
xlabel('Voltage (dB  \muV)');
hleg = legend('Slow','Overall');title(hleg,"Measured CDFs of ... variations");


for i = 1:3
    axes(ha3(i));
    grid minor;
    set(gca,'XTickLabel',cellstr(num2str(get(gca,'XTick')')));
    set(gca,'YTickLabel',cellstr(num2str(get(gca,'YTick')')));
end
end

