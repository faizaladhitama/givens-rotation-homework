function [Q,R,P] = givensRotation(A)
    [m,n] = size(A);
    Q = eye(m);
    P = eye(n);
    for j = 1:n
        index_max=j;
        for l=j:n-1
            if norm(A(:,l))>norm(A(:,index_max))
                index_max=l;
            end
        end
        if index_max ~= j
            temp = A(:,j);
            A(:,j)=A(:,index_max);
            A(:,index_max)=temp;
            temp_p = P(:,j);
            P(:,j)=P(:,index_max);
            P(:,index_max)=temp_p;
        end
        for i = m:-1:(j+1)
          G = eye(m);
          [c,s] = csRotation(A(i-1,j),A(i,j));
          G([i-1, i],[i-1, i]) = [c s; -s c];
          for k=j:n
              temp = A;
              A(i-1,k)=G(i-1,:)*temp(:,k);
              A(i,k)=G(i,:)*temp(:,k);
          end
          Q = Q*transpose(G);
        end
    end
    R = A(1:n,1:n);
    Q = Q(1:m,1:n);
end