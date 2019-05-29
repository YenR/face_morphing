function [x y] = myginput(n)

H = gca;
set(H, 'YLimMode', 'manual'); set(H, 'XLimMode', 'manual');
set(H, 'YLim', get(H,'YLim')); set(H, 'XLim', get(H,'XLim'));

numPoints = n; xg = []; yg = [];
for i=1:numPoints
    [xi yi] = ginput(1);
    xg = [xg;xi]; yg = [yg;yi];
    if i == 1
        hold on;
        plot(H, xg(i),yg(i),'y+');
        text(xg(i)+5,yg(i),num2str(i),'FontSize',11, 'Color', 'y');
    else
        plot(xg([i-1:i]),yg([i-1:i]),'y+');
        text(xg(i)+5,yg(i),num2str(i),'FontSize',11, 'Color', 'y');
    end 
end
hold off;

x = xg; y = yg;