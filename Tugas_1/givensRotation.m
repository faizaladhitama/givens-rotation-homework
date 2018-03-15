function [Q,R,P] = givensRotation(A)
    [m,n] = size(A);
    Q = eye(m);
    P = eye(n);
    for j = 1:n
        %{
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
        %}
        for i = m:-1:(j+1)
          G = eye(m);
          a = A(i-1,j);
          b = A(i,j);
          if a==0 && abs(b) > 0
              s = sign(b);
              c = 0;
          elseif b==0 && abs(a) >0
              c = sign(a);
              s = 0;
          else
              %{
              if abs(a) > abs(b)
                t = b/a;
                u = sign(a)*abs(sqrt(1+t*t));
                c = 1/u;
                s = c*t;
              elseif abs(b) > abs(a)
                t = a/b;
                u = sign(b)*abs(sqrt(1+t*t));
                s = 1/u;
                c = s*t;
              end
              %}
              r = sqrt(a^2+b^2);
              c = a/r;
              s = b/r;
          end
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