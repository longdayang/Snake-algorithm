load('binim_example.mat');
binim=double(binim);
I=binim;
[r,c]=size(I);
I=double(I);
%parameter
std=1;
Niter=500;
nsample=100;
alpha=0.001;
beta=0.001;
gama=0.1;
extcoef=2;
balcoef=0;
itergvf=800;

%

H=fspecial('gaussian',[r c],std);
IG=imfilter(I,H,'replicate');

%compute the external force
kk=2;
[fx,fy]=GVF(I,0.2,itergvf);
figure(1); 
quiver(fx,fy);
figure(2);
imagesc(I);
% hold on
% x1=[];
% y1=[];
% while 1
%     [x_temp,y_temp,button]=ginput(1)
%     if button==1
%         x1=[x1,x_temp];
%         y1=[y1,y_temp];
%         plot(x_temp,y_temp,'rx')
%         plot(x1,y1,'color','y')
%     else break
%     end
% end 
% N=length(x1);
% for i=1:N
%     it=i+1;
%     if it>N
%         it=1;
%     end 
%     line([x1(i) x1(it)],[y1(i) y1(it)],'color','y');
% end
hold on
x = [];
y = [];
n =0;
% Loop, picking up the points
% disp('Left mouse button picks points.')
% disp('Right mouse button picks last point.')
but = 1;
while but == 1
      [s, t, but] = ginput(1);
      n = n + 1;
      x(n,1) = s;
      y(n,1) = t;
      plot(x, y, 'ro');
end   
plot([x;x(1,1)],[y;y(1,1)],'r-');
k=size(x);
N=length(x);
[sx,sy]=Sample_Function(x,y,nsample)
plot(sx,sy,'k.','MarkerSize',10);
LN=length(sx);
alpha1=alpha*ones(1,LN);
beta1=beta*ones(1,LN);
temp1= beta1;
temp2= -alpha1-4*beta1;
temp3= 6*beta1+2*beta1;
temp4= -alpha1-4*beta1;
temp5= beta1;
A=diag(temp1(1:LN-2),-2)+diag(temp1(LN-1:LN),LN-2);
A=A + diag(temp2(1:LN-1),-1)+diag(temp2(LN), LN-1);
A=A + diag(temp3);
A=A + diag(temp4(1:LN-1),1)+diag(temp4(LN),-(LN-1));
A=A + diag(temp5(1:LN-2),2)+diag(temp5(LN-1:LN),-(LN-2));
invAI=inv(gama*A +diag(ones(1,LN)));
% for j=1:LN
%     jl=j+1;js=j-1;
%     if jl>LN
%         jl=1;
%     end
%     if js<1
%         js=LN;
%     end
% h(j)=(sy(jl)-sy(js)-sx(jl)+sx(js))/sqrt((sx(jl)-sx(js))^2+(sy(jl)-sy(js))^2);
% end
% h=h';
k=1;
% pause;
while k<=Niter
    k=k+1;
    vfx=interp2(fx,sx,sy,'*linear'); 
    vfy=interp2(fy,sx,sy,'*linear'); 
    sx=invAI*(sx+extcoef*vfx);
    sy=invAI*(sy+extcoef*vfy);
    plot(sx,sy,'g');
    drawnow;
    sx_temp=sx(1:kk:length(sx));
    sy_temp=sy(1:kk:length(sy));
    [sx,sy]=Sample_Function(sx_temp,sy_temp,nsample);
    LN=length(sx);
    alpha1=alpha*ones(1,LN);
    beta1=beta*ones(1,LN);
    temp1= beta1;
    temp2= -alpha1-4*beta1;
    temp3= 6*beta1+2*beta1;
    temp4= -alpha1-4*beta1;
    temp5= beta1;
    A=diag(temp1(1:LN-2),-2)+diag(temp1(LN-1:LN),LN-2);
    A=A + diag(temp2(1:LN-1),-1)+diag(temp2(LN), LN-1);
    A=A + diag(temp3);
    A=A + diag(temp4(1:LN-1),1)+diag(temp4(LN),-(LN-1));
    A=A + diag(temp5(1:LN-2),2)+diag(temp5(LN-1:LN),-(LN-2));
    invAI=inv(gama*A +diag(ones(1,LN)));
end
figure(3),
imagesc(I);
hold on
plot(sx,sy,'r.');
hold off


