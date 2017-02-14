clear all 
close all 
clc  
num=10; 

tnum=20; 
N=num*tnum; 
 t=0:1/48000:1/240-1/48000; 
a=round(rand(1,10)); 
%a=[0,1,1,1,0,1,0,1]; 
fc=4800;
 fs=48000; 
S=[]; %%  % 初始码元
 C=zeros(1,200); 
for i=1:num    
 if(a(i)==0)       
   A=zeros(1,tnum);  
   else         
 A=ones(1,tnum);     
end       
S=[S A];    
end   
 cs=sin(2*pi*t*fc); 
       C=cs;
figure(1);subplot(4,1,1);plot(S);grid on;
 xlabel('基带信号s(t)'); axis([0 N -2 2]); 
%%  %BPSK调制 
S_NRZ=[]; 
for i=1:num 
if(a(i)==0)          
A=ones(1,tnum);  
   else          
A=-1*ones(1,tnum);   
  end      
 S_NRZ=[S_NRZ A];    
end  
e=S_NRZ.*C;  
figure(1);subplot(4,1,2);plot(e);grid on; 
xlabel('BPSK调制信号'); axis([0 N -2 2]); 
%%  
%加入噪声 
am=0.7;
SNR=5; 
 snr=10^(SNR/10); N0=(am*am)/2/snr; 
N0_db=10*log10(N0);
 ni=wgn(1,N,N0_db); 
yi=e+ni;  
figure(1);subplot(4,1,3);plot(yi);grid on;
 xlabel('加入高斯白噪声的已调信号yi(t)'); 
%%  
%带通滤波   
[b1,a1]=BUTTER(3,[0.1,0.3]);  %带通滤波器 
y=filter(b1,a1,yi); 
 figure(1);subplot(4,1,4);plot(y);grid on;
 xlabel('经带通滤波器后信号'); 
%%  
 x1=2*C.*y;  figure(2);subplot(4,1,1);plot(x1);grid on; 
xlabel('与恢复载波相乘后的信号x1(t)');   [
b2,a2]=butter(4,0.1,'low');%低通滤波
x=filter(b2,a2,x1); 
 figure(2);subplot(4,1,2);plot(x);grid on; 
axis([0 N -2 2]);  
xlabel('经低通滤波器后信号波形');
 q=fun_panjue(x);  
figure(2);subplot(4,1,3);plot(q);grid on; 
xlabel('加噪后解调信号x(t)'); 
axis([0 N -2 2]); 
p=fun_yanc(q); 
 figure(2);subplot(4,1,4);plot(p);grid on; 
xlabel('加噪后去掉延迟的解调信号x(t)'); 
axis([0 N -2 2]);  
 Err1=length(find(p~=S)); 
Pe_test1=Err1/N;  
Pe1=(1/2)*erfc(sqrt(snr)); 
  Pe=[];  
for SNR=1:10    
 am=0.7;    
 E=am*am/2;    
  snr=10^(SNR/10); 

 N0=(am*am)/2/snr; 
    n0=N0/2/200;  
    N0_db=10*log10(N0);   
  ni=wgn(1,N,N0_db);    
 yi=e+ni;      
y=filter(b1,a1,yi);    
 x1=2*C.*y;      
xx=filter(b2,a2,x1);   
  xx=fun_panjue(xx);    
 xx=fun_yanc(xx);    
 snr=10^(SNR/10);      
Pe=[Pe,(1/2)*erfc(sqrt(snr))]; 
end 
Pe; 
figure;  
SNR=1:10;  
semilogy(SNR,Pe,'b--');
hold on 
grid on  