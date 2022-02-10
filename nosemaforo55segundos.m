#Sin semaforo 55 segundos
x=[];
y=[];
X=[];
T=[];
# Función objetivo
c = [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1]';
#Entrada inicial de carros (igual en cada caso para comparar)
z = [500,550,700,450]
# for que me da las iteraciones, se da este tope para completar una hora de tiempo de flujo en la rotonda
for i=[1:65]
p1=rand(1,4);
# Vector que me da la aletoreidad en la escogencia de dirección de los carros
p2=[p1(1),1-p1(1),p1(2),1-p1(2),p1(3),1-p1(3),p1(4),1-p1(4)];
# Restricción adicional de elección de los carros en la salidad
a = [1,1-p2(4)-(p2(6)*p2(3))-(p2(7)*p2(5)*p2(3)),1-p2(6)-(p2(7)*p2(5)),1-p2(7),-(p2(2)+(p2(4)*p2(1))+(p2(6)*p2(1))+(p2(5)*p2(3)*p2(1)))];
     #x_01 x_03 x_05 x_07 x_12 x_23 x_34 x_45 x_56 x_67 x_78 x_81 x_29 x_49 x_69 x_89 
A = [   1 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0;
        0 ,  1 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0;
        0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 , -1 ,  0;
        0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 , -1;
     a(1) ,a(2),a(3),a(4),a(5),  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0];
#En 55 segundos entra un maximo de 65 carros por entrada
z1 = [65,65,65,65];
# Las 8 entradas internas se basan en la capacidad de los datos de una rotonda convencional
# Las 4 entradas finales se colocan igual que la capacidad de la entrada para bajar el tiempo de corrida del codigo, de igual manera 
# la salida puede tomar cualquier valor ya que lo importante es que los carros puedan salir
ub = [z1,450,20,450,20,450,20,450,450,z1]';
# Lo que entra menos lo que sale es igual a 0 (conservación de flujo en un problema del flujo máximo)
b = [0,0,0,0,0,0,0,0,0]';
# cota inferior de las incognitas (no hay carros negativos)
lb = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]';
# S = restricciones de igualdad , U = restricciones de desigualdad
ctype = "SSSSSSSSS";
# I = tipo de variable entera
vartype = "IIIIIIIIIIIIIIII";
# 1 = minimizar; -1 = maximizar
s = -1;
param.msglev = 1;
param.itlim = 100;
disp("Algoritmo: salida de carros")
# metodo symplex
[xmin, fmin, status, extra] = ...
   glpk (c, A, b, lb, ub, ctype, vartype, s, param);
#Algunos datos no relevantes
residuo=sum(z)-fmin;
carros_esperando=(z'-xmin(1:4))';
total_entrada=sum(z);
x(i)=i;
y(i)=fmin;
X(:,i)=xmin;
#Cambio en las entradas a la rotonda por iteración
#Para cambiar a hora pico cambiar los ceros por 20 en el randi
z(1)=z(1)-xmin(1)+randi([0 65]);
z(2)=z(2)-xmin(2)+randi([0 65]);
z(3)=z(3)-xmin(3)+randi([0 65]);
z(4)=z(4)-xmin(4)+randi([0 65]);
# Se agrega el flujo de las entradas a una matriz
T(i,:)=z;
i
endfor
# X matriz de valores optimos, T matriz de flujo en la entrada
X
T
# Gratis
figure;
hold on;
p1=plot(x,T(:,1))
p2=plot(x,T(:,2))
p3=plot(x,T(:,3))
p4=plot(x,T(:,4))
set(p1,'Color','red');
set(p2,'Color','blue');
set(p3,'Color','green');
set(p4,'Color','yellow');
title('Rotonda sin semáforos con pasos de 55 segundos')
legend('entrada norte','entrada oeste','entrada sur','entrada este');
hold off;