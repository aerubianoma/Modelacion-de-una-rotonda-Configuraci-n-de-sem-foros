#Semaforo 47 segundos
x=[];
y=[];
X=[];
T=[];
# Función objetivo
c = [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1]';
# Entrada inicial de carros (igual en cada caso para comparar)
z = [2321,2697,2843,2525]
# for que me da las iteraciones de cambio de semaforo, se da este tope para completar una hora de cambios de semáforo
for i=[1:77]
p1=rand(1,4);
# Vector que me da la aletoreidad en la escogencia de dirección de los carros
p2=[p1(1)/2,(1-p1(1))/2,p1(2)/2,(1-p1(2))/2];
if (mod(i,2)==0)
# Semaforo en rojo este-oeste
     #x_01 x_03 x_05 x_07 x_12 x_23 x_34 x_45 x_56 x_67 x_78 x_81 x_29 x_49 x_69 x_89 
A = [   1 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0;
        0 ,  1 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0;
        0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 , -1 ,  0;
        0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 , -1;
        0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0];
#En 47 segundos entra un maximo de 55 carros por semáforo
z1 = [55,0,55,0];
#Las 8 componentes internas se les da un valor muy grande porque dado el tiempo del semáforo los carros alcanzan a pasar libremente
#por la rotonda
#Las 4 componentes finales me indican la capacidad de elección aleatoria de los carros
ub = [z1,10000,10000,10000,10000,10000,10000,10000,10000,floor(2*55*p2(1)),floor(2*55*p2(2)),floor(2*55*p2(3)),floor(2*55*p2(4))]';
else
#Semaforo en rojo norte-sur
A = [   1 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0 ,  0;
        0 ,  1 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 , -1 ,  0 ,  0;
        0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 , -1 ,  0;
        0 ,  0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  1 , -1 ,  0 ,  0 ,  0 , -1;
        1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0;
        0 ,  0 ,  1 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0 ,  0];
#En 47 segundos entra un maximo de 55 carros por semáforo
z2 = [0,55,0,55];
#Las 8 componentes internas se les da un valor muy grande porque dado el tiempo del semáforo los carros alcanzan a pasar libremente
#por la rotonda
#Las 4 componentes finales me indican la capacidad de elección aleatoria de los carros
ub = [z2,10000,10000,10000,10000,10000,10000,10000,10000,floor(2*55*p2(1)),floor(2*55*p2(2)),floor(2*55*p2(3)),floor(2*55*p2(4))]';
endif
# Lo que entra menos lo que sale es igual a 0 (conservación de flujo en un problema del flujo máximo)
b = [0,0,0,0,0,0,0,0,0,0]';
# cota inferior de las incognitas (no hay carros negativos)
lb = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]';
# S = restricciones de igualdad , U = restricciones de desigualdad
ctype = "SSSSSSSSSS";
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
#Para cambiar a hora pico cambiar los ceros por 40 en el randi
if (mod(i,2)==0)
  z(1)=z(1)-xmin(1)+randi([0 55]);
  z(2)=z(2)+randi([0 55]);
  z(3)=z(3)-xmin(3)+randi([0 55]);
  z(4)=z(4)+randi([0 55]);
else
  z(1)=z(1)+randi([0 55]);
  z(2)=z(2)-xmin(2)+randi([0 55]);
  z(3)=z(3)+randi([0 55]);
  z(4)=z(4)-xmin(4)+randi([0 55]);
endif
# Se agrega el flujo de las entradas a una matriz
T(i,:)=z;
endfor
# X matriz de valores optimos, T matriz de flujo en la entrada
X
T
#Graficas
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
title('Semaforo configurado en 47 segundos')
legend('entrada norte','entrada oeste','entrada sur','entrada este');
hold off;