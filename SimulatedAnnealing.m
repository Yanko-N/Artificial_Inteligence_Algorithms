% |-------------------------|
% | Trabalho II de IA |
% | Vitor Novo <74280> |
% |-------------------------|
%%SCRIPT PARA O Simulated Annealing
clc
clear
close all
a=3
b=10
 %Intervalos
xmin=-3;
xmax=3; 
ymin=-3; 
ymax=3;
%nr de iterações
iteracoes =100; 
%função
fx=@(x,y) abs( a.*(1-x.^2).*exp(-x.^2-(y+1).^2)-b.*(x./5 - x.^3 -y.^5).*exp(-x.^2 -y.^2)-(1/3).*exp(-(x+1).^2-y.^2)) ;
 
%------------------------------------
%posição inicial
%Vai escolher uma posição aleatória em todo o grafico dentro dos limites
x=(xmax-xmin)*rand+xmin;
y=(ymax-ymin)*rand+ymin;
%vizinhança delta min
delta_min=-0.2; 
delta_max=0.2;
%criar vetor x com 100 pontos, como o y, meshgrid cria uma matriz 100x100
%em que combina todas as combinacoes de x e y possiveis
xx=linspace(xmin,xmax,100);
yy=linspace(ymin,ymax,100);
[X,Y]=meshgrid(xx,yy);
Z=fx(X,Y);
%
%faz plot do mapa da função
contourf(X,Y,Z);
%------------------------------------
% quando se mudar o A e B deve-se mudar aqui tb
%criação do grafico
%ezcontourf('abs(3 *(1-x^2)*exp(-x^2-(y+1)^2)-10*(x/5 - x^3 -y^5)*exp(-x^2 -y^2)-(1/3)*exp(-(x+1)^2-y^2))',...
% [-3,3],[-3,3]);
title('Peaks 1');
hold on
%Mostar o grafico em 3D
figure
surfc(X,Y,Z);
hold on;
shading interp
colormap jet
title('Grafico 3D');
figure(1);
%----------------------------------------------
%Guardar a variavel inicial do x e y, caso este possa ser o melhor caso
best_x = x;
best_y = y;
plot(x,y,'go',LineWidth=2)
figure(2);
%graficos 3D
plot3(x,y,fx(x,y),'g.',MarkerSize=20);
figure(1);
%contador
n=1;
t=1;
k=1
%vetor que guarda valores da função na descida
f = zeros(iteracoes,1);
%vetor da temperatura
T = zeros(iteracoes,1);
%vetor probabilidade temperatura
p_t = zeros(iteracoes,1);
%temperatura inicial
T(1)=90;
while( k < iteracoes)
 
 n=1;
 
 while n<=iteracoes/5
 
 %Inicializa x_novo random
 x_novo = (delta_max-delta_min)*randn(1)+delta_min+x;
 y_novo = (delta_max-delta_min)*randn(1)+delta_min+y;
 
 %Condições que obrigam o x_novo e y_novo a estarem dentro
 %dos intervalos impostos pela função 
 if x_novo > xmax
 x_novo = xmax;
 end
 if y_novo > ymax
 y_novo = ymax;
 end
 if x_novo < xmin
 x_novo = xmin;
 end
 if y_novo < ymin
 y_novo = ymin;
 end
 
 %calculo do delta
 deltaE = fx(x_novo, y_novo) - fx(x,y)
 
 % Se deltaE for positivo significa que fx(x,y) > fx(x_novo,y_novo)
 % UPHILL MOVEMENT
 if (deltaE > 0) %movimento de subida
 
 
 
 x = x_novo;
 y = y_novo;
 
 f(t)= fx(x_novo, y_novo);
 plot(x,y,'r*')
 figure(2);
 %graficos 3D
 plot3(x,y,fx(x,y),'r.',MarkerSize=20);
 figure(1);
 
 %BEST CALCULATOR
 if fx(best_x, best_y) < fx(x_novo, y_novo)
 best_x = x_novo;
 best_y = y_novo;
 end
 
 %DownHill Moviment
 elseif exp(abs(deltaE) /T(t)) < randn(1) %formula da probabilidade
 
 
 
 p_t(t)= exp(abs(deltaE) /T(t)); 
 
 x=x_novo; 
 y=y_novo;
 
 
 f(t)=fx(x_novo, y_novo);
 plot(x,y,'r*')
 figure(2);
 %graficos 3D
 plot3(x,y,fx(x,y),'r.',MarkerSize=20);
 figure(1);
 %BEST CALCULATOR
 if fx(best_x, best_y) < fx(x_novo, y_novo)
 best_x = x_novo;
 best_y = y_novo;
 end
 
 end
 
 T(t+1)=T(t);
 t = t+1;
 
 n=n+1;
 end
 
 T(t) = 0.94*T(t-1); %Decrescimo da temperatura 
 
 
 %incremento do ciclo
 k=k+1;
end
plot(best_x,best_y,"y*")
figure(2);
%graficos 3D
plot3(best_x,best_y,fx(best_x,best_y),'y*',MarkerSize=20);
figure(1);
figure
plot(p_t(1:50), 'r') %Gráfico com a evolução da coordena x
title('Evolução da Probabilidade')
xlabel('Iterações')
ylabel('Probabilidade')
% Criação do plot com a função
figure
plot (T, 'b')
title('Evolução da Temperatura')
xlabel('Iterações')
ylabel('Temperatura')
% Criação do plot com a função
figure
plot (f, 'b')
title('Evolução da Função')
xlabel('Iterações')
ylabel('F(t)')
%Mostrar o valor mais alto obtido para o x, y
fprintf('Melhor x %f\n', best_x);
fprintf('Melhor y %f\n', best_y);