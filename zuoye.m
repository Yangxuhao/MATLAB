[x,Fs,bits]=wavread('noisy_music.wav');            %��ȡ��Ƶ�ļ���Ϣ
len=length(x);
X=fft(x);                            
magX=abs(X);                                      
subplot(221);plot(x);title('ԭʼ�źŲ���');         %������Ƶ�ļ�ʱ����
f=0:Fs/len:(len-1)*Fs/len;
subplot(222);plot(f,magX);title('ԭʼ�ź�Ƶ��');    %����Ƶ����
wp=2*pi*5000/Fs;
ws=2*pi*5500/Fs;
[n,wn]=cheb1ord(wp/pi,ws/pi,0.5,60);
[bz1,az1]=cheby1(n,0.5,wp/pi);
y=filter(bz1,az1,x);                               %��ͨ�˲�4
[H,w]=freqz(bz1,az1,512);
subplot(223);plot(w,abs(H)); title('�˲���Ƶ��')    %�˲���Ƶ��
sound(y,Fs);                                       %����
subplot(224);plot(abs(fft(y)));title('�˲���Ƶ��')  %�˲���Ƶ��
wavwrite(y,Fs,bits,'denoised.wav') ;               %�����ļ�