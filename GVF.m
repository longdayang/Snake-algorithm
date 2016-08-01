function [u,v]=GVF(f,mu,ITER)
[fx,fy] = gradient(f); 
u = fx; v = fy;
SqrMagf = fx.*fx + fy.*fy; 
for i=1:ITER,
  u = u + mu*4*del2(u) - SqrMagf.*(u-fx);
  v = v + mu*4*del2(v) - SqrMagf.*(v-fy);
end
