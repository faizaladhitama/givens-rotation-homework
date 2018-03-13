function [x] = backward(U,b)
    [~,n]=size(U);
    x=zeros(n,1);
    x(n) = b(n)/U(n,n);
    for i=n-1:-1:1
        sum=b(i);
        for j=i+1:n
            sum=sum-U(i,j)*x(j);
        end
        x(i)=sum/U(i,i);
    end

