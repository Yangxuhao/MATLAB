clear all;
close all;
nsymbol = 10^7;   %%���͵ķ�����10^7
data = randi([0,1],1,nsymbol);  %%����1�о��ȷֲ��������0,1��Ϊ���͵���Ϣ����
bpsk_mod = data.*2 - 1;   %%���ƹ��̣�0ת��Ϊ-1��1ת��Ϊ1
pow = norm(bpsk_mod).^2/nsymbol;    %%��ÿ�����ŵ�ƽ������
SNR_dB = 0:1:10;      %%%�����dB��ʽ
SNR = 10.^(SNR_dB/10);     %%�����ת��Ϊ����ֵ

for loop= 1:length(SNR)
    sigma = sqrt(pow/(2*SNR(loop)));      %%���ݷ��Ź�������������
    bpsk_receive = bpsk_mod+sigma*(randn(1,length(bpsk_mod)));      %%��Ӹ���˹������
    bpsk_demod = (real(bpsk_receive)>0);     %%���
    data_receive = double(bpsk_demod);
    [err,ser(loop)] = symerr(data,data_receive);    %������;
end

ser_theory = qfunc(sqrt(2*SNR));   %���������ʹ�ʽ
semilogy(SNR_dB,ser,'-ro',SNR_dB,ser_theory,'-b*');
title('BPSK�ź���AWGN�ŵ��µ�����');
xlabel('�����/dB');ylabel('������');
legend('BPSK������','BPSK����������');
grid on;
