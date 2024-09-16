clear
clc
e=150;
a=50;
b=150;
prompt = "height of intersection :";
z1=input(prompt);
%pointsinplane = cell(300,n);
%z1 = -150:4:150;
%for z1 = 
theta = asind(z1/b);
x = e+a*cos(theta);
y = 0;
prompt="number of branches :";
n=input(prompt);
prompt="Input the Branch radius: ";
Br=input(prompt);
pointsinplane = cell(1,n);
s=0;
for curvenum = 1:n
s=s+(2*pi/n);
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
hold off

for d=1:(n-1)
    A=pointsinplane{d};
    B=pointsinplane{d+1};
    F=transpose(A);
    G=transpose(B);
    fx=F(1,1);
    gx=G(1,1);
    fy=F(1,2);
    gy=G(1,2);
    d1=sqrt((fx-gx)^2+(gy-fy)^2);
    if d1>2*Br
        fprintf("d>2*Br\n");
    elseif d1==2*Br
        fprintf("d==2*Br\n");
    else
        fprintf("d<2*Br\n");
    end
end
  A=pointsinplane{1};
  B=pointsinplane{n};
  F=transpose(A);
  G=transpose(B);
  fx=F(1,1);
  gx=G(1,1);
  fy=F(1,2);
  gy=G(1,2);
  d1=sqrt((fx-gx)^2+(gy-fy)^2);
  if d1>2*Br
      fprintf("d>2*Br\n");
  elseif d1==2*Br
      fprintf("d==2*Br\n");
  else
      fprintf("d<2*Br\n");
  end