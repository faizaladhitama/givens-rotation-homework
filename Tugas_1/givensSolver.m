function [x] = givensSolver(A,b)
    tic
    [Q,R,P] = givensRotation(A);
    R
    toc
    [~,n]=size(R);
    x=zeros(n,1);
    bt = transpose(Q)*b;
    x(n) = bt(n)/R(n,n);
    for i=n-1:-1:1
        sum=bt(i);
        for j=i+1:n
            sum=sum-R(i,j)*x(j);
        end
        x(i)=sum/R(i,i);
    end
    x = P*x;
    abs(norm(A*x-b))
    abs(norm(A*x-b))/abs(norm(b))
end

