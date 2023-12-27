%%SCRIPT PARA O MR HILL CLIMBING
% Comandos magicos
clc; %limpa consola
clear all ; %limpa tudo
close all;
a=9
b=5
fx=@(x,y) abs( a.*(1-x.^2).*exp(-x.^2-(y+1).^2)-b.*(x./5 - x.^3 -y.^5).*exp(-x.^2 -y.^2)-(1/3).*exp(-(x+1).^2-y.^2)) ;
%Variáveis que vão guardar os limites mínimos e máximos que pode ter o x, y
xmin=-3;
xmax=3;
ymin=-3;
ymax=3;
x=linspace(xmin,xmax,100);
y=linspace(ymin,ymax,100);
[X,Y]=meshgrid(x,y);
Z=fx(X,Y);
%faz plot do mapa da função
contourf(X,Y,Z);
% ezcontourf('abs( 3 *(1-x^2)*exp(-x^2-(y+1)^2)-10*(x/5 - x^3 -y^5)*exp(-x^2 -y^2)-(1/3)*exp(-(x+1)^2-y^2))',...
% [-3,3],[-3,3]);
title('Peaks 2');
%Mostar o grafico em 3D
figure
surfc(X,Y,Z);
hold on;
shading interp
colormap jet
title('Grafico 3D');
figure(1);
%inicializar a variavel com o número de iterações que terá o ciclo
t_max = 250;
%Cria os vetores para guardar as coordenadas do x, do y e os valores
%obtidos da função f(x) Para fazer os graficos
x_cor=zeros(t_max,1);
y_cor=zeros(t_max,1);
fx_cor =zeros(t_max,1);
%Vai escolher uma posição aleatória em todo o grafico dentro dos limites do
%(x,y) máximo e mínimo e faz um plot desse ponto no gráfico
x=(xmax-xmin)*rand+xmin;
y=(ymax-ymin)*rand+ymin;
hold on
%Variáveis que determinam o valor para avançar na vizinhança
delta_min = -0.02;
delta_max=0.02;
%inicialização dos vetores com as coordenadas da primeira iteração.
x_cor(1)=x;
y_cor(1)=y;
%inicialização do vetor com o primeiro calculo da função para o (x,y)
fx_cor(1)=fx(x, y);
% vai contar o número de vezes que não vai ser as coordenadas melhores
not_best = 0;
% vai guardar o x, y com melhores resultados obtidos BEST
best_x = x;
best_y = y
plot(x,y,'go',LineWidth=2) %Ponto Inicial
figure(2)
%graficos 3D
plot3(x,y,fx(x,y),'g.',MarkerSize=20);
figure(1);
for k =2:t_max
 %Verifica se o ponto gerado n é maior que a vizinhança
 %Procura um novo(x,y) na vizinhança definida
 x_novo=(delta_max-delta_min)*randn(1)+delta_min+x;
 y_novo=(delta_max-delta_min)*randn(1)+delta_min+y;
 
 %Vai garantir que este valor não sai de dentro do intervalo
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
 
 %vai verificar se melhorou o valor da função, ou seja, se com o novo
 %ponto na vizinham-se se obteve um valor mais alto do que o anterior,
 %Assim sobe para maximos no gráfico
 
 if fx(x_novo, y_novo) > fx(x, y)
 x=x_novo;
 y=y_novo;
 plot(x, y, 'y*',LineWidth=0.4)
 %graficos 3D
 figure(2);
 plot3(x,y,fx(x,y),'y.',MarkerSize=20);
 figure(1);
 % vai zerar sempre que melhorar
 not_best = 0;
 else
 %vai contar as vezes que o valor não melhora
 not_best = not_best + 1;
 end
 
 % vai verificar se o valor obtido da função para
 % x, y é o Best
 if fx(best_x, best_y) < fx(x_novo, y_novo)
 best_x = x_novo;
 best_y = y_novo;
 end
 
 % Vai verifica se não melhorou em X vezes
 if not_best == 5 % estagnaçao
 %Caso atinja, vai sortear um x,y numa posição aleatória no
 %intervalo todo e marca esse ponto no gráfico
 
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
 plot(x,y,'ro',LineWidth=2) %reinicialização
 %graficos 3D
 figure(2);
 plot3(x,y,fx(x,y),'r.',MarkerSize=20);
 figure(1);
 not_best = 0; %reinicia a contagem das vezes
 end
 
 %vai guardar nos vetores os dados obtidos
 x_cor(k) = x;
 y_cor(k) = y;
 fx_cor(k) = fx(x_cor(k), y_cor(k));
 
end
plot(best_x,best_y,"r*",LineWidth=2) %BEST CORDENADAS
%graficos 3D
figure(2);
plot3(best_x,best_y,fx(best_x,best_y),'r*',MarkerSize=20);
figure(1);
%faz o Plot das coordenadas x, y, em função das interações
figure
plot (x_cor, 'g')
title('Gráfico - Valores de x, y em cada Iteração')
hold on
plot(y_cor, 'r')
xlabel('Iterações')
ylabel('Valor de (x-green), (y-red)')
%Faz o plot do vetor da função calculada em cada iteração
figure
plot(fx_cor, 'b')
title('Gráfico - Valores do F(x)')
xlabel('Iterações')
ylabel('Valor de f(x,y)')
hold off
%Mostrar o valor mais baixo obtido para o x, y
fprintf('Melhor x %f\n', best_x);
fprintf('Melhor y %f\n', best_y);
