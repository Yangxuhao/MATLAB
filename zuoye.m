[x,Fs,bits]=wavread('noisy_music.wav');            %读取音频文件信息
len=length(x);
X=fft(x);                            
magX=abs(X);                                      
subplot(221);plot(x);title('原始信号波形');         %绘制音频文件时域波形
f=0:Fs/len:(len-1)*Fs/len;
subplot(222);plot(f,magX);title('原始信号频谱');    %绘制频域波形
wp=2*pi*5000/Fs;
ws=2*pi*5500/Fs;
[n,wn]=cheb1ord(wp/pi,ws/pi,0.5,60);
[bz1,az1]=cheby1(n,0.5,wp/pi);
y=filter(bz1,az1,x);                               %低通滤波4
[H,w]=freqz(bz1,az1,512);
subplot(223);plot(w,abs(H)); title('滤波器频响')    %滤波器频响
sound(y,Fs);                                       %试听
subplot(224);plot(abs(fft(y)));title('滤波后频谱')  %滤波后频谱
wavwrite(y,Fs,bits,'denoised.wav') ;               %保存文件