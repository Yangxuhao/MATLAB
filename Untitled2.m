
%�����ز�������8����Ԫ�������ѵ��ź�%
a=randsrc(1,8,[0:1]);%����8������Ķ�������
l=linspace(0,2*pi,50);%����linspace������������,2pi����ȡ��50��ģ��һ����Ԫ
f=sin(2*l);%�����ز�
t=linspace(0,10*pi,400);%����ʱ��lengthΪ10pi,ȡ��400��������8����Ԫ����ȡ������
out=1:400;%�涨�ѵ��ź�length
b=1:400;% �涨�����ź�length
w=1:400;%�涨�ز�length
%����PSK�ź�% 
for i=1:8 
    if a(i)==0 
      for j=1:50 
          out(j+50*(i-1))=f(j); %����ԪΪ0���ز����
      end 
    else 
      for j=1:50 
          out(j+50*(i-1))=-f(j); %����ԪΪ1���ز��������
      end 
    end 
end 
%����ز��ͻ����ź�%
for i=1:8  
    for j=1:50 
        b(j+50*(i-1))=a(i); %b��Ϊ�����ź����
        w(j+50*(i-1))=f(j); %w��Ϊ�ز����
    end 
end 
figure(1)
subplot(3,3,1),plot(t,b),axis([0 10*pi -0.5 1.2]), xlabel('t'),ylabel('����'),title('�����ź�');grid on; 
subplot(3,3,2),plot(t,w),axis([0 10*pi -1.2 1.2]), xlabel('t'),ylabel('����'),title('�ز�'); grid on;
subplot(3,3,3),plot(t,out),axis([0 10*pi -1.2 1.2]),xlabel('t'),ylabel('����'),title('BPSK����');grid on;
%�ѵ��źż����˹������%
noise=awgn(out,80,'measured') ; 
%�������������뵽�ѵ��ź�out��,�����80
figure(2)
subplot(331); 
plot(t,noise); 
ylabel('����');title('����+�ź�'); xlabel('t');
axis([0 10*pi -1.2 1.2]); grid on;
%�ź�ͨ��BPF%
Fs=400;                                       %����Ƶ��400HZ
t=(1:400)*10*40/Fs;                             %ʱ�Ჽ��
[b,a]=ellip(4,0.1,40,[10,25]*2/Fs);                  %���IIR-BPF
sf=filter(b,a,noise);
figure(2)
%�ź�ͨ�����˲���
subplot(332); 
plot(t,sf);                                      %�����ź�ͨ����BPF�Ĳ���
xlabel('t'); ylabel('����');title('ͨ��BPF��Ĳ���'); 
axis([0 10*pi -1.2 1.2]);grid on;
%�źž��������%
f=[f f f f f f f f];                   %%�����ز������ĳ��ȣ���BPF�������ͳһlength
s=sf.*f;%�ź����ز����
s=(-1).*s;
figure(2)
subplot(333); 
plot(t,s);%�����ź�ͨ����������Ĳ���
xlabel('t'); ylabel('����');title('ͨ�����������'); 
axis([0 10*pi -1 1]);grid on;
%�ź�ͨ��LPF%
Fs=400;                                      %����Ƶ��400HZ
t=(1:400)*10*pi/Fs;                            %ʱ�Ჽ��
[b,a]=ellip(4,0.1,40,[10]*2/Fs);                   %���IIR-LPF
sf=filter(b,a,s);  
figure(3)
%�ź�ͨ�����˲���
subplot(331); 
plot(t,sf);                                     %�����ź�ͨ���õ�ͨ�˲����Ĳ���
xlabel('t'); ylabel('����');title('ͨ��LPF��Ĳ���'); 
axis([0 10*pi -1 1]);grid on;
%�����о�%
b=0.26;                                       %�����о�����
for i=1:8 
  for j=1:50 
     if sf(j+50*(i-1))>b
        sf(j+50*(i-1))=1;                       %��sf>�о����ޣ�˵����ʱ��ԪΪ1
     else 
        sf(j+50*(i-1))=0;                       %��sf<�о����ޣ�˵����ʱ��ԪΪ0
     end 
  end 
end
figure(3)
subplot(332); 
plot(t,sf);                                      %�����ź�ͨ�������о����Ĳ���
xlabel('t'); ylabel('����');
title('�����о�����'); 
axis([3 10*pi -0.5 1.2]);
grid on;
for i=1:8 
  for j=1:50 
     if sf(j+50*(i-1))==out(j+50*(i-1))
       Nombreerreur(j) = Nombreerreur(j) + 1;
             
     end 
  end 
     
    Tauxderreur(j) = Nombreerreur(j) / 8;
    TauxderreurTheorique(j) = erfc(sqrt(power(10,EbNo(j)/10)))/2;   
end

%�Ƚ�ʵ�������ʺ��������������� 
figure  

semilogy(EbNo,Tauxderreur,EbNo,TauxderreurTheorique);

