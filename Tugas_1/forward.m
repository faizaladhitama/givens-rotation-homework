function [x] = forward(L,b)
    n=length(b);
    x(1) = b(1)/L(1,1);
    for i=2:n
        sum=0;
        for j=1:i-1
            sum=sum+L(i,j)*x(j);
        end
        x(i)=(b(i)-sum)/L(i,i);
    end

