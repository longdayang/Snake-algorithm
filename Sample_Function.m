function [corx,cory] = Sample_Function(x1,y1,nsample)
x1=double(x1);
y1=double(y1);
N=length(x1);
P=[x1(:) y1(:)];
Lx=0;Ly=0;Dxy=0;
for i=1:N
    it=i+1;
    if it>N
        it=1;
    end 
    Lx=abs(x1(it)-x1(i));
    Ly=abs(y1(it)-y1(i));
    Dxy=sqrt(Lx^2+Ly^2)+Dxy;
end
corx=0;cory=0;
for i=1:N
    it=i+1;
    if it>N
        it=1;
    end 
    Lx=abs(x1(it)-x1(i));
    Ly=abs(y1(it)-y1(i));
    Dxyi=sqrt(Lx^2+Ly^2);
    nsample1=floor(nsample*Dxyi/Dxy);
    distance=abs(x1(i)-x1(it))/nsample1;
    if Lx==0
        ypick=interp1([y1(i),y1(it)],1:1/nsample1:2);
    else
    if x1(i)>x1(it)
    ypick=fliplr(interp1([x1(i),x1(it)],[y1(i),y1(it)],x1(it):distance:x1(i)));
    else  ypick=interp1([x1(i),x1(it)],[y1(i),y1(it)],x1(i):distance:x1(it));
    end 
    
    end
    xpick=interp1([x1(i),x1(it)],1:1/nsample1:2);
    corx=[corx,xpick];
    cory=[cory,ypick];
    
end
corx=(corx(2:length(corx)))';
cory=(cory(2:length(cory)))';
end

