%构造载波，产生8个码元，生成已调信号%
a=randsrc(1,8,[0:1]);%产生8个随机的二进制数
l=linspace(0,2*pi,50);%利用linspace函数创建数组,2pi长度取点50个模拟一个码元
f=sin(2*l);%生成载波
t=linspace(0,10*pi,400);%定义时轴length为10pi,取点400个，代表8个码元的总取样点数
out=1:400;%规定已调信号length
b=1:400;% 规定基带信号length
w=1:400;%规定载波length
%生成PSK信号% 
for i=1:8 
    if a(i)==0 
      for j=1:50 
          out(j+50*(i-1))=f(j); %若码元为0则将载波输出
      end 
    else 
      for j=1:50 
          out(j+50*(i-1))=-f(j); %若码元为1则将载波反相输出
      end 
    end 
end 
%输出载波和基带信号%
for i=1:8  
    for j=1:50 
        b(j+50*(i-1))=a(i); %b作为调制信号输出
        w(j+50*(i-1))=f(j); %w作为载波输出
    end 
end 
subplot(3,3,1),plot(t,b),axis([0 10*pi -0.5 1.2]), xlabel('t'),ylabel('幅度'),title('基带信号');grid on; 
subplot(3,3,2),plot(t,w),axis([0 10*pi -1.2 1.2]), xlabel('t'),ylabel('幅度'),title('载波'); grid on;
subplot(3,3,3),plot(t,out),axis([0 10*pi -1.2 1.2]),xlabel('t'),ylabel('幅度'),title('PSK波形');grid on;
%已调信号加入高斯白噪声%
noise=awgn(out,80,'measured') ;             %产生噪音并加入到已调信号out中,信噪比80
subplot(334); 
plot(t,noise); 
ylabel('幅度');title('噪音+信号'); xlabel('t');
axis([0 10*pi -1.2 1.2]); grid on;
%信号通过BPF%
Fs=400;                                       %抽样频率400HZ
t=(1:400)*10*40/Fs;                             %时轴步进
[b,a]=ellip(4,0.1,40,[10,25]*2/Fs);                  %设计IIR-BPF
sf=filter(b,a,noise);                              %信号通过该滤波器
subplot(335); 
plot(t,sf);                                      %画出信号通过该BPF的波形
xlabel('t'); ylabel('幅度');title('通过BPF后的波形'); 
axis([0 10*pi -1.2 1.2]);grid on;
%信号经过相乘器%
f=[f f f f f f f f];                   %%调整载波函数的长度，与BPF输出函数统一length
s=sf.*f;%信号与载波相乘
s=(-1).*s;
subplot(336); 
plot(t,s);%画出信号通过该相乘器的波形
xlabel('t'); ylabel('幅度');title('通过相乘器后波形'); 
axis([0 10*pi -1 1]);grid on;
%信号通过LPF%
Fs=400;                                      %抽样频率400HZ
t=(1:400)*10*pi/Fs;                            %时轴步进
[b,a]=ellip(4,0.1,40,[10]*2/Fs);                   %设计IIR-LPF
sf=filter(b,a,s);                                %信号通过该滤波器
subplot(337); 
plot(t,sf);                                     %画出信号通过该低通滤波器的波形
xlabel('t'); ylabel('幅度');title('通过LPF后的波形'); 
axis([0 10*pi -1 1]);grid on;
%抽样判决%
b=0.26;                                       %设置判决门限
for i=1:8 
  for j=1:50 
     if sf(j+50*(i-1))>b
        sf(j+50*(i-1))=1;                       %若sf>判决门限，说明此时码元为1
     else 
        sf(j+50*(i-1))=0;                       %若sf<判决门限，说明此时码元为0
     end 
  end 
end
subplot(338); 
plot(t,sf);                                      %画出信号通过抽样判决器的波形
xlabel('t'); ylabel('幅度');
title('抽样判决后波形'); 
axis([3 10*pi -0.5 1.2]);
grid on;


figure
r=-6:3:12;
rr=10.^(r/10);
pe1=1/2*exp(-rr);%相干解调的误码率曲线
hold on
plot(r,pe1,'r');grid on;
pe2=(1-1/2*erfc(sqrt(rr))).*erfc(sqrt(rr));%差分相干解调的误码率曲线
plot(r,pe2,'b');xlabel('bpsk,dpsk误码率曲线');
set(gca,'XTick',-6:3:18);