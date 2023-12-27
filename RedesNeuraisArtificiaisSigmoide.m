%%%%%%%
% Vitor Novo 
%

clc;
clear all;

% Funcao sig:

n_epochs = 2000; %Numero de epocas
alpha = 0.9; %Factor de aprendizagem

%Vetor soma dos erros quadraticos
SSE=zeros(1,n_epochs);
N=4;
%Amostras de entrada na funcao XOR
X=[0 0 1;
   0 1 1;
   1 0 1;
   1 1 1];
%Saidas da funcao XOR

T= [0
    1
    1
    0];

%Inicializacao aleatoria dos pesos [-1,1]
%W1-2x3 W2- 1x3


W1 = 2*rand(2,3) - 1;
W2 = 2*rand(1,3) - 1;

for epoch = 1:n_epochs
    sum_sq_error=0;
    for k = 1:N  %N=4
        x = X(k,:)';
        t = T(k);

        % Soma das camadas de entrada
        g1 = W1*x;

        %Funcao de ativacao sigmoidal
        y1 = sig(g1);

        %Adicao a saida da camada escondida y1
        %da entrada de bias com +1
        %Resulta em y1_b

        y1_b = [y1
                1];

        %Soma da camada de saida
        g2 = W2*y1_b;
        %Funcao de ativacao sigmoidal
        y2 = sig(g2);

        %Reto-Propagacao
        %Erro da camda de saida
        e = t - y2;

        %Calculo do delta da camada de saida
        %Sigmoide
        delta2 = y2.*(1-y2).*e;

        %Atualizacao da soma dos erros quadraticos
        sum_sq_error = sum_sq_error+ e^2;

        %Erro da camdaa escondida
        e1 = W2'*delta2;
        %Erro som o bias
        e1_b = e1(1:2);

        %Calculo do delta da camada de saida
        delta1 = y1.*(1-y1).*e1_b;

        %Atualiacao dos pessos da cmada escondida
        dW2 = alpha*delta2*y1_b'; %Com bias
        W2 = W2 + dW2;

        %Atualizacao dos pesos da camada de entrada 
        dW1 = alpha*delta1*x';
        W1 = W1 + dW1;


    end 
    SSE(epoch) = (sum_sq_error)/N;
end


    %Teste da rede

    for k = 1:N

        x = X(k,:)';
        g1 = W1*x;

        %Sigmoide
        y1 = sig(g1);

        %y1 mais uma entrada de bias
        y1_b = [y1
                 1];

        g2 = W2*y1_b;

        %saida preivista XOR
        y_plot(k) = sig(g2);

    end
    y_plot;


%%
%% Representação gráfica do SSE
It=1:1:n_epochs;
plot(It,SSE,'r','LineWidth',2)
xlabel('Epoca')
ylabel('SSE')
title('Funcao de ativacao: Sigmoide')







