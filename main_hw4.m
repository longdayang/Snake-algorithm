prompt='choose the file you want to use:';
filename=input(prompt,'s');
load(strcat(filename,'.mat'));
binim=double(binim);
kir= input('the parameters:forcetype,std,support, Niter, nsample, alpha, beta, gamma, extcoef, balcoef, itergvf ');
[x,y]=snake_mainfunction(binim,kir(1), kir(2), kir(3), kir(4), kir(5), kir(6), kir(7), kir(8), kir(9), kir(10),kir(11))
%[x,y]=snake_mainfunction(binim,1, 1, 1, 500, 100, 0.001, 0.001, 1, 0.15, 0,300)

% [x,y]=snake_mainfunction(binim,2, 1, 1, 800, 150, 0.001, 0.001, 1, 0.8, 0,300)

 [x,y]=snake_mainfunction(binim,3, 1, 1, 500, 100, 0.001, 0.001, 0.1, 2, 0,800)
pause
figure(3)
imagesc(binim);
hold on
plot(x,y,'m.','MarkerSize',10)