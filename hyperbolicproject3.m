clear
clc

e=150;
a=50;
b=150;
prompt = "height of intersection:";
z1=input(prompt);
%pointsinplane = cell(300,n);
%z1 = -150:4:150;
%for z1 = 
theta = asind(z1/b);
x = e+a*cos(theta);
y = 0;
s = 0;
prompt="number of branches";
n=input(prompt);
pointsinplane = cell(1,n);
for curvenum = 1:n
s = s + (2*pi/(n));
R1=[cos(s),-sin(s),0;sin(s),cos(s),0;0,0,1];
P2=[x;y;z1];
W=R1*P2;
pointsinplane{curvenum}=W;
end
figure;
hold on
for curvenum =1:n
    point = pointsinplane{curvenum};
    plot3(point(1, :), point(2, :), point(3, :), 'o');
end

view(3);
axis("equal");

prompt ="input radius of branch:";
r = input(prompt);
deg = 0:pi/100:2*pi;

pointsOnCircle = cell(n,1);
for curvenum =1:n
    c = pointsinplane{curvenum};
    x1 = c(1,1);
    y1 = c(2,1);
    %deg = linspace(0,pi/100,2*pi);
    u = x1 + r*cos(deg);
    v= y1 + r*sin(deg);
    w=z1+0*deg;
    pointsOnCircle{curvenum} = [u; v ; w];
end
for curvenum=1:n
   ci = pointsOnCircle(curvenum);
   xi = ci{1, 1}(1,:);
   yi = ci{1,1}(2,:);
   wi = ci{1,1}(3,:);
   plot3(xi(1, :),yi(1, :),wi);
end
 hold off