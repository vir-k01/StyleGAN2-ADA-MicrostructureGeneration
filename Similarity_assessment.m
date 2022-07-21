% Code accompanying the manuscript: "Quantification of similarity and physical awareness 
% of microstructures generated via Generative Models" by Sanket Thakre, Vir Karan, Anand Krishna Kanjarla.

% Similarity assesment of GAN generated microstrctures
clear
cd('C:/Users/sanket/Desktop/Virus vac/GAN awareness')
corr_m = importdata('corr_m.csv');
corr_g = importdata('corr_g.csv');

% Only include phase not the interfaces, GAN cannot mimic interfaces
% For phase
%for i = 1:18
%    ssim_val(i,1) = ssim(corr_g(i,1:65025),corr_m(i,1:65025));
%    psnr_val(i,1) = psnr(corr_g(i,1:65025),corr_m(i,1:65025));
%    snr_val(i,1) = snr(corr_g(i,1:65025),corr_m(i,1:65025));
%   mse_val(i,1) = immse(corr_g(i,1:65025),corr_m(i,1:65025));
%end
%val = [ssim_val,mse_val,psnr_val,snr_val];

% For interface
for i = 1:18
    ssim_val(i,1) = ssim(corr_g(i,65026:130050),corr_m(i,65026:130050));
    psnr_val(i,1) = psnr(corr_g(i,65026:130050),corr_m(i,65026:130050));
   snr_val(i,1) = snr(corr_g(i,65026:130050),corr_m(i,65026:130050));
   mse_val(i,1) = immse(corr_g(i,65026:130050),corr_m(i,65026:130050));
end
val = [ssim_val,mse_val,psnr_val,snr_val];

%For both together
%for i = 1:18
%    ssim_val(i,1) = ssim(corr_g(i,:),corr_m(i,:));
%    psnr_val(i,1) = psnr(corr_g(i,:),corr_m(i,:));
%    snr_val(i,1) = snr(corr_g(i,:),corr_m(i,:));
%    mse_val(i,1) = immse(corr_g(i,:),corr_m(i,:));
%end
%val = [ssim_val,mse_val,psnr_val,snr_val];

for i = 1:4
    for j = 1:6
        class_avg(j,i) = (val(j,i)+val(j+6,i)+val(j+12,i))/3;
    end
end

class = [1,2,3,4,5,6];

% Bar plots
for i = 1:6
    cnt = -1;
    for j = 1:3
        cnt = cnt + 1;
        coal_ssim(i,j) = val(i+cnt*6,1);
        coal_mse(i,j) = val(i+cnt*6,2);
        coal_psnr(i,j) = val(i+cnt*6,3);
        coal_snr(i,j) = val(i+cnt*6,4);
    end
end
figure
bar(coal_ssim)
grid on
ylim([0.85 1])
pbaspect([1 1 1])
ax = gca;
ax.FontSize = 18; 
set(gca, 'XTick', 1:6)
title('SSIM plots','fontsize',28)
xlabel('Class','fontsize',24)
ylabel('Values','fontsize',24)

figure
bar(coal_mse)
grid on
pbaspect([1 1 1])
ax = gca;
ax.FontSize = 18; 
set(gca, 'XTick', 1:6)
title('MSE plots','fontsize',28)
xlabel('Class','fontsize',24)
ylabel('Values','fontsize',24)

figure
bar(coal_psnr)
grid on
pbaspect([1 1 1])
ax = gca;
ax.FontSize = 18; 
set(gca, 'XTick', 1:6)
title('PSNR plots','fontsize',28)
xlabel('Class','fontsize',24)
ylabel('Values','fontsize',24)

figure
bar(coal_snr)
grid on
ylim([-0.5 5])
pbaspect([1 1 1])
ax = gca;
ax.FontSize = 18; 
set(gca, 'XTick', 1:6)
title('SNR plots','fontsize',28)
xlabel('Class','fontsize',24)
ylabel('Values','fontsize',24)

%%
% SSIM analysis
% Using a vector or matrix does not affect much the SSIM values
class = 5;
gp = reshape(corr_g(class,1:65025),255,255);
mp = reshape(corr_m(class,1:65025),255,255);
gi = reshape(corr_g(class,65026:130050),255,255);
mi = reshape(corr_m(class,65026:130050),255,255);
%[ssimval,ssimmap] = ssim(corr_g(1,:),corr_m(1,:));
[ssim_p,ssimmap_p] = ssim(gp,mp);
[ssim_i,ssimmap_i] = ssim(gi,mi);

figure
imshow(ssimmap_p, [])
figure
imshow(ssimmap_i, [])

% Estimating noise power
[SNR,npow] = snr(corr_g(1,:),corr_m(1,:));
