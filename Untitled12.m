clear all;
close all;
nsymbol = 10^7;   %%发送的符号数10^7
data = randi([0,1],1,nsymbol);  %%产生1行均匀分布的随机数0,1作为发送的信息序列
bpsk_mod = data.*2 - 1;   %%调制过程，0转化为-1；1转化为1
pow = norm(bpsk_mod).^2/nsymbol;    %%求每个符号的平均能量
SNR_dB = 0:1:10;      %%%信噪比dB形式
SNR = 10.^(SNR_dB/10);     %%信噪比转化为线性值

for loop= 1:length(SNR)
    sigma = sqrt(pow/(2*SNR(loop)));      %%根据符号功率求噪声功率
    bpsk_receive = bpsk_mod+sigma*(randn(1,length(bpsk_mod)));      %%添加复高斯白噪声
    bpsk_demod = (real(bpsk_receive)>0);     %%解调
    data_receive = double(bpsk_demod);
    [err,ser(loop)] = symerr(data,data_receive);    %误码率;
end

ser_theory = qfunc(sqrt(2*SNR));   %理论误码率公式
semilogy(SNR_dB,ser,'-ro',SNR_dB,ser_theory,'-b*');
title('BPSK信号在AWGN信道下的性能');
xlabel('信噪比/dB');ylabel('误码率');
legend('BPSK误码率','BPSK理论误码率');
grid on;
