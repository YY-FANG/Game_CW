clc
clear

%% Task 3
p0 = 0.05; r0 = 5; N = 10; B_op = 0;
VA = zeros(N+1,1); VB = zeros(N+1,1);
VA(N+1,1) = 1; VB(N+1,1) = 0;
alpha = []; beta = []; VA_h = [];

for i = 1:1:N
    alpha(i) = exp(-p0*i); beta(i) = 1-(i/(r0+i));
    VA(N-i+1,1) = max(alpha(i),VB(N-i+2,1));
    VB(N-i+1,1) = min((1-beta(i)),VA(N-i+2,1));
end

for times = 1:100
    nA = 0; % number of A wins
    for t = 0:N
        i = N-t; % distance
        alpha(i) = exp(-p0*i); beta(i) = 1-(i/(r0+i));
        if mod(t,2) == 0 % A acts first
            if i<6 % optimal strategy
                nA = nA + alpha(i);
                break;
            end
        else  
            if B_op == 1
                if i<10 % optimal strategy
                    nA = nA + 1-beta(i);
                    break;
                end
            else
                if alpha(i) > 0.5 && beta(i) > 0.5
                    nA = nA+1-beta(i);
                    break;
                end
            end
        end
    end

    VA_h = [VA_h nA];
end
avg = sum(VA_h)/times; 

%% Value of the game
if B_op == 1
    X = ('The optimal value of the game when both players take optimal strategies is ');
    X1 = ['                                                                           ', num2str(VA(1),4)]; 
    Y = ['The propotion of times that Annie wins over ', num2str(times), ' simulations when both players take optimal strategies is '];
    Y1 = ['                                                                                                         ', num2str(avg,4)]; 
else
    X = ('The optimal value of the game when both players take optimal strategies is ');
    X1 = ['                                                                           ', num2str(VA(1),4)]; 
    Y = ['The propotion of times that Annie wins over ', num2str(times), ' simulations when Bruno takes non-optimal strategy is '];
    Y1 = ['                                                                                                     ', num2str(avg,4)]; 
end
disp(X); disp(X1); disp(Y); disp(Y1);