%�����ļ�����ʾʱ/Ƶ��ͼ
[y,fs] = audioread('E:\MATLAB\noisy_music.wav');
dataFFT =fft(y);
plot(y);
magX = abs(dataFFT);
figure(1)
subplot(211);plot(y);title('������������Ƶ�ź�');
subplot(212),plot(magX);title('����������Ƶ�ź�Ƶ��');

%��ͨ�˲�
Fpass = 0;
Fstop = 5000;

Dpass = 0.057501127785;
Dstop = 0.0001;
dens = 20;
[N1,Fo,Ao,W] = firpmord([Fpass,Fstop]/(fs/2),[1 0],[Dpass,Dstop]);
b = firpm(N1,Fo,Ao,W,{dens});

y1=filter(b,1,y);
y1f=fft(y1);
figure(2)
subplot(211),plot(y1);title('�˲������Ƶ�ź�');

subplot(212),plot(abs(y1f));title('�˲����Ƶ��ͼ');
audiowrite('denoised.wav',y1,fs);
%Ƶ�����ʾ
wp=2*pi*5000/fs;
ws=2*pi*5500/fs;
[n,wn]=cheb1ord(wp/pi,ws/pi,0.5,60);
[bz1,az1]=cheby1(n,0.5,wp/pi);
[H,w]=freqz(bz1,az1,512);
figure(3)
plot(w,abs(H)); title('�˲���Ƶ��');  








