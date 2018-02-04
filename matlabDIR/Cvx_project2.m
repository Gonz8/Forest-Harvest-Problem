load('data.mat')
ANPV=diag(Area)*NPV;
vht=diag(Area)*Vol;
adj_rows = size(Adj,1);

cvx_begin quiet
    variable x(N, T);
    variable VH(N, T);
    maximize(sum(sum(ANPV.*x)));
    %subject to
        x>=0; x<=1;
        VH==vht.*x;
        for j = 1:889
           sum(x(j, :)) == 1;
           for i=1:15
               if (ZerosVar(j,i)==1)
                   x(j, i)==0;
               end
           end
        end;
        for i = 2:T
           0.8*sum(VH(:,i-1))<= sum(VH(:,i));
           1.2*sum(VH(:,i-1))>= sum(VH(:,i));
        end;
        %adjacency constraint
        for t = 1:T
            for r = 1:adj_rows
                x(Adj(r,1),t) + x(Adj(r,2),t) <= 1;
            end;
        end;
        %end adjacency st
        
cvx_end;

x_cvx=zeros(1,13335);
for i=1:889
    for j=1:15
       x_cvx(1, j+15*(i-1))=x(i,j);
    end
end

%adjacency constraint failures
adj_failures = 0;
for t = 1:T
    for r = 1:adj_rows
        if(x(Adj(r,1),t) > 0.45 && x(Adj(r,1),t) < 0.55 && x(Adj(r,2),t) > 0.45 && x(Adj(r,2),t) < 0.55)
            adj_failures = adj_failures + 1;
        end;
    end;
end;

adj_failure_factor = adj_failures / (adj_rows*T); 

%solution: Volume per year
vol_year = sum(VH(:,:));

        
