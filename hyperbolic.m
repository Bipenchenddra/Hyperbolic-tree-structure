clear all
clc 
e=60;
a=50;
b=150;
theta=pi/2:pi/50:1.5*pi;
prompt="Number of branches : ";
n=input(prompt);
prompt="Height of intersection : ";
hin=input(prompt);
prompt ="Branch radius : ";
r = input(prompt);
x=e+a*cos(theta);
z=b*sin(theta);
y=0*theta;

L4 = cell(1, n);
s=0;
for curvenum = 1:n
    s=s+(2*pi/n);
    R1=[cos(s),-sin(s),0;sin(s),cos(s),0;0,0,1];
    P2=[x;y;z];
    L3=R1*P2;
    L4{curvenum}=transpose(L3);

end

figure;
hold on;

for curvenum = 1:n
    curve = L4{curvenum};
    plot3(curve(:, 1), curve(:, 2), curve(:, 3));
end



%part2(intersection with z)
s=0;
xin=e-(a/b)*sqrt(b^2-hin^2);
yin=0;
for curvenum = 1:n
    s=s+(2*pi/n);
    Pos1=[cos(s),-sin(s),0;sin(s),cos(s),0;0,0,1];
    Pos2=[xin;yin;hin];
    Pos3=Pos1*Pos2;
    Pos4{curvenum}=transpose(Pos3);
end
%graph
for curvenum =1:n
    point = Pos4{curvenum};
    plot3(point(:, 1), point(:, 2), point(:, 3), 'o');
end


%end of part2

%part 3
deg = 0:pi/100:2*pi;
pointsOnCircle = cell(n,1);
pointsinplane = cell(1,n);
s=0;
for curvenum = 1:n
s = s + (2*pi/(n));
R1=[cos(s),-sin(s),0;sin(s),cos(s),0;0,0,1];
P2=[xin;yin;hin];
W=R1*P2;
pointsinplane{curvenum}=W;
end
for curvenum =1:n
    c = pointsinplane{curvenum};
    x1 = c(1,1);
    y1 = c(2,1);
    %deg = linspace(0,pi/100,2*pi);
    u = x1 + r*cos(deg);
    v= y1 + r*sin(deg);
    w=hin+0*deg;
    pointsOnCircle{curvenum} = [u; v ; w];
end
for curvenum=1:n
   ci = pointsOnCircle(curvenum);
   xi = ci{1, 1}(1,:);
   yi = ci{1,1}(2,:);
   wi = ci{1,1}(3,:);
   plot3(xi(1, :),yi(1, :),wi);
end
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Three-Dimensional Graph with Curves');
view(3);
axis("equal");
hold off
%end of part3
% Part-4

for curvenum=1:n
    c1 = pointsinplane{curvenum};
    x1 = c1(1,1);
    y1 = c1(2,1);
    if curvenum ==n
        c2=pointsinplane{1};
        x2=c2(1,1);
        y2=c2(2,1);
    else
        c2=pointsinplane{curvenum+1};
        x2=c2(1,1);
        y2=c2(2,1);
    end
    generateGcode(x1,y1,x2,y2,r,curvenum);
end

function generateGcode(x1,y1,x2,y2,r,c)

disp("Generating G-code for circles "+{c}+" and "+{c+1})
d = sqrt((x2 - x1)^2 + (y2 - y1)^ 2);
if (d >= 2* r)
        % Generate G-code for printing two separate circles
        disp("G00 X"+{x1-r}+" Y"+ {y1});
       disp("G02 X"+{x1-r}+" Y"+{y1}+" I"+{r}+" J0");
       disp("G00 X"+{x2-r}+" Y"+{y2});
       disp("G02 X"+{x2-r}+" Y"+{y2}+" I"+{r}+" J0");
       disp("G00 z1.5")
else
        % Generate G-code for printing the union of the circles
        h=sqrt(r^2 -(d/2)^2);
        x5=(x1+x2)/2;
        y5=(y1+y2)/2;
       disp("G00 Y"+{x5-(h*(y2-y1))/d}+" X"+{y5+(h*(x2-x1))/d});
       disp("G02 Y"+{x5+(h*(y2-y1))/d}+" X"+{y5-(h*(x2-x1))/d}+" J"+{x1-(x5-(h*(y2-y1))/d)}+" I"+{y1-(y5+(h*(x2-x1))/d)})
       disp("G00 Y"+{x5+(h*(y2-y1))/d}+" X"+{y5-(h*(x2-x1))/d});
       disp("G02 Y"+{x5-(h*(y2-y1))/d}+" X"+{y5+(h*(x2-x1))/d}+" J"+{x2-(x5+(h*(y2-y1))/d)}+" I"+{y2-(y5-(h*(x2-x1))/d)})
       disp("G00 z1.5")

end
end