load('data.mat')
ANPV=diag(Area)*NPV;
vht=diag(Area)*Vol;

% f - Cost function
f=zeros(1,13335);
for i=1:889
    for j=1:15
       f(1, j+15*(i-1))=-ANPV(i,j);
    end
end

%A -> A*x<=B
A=zeros(28,13335);
for i=1:14
    for j=1:889
        % First inequality:
        A(i, 15*(j-1)+i)= 0.8*vht(j,i);
        A(i, 15*(j-1)+i+1)=- vht(j,i+1);
        % Second inequality:
        A(i+14, 15*(j-1)+i)= -1.2*vht(j,i);
        A(i+14, 15*(j-1)+i+1)= vht(j,i+1);
    end
end
B=zeros(1, 28);

%Aeq -> Aeq*x=Beq
Aeq=zeros(890,13335);
for i=1:889
    for j=1:15
        Aeq(i, 15*(i-1)+j)=1;
        if (ZerosVar(i,j)==1)
            Aeq(890, 15*(i-1)+j)=1;
        end
    end
end

%Beq -> Aeq*x=Beq
Beq=ones(1, 890);
Beq(890)=0;

x1=linprog(f, A, B, Aeq, Beq, zeros(13335, 1), ones(13335,1));