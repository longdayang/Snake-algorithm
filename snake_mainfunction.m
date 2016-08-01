function [corx,cory]=snake_mainfunction(binim, forcetype, std, ~, Niter, nsample, alpha, beta, gama, extcoef, balcoef, itergvf)
I=binim;
[r,c]=size(I);
I=double(I);
GF=fspecial('gaussian',[r c],std);
IG=imfilter(I,GF,'replicate');

switch forcetype
    case 1
    [px,py]=gradient(IG);
    px=150*px;py=150*py;
    kk=3;
    case 2
    dist=bwdist(I);
    [px,py]=gradient(dist);
    px=-px;
    py=-py;
    kk=2;
    case 3
    kk=2;
    [px,py]=GVF(I,0.2,itergvf);
end
figure(1); 
quiver(px,py);
figure(2);
imagesc(I);
hold on
x1=[];
y1=[];
while 1
    [x_temp,y_temp,button]=ginput(1)
    if button==1
        x1=[x1,x_temp];
        y1=[y1,y_temp];
        plot(x_temp,y_temp,'rx')
        plot(x1,y1,'color','y')
    else break
    end
end 
N=length(x1);
for i=1:N
    it=i+1;
    if it>N
        it=1;
    end 
    line([x1(i) x1(it)],[y1(i) y1(it)],'color','y');
end
k=size(x1);
N=length(x1);
[corx,cory]=Sample_Function(x1,y1,nsample)
pause
plot(corx,cory,'k.','MarkerSize',10);
LN=length(corx);
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
k=1;
invAI=inv(gama*A +diag(ones(1,LN)));
for j=1:LN
    jl=j+1;js=j-1;
    if jl>LN
        jl=1;
    end
    if js<1
        js=LN;
    end
h(j)=(cory(jl)-cory(js)-corx(jl)+corx(js))/sqrt((corx(jl)-corx(js))^2+(cory(jl)-cory(js))^2);
end
h=h';
pause;
while k<=Niter
    k=k+1;
    vfx=interp2(px,corx,cory,'*linear'); 
    vfy=interp2(py,corx,cory,'*linear'); 
    corx=invAI*(corx+extcoef*vfx);
    cory=invAI*(cory+extcoef*vfy);
    plot(corx,cory,'g');
    drawnow;
    corx_temp=corx(1:kk:length(corx));
    cory_temp=cory(1:kk:length(cory));
    [corx,cory]=Sample_Function(corx_temp,cory_temp,nsample);
    LN=length(corx);
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

