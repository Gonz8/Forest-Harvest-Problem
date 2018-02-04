ANPV=diag(Area)*NPV;
vht=diag(Area)*Vol;

for i=1:889
    for j=1:15
        f(1, j+15*(i-1))=ANPV(i,j);
    end
end

A=zeros(15,13335);
for i=1:14
    for j=1:889
        A(i, 15*(j-1)+i)=0.5*vht(j,i);
        A(i+14, 15*(j-1)+i)=-1.5*vht(j,i);
    end
end
   


Aeq=zeros(889,13335);

for i=1:889
    for j=1:15
        Aeq(i, 15*(i-1)+j)=1;
    end
end

Beq=ones(1, 889);

x=linprog(f, A, B, Aeq, Beq, 0, 1);