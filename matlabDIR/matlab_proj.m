%Forest harvesting - MATLAB linprog

ANPV=diag(Area)*NPV;
vht=diag(Area)*Vol;
ANPV_vec = ANPV(:);
vht_vec = vht(:);

%parameters for linprog function
f = (-1) * ANPV_vec.*ones(N*T,1);

Aeq = zeros(N*T,N);
Beq = ones(N,1);
for i = 1:N
    Aeq(i*T-(T-1):i*T,i) = ones(T,1); 
end;



