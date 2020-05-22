clc
clear

%% Task 2
p0 = 0.05; r0 = 5; N = 10;
A = 1; B = 1;
iA = 0; iB = 0;
VA = zeros(N+1,1); VB = zeros(N+1,1); VBn = zeros(N+1,1);
VA(1,1) = 1; VB(1,1) = 0; VBn(1,1) = 0;
alpha = []; beta = [];

for i = 1:1:N
   alpha(i) = exp(-p0*i); beta(i) = 1-(i/(r0+i));
   if A == 1
       if alpha(i) < VB(i)
           VA(i+1) = VB(i);
       else
           VA(i+1) = alpha(i);
           iA = iA + 1;
       end
   end     
    
   if B == 1
       if (1 - beta(i)) > VA(i)
           VB(i+1) = VA(i);
       else
           VB(i+1) = 1 - beta(i);
           iB = iB + 1;
       end
   end
   
   % non-optimal strategy for Bruno in Task 3
   if B == 1 
       if alpha(i) >0.5 && beta(i) > 0.5
           VBn(i+1) = 1 - beta(i);
       else
           VBn(i+1) = VA(i);
       end
   end
end

%% Plot of the sequences
figure(1)
plot(0:N, VA); hold on;
plot(0:N, VB); hold on; grid on;
xlabel('Distance between Players (i)'); ylabel('Value');
title('Value Functions'); legend('VA','VB'); 

figure(2)
plot(0:N, VA); hold on;
plot(0:N, VB); hold on;
plot(0:N, VBn); hold on; grid on;
xlabel('Distance between Players (i)'); ylabel('Value');
title('Value Functions'); legend('VA','VB','non-optimal VB'); 

%% Largest interger i
X = ['The largest distance when Annie should first shoot is ', num2str(iA)];
Y = ['The largest distance when Bruno should first shoot is ', num2str(iB)];
disp(X); disp(Y);