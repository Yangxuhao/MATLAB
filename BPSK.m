a=randsrc(1,8,[0:1]);
l=linspace(0,2*pi,50);
f=sin(2*l);
t=linspace(0,10*pi,400);
out=1:400;
b=1:400;
w=1:400;
for i=1:8
    if a(i)==0
        for j=1:50
            out(j+50*(i-1))=f(j);
        end
    else
        for j=1:50
            out(j+50*(i-1))=-f(j);
        end
    end
end

for i=1:8
    for j=1:50
        b(j+50*(i-1))=a(i);
    end
end

subplot(211),plot(t,out),axis([0 10*pi -1.2 1.2]),title('BPSK调制波形');grid on;
subplot(212),plot(t,b),axis([0 10*pi -0.5 1.2]),title('基带信号');grid on;

