ANPV=diag(Area)*NPV;
vht=diag(Area)*Vol;

cvx_begin quiet
    variable x(N, T);
    maximize(sum(sum(ANPV.*x)));
    %subject to
        x>=0; x<=1;
        VH=vht.*x;
        for i = 1:889
           sum(x(i, :)) == 1;
        end;
        for j = 2:T
           0.5*sum(VH(:,j-1))<= sum(VH(:,j));
           1.5*sum(VH(:,j-1))>= sum(VH(:,j));
        end;
cvx_end;
