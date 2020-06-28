% state 0: queue has no people in it,  state 1: one people in the
% queue,... and so on , so state set is {0,1,2,3, ....,60}


p = 0.1; %decreasing probility of this queue
q = 0.8; %increasing probility of this queue 
n = 61;  %how many state in this system 

P = []; %P is transition matrix
for i= 1: n  %initial first row of transformation of matrix
    P(i) = 0;
end
P(1) = 1- p; %p[0,0] is the probility.P(xi=0| xi-1=0),which is 1-p
P(2) = p;    %p[0,1] = P( xi = 1 | xi-1 = 0) = increasing probility

%caculating transportation probility of each state for state_1 to state_59
for i = 2: (n-1)  
    b = [];
    for j = 1:n
        b(j) = 0;        
        if j==i
            b(j) = 1-p-q;
        end
        
        if j == i-1
            b(j) =q;
        end
        
        if j == i+1
            b(j) = p;
        end
        
    end
    P = [P;b];
end

b = [];
for i= 1: n
    b(i) = 0;
end

b(n-1) = q;
b(n) = 1-q;
P = [P;b];


S = []; %S is a state set of this markove chain {0,1,2,.....,60}
for i = 1 : n
    S(i) = i-1;
end

Z = [];
Z(1) = 0; %initial state is state zero, Z1 = state zero
for i = 2:10000 
    temp = rand; %create random varible
    pdf=P(Z(i-1)+1,:); %get pdf of previous state
    theCDF = cumsum(pdf); %get cdf from pdf
    thisIndex = find( temp < theCDF, 1);% depended on temp to design next state
    Z(i) = S(thisIndex); %record state in array Z
end

figure
hist(Z,0:60); % show simulation reuslt


x = P^1000;
figure
bar(x(1,:)); %print first row of One Thousand Step Matric
Sunx = sum(x(1,:));

%limitation : q is not equal zero and q is not equal to p
v = []; % v is the caculation probility of staying state i, which i is from zero to n
for i =1:n
    v(i) = ((1-(p/q))/(1 - (p/q)^(n)))*((p/q)^(i-1));
end

figure
bar(v);
SUM = sum(v);