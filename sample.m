%ADAPTIVE WEINER FILTER CODE STARTS FROM HERE
RGB = imread('Coins.png');
OrigImage = rgb2gray(RGB);
SPNoise = input('Enter Salt & Pepper noise density (Adaptive Weiner Filter):  ');
SPNoisyImage = imnoise(OrigImage,'salt & pepper',SPNoise);
Convert_Sp_Noise_Image = im2uint8(SPNoisyImage);
Speckle_Noise = input('Enter Speckle noise variable (Adaptive Weiner Filter):  ');
Speckle_NoisyImage = imnoise(OrigImage,'speckle', Speckle_Noise);
Convert_Speckle_Noise_Image = im2uint8(Speckle_NoisyImage);
%Poisson_Noise = input('Enter Poisson noise variable:  ');
Poisson_NoisyImage = imnoise(OrigImage,'Poisson');
Convert_Poisson_Noise_Image = im2uint8(Poisson_NoisyImage);
figure('units','normalized','outerposition',[0 0 1 1],'Name','Adaptive Weiner filter','NumberTitle','off')
subplot(3,3,1);
imshow(SPNoisyImage);
title('Image After adding Salt & Pepper noise');
subplot(3,3,2);
imshow(Speckle_NoisyImage);
title('Image After adding Speckle Noise');
subplot(3,3,3);
imshow(Poisson_NoisyImage);
title('Image After adding Poisson Noise');
SP_FilteredImage = wiener2(SPNoisyImage,[5 5]);
Convert_Sp_filtered_Image = im2uint8(SP_FilteredImage);
subplot(3,3,4);
imshow(SP_FilteredImage);
title('Image after applying Adaptive Weiner filter for Slat & pepper noisy Image');
Speckle_FilteredImage = wiener2(Speckle_NoisyImage,[5 5]);
Convert_Speckle_filtered_Image = im2uint8(Speckle_FilteredImage);
subplot(3,3,5);
imshow(Speckle_FilteredImage);
title('Image after applying Adaptive Weiner filter for Speckle noisy Image');
Poisson_FilteredImage = wiener2(Poisson_NoisyImage,[5 5]);
Convert_Poisson_filtered_Image = im2uint8(Poisson_FilteredImage);
subplot(3,3,6);
imshow(Poisson_FilteredImage);
title('Image after applying Adaptive Weiner filter for Poisson noisy Image');
SP_MSE =immse(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);
[peaksnr, snr] = psnr(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);

TextonFIG = subplot(3,3,7);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f\n Signal to Noise ratio (SNR): %.2f', SP_MSE, peaksnr, snr),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Speckle_MSE =immse(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);
[peaksnr1, snr1] = psnr(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);


TextonFIG = subplot(3,3,8);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f ', Speckle_MSE, peaksnr1, snr1),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Poisson_MSE =immse(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);
[peaksnr2, snr2] = psnr(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);

TextonFIG = subplot(3,3,9);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f ', Poisson_MSE, peaksnr2, snr2),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off


%OPTIMAL WEINER FILTER CODE STARTS FROM HERE
RGB = imread('Coins.png');
OrigImage = rgb2gray(RGB);
Size=500;
ConvertOrigImage=double(OrigImage);

%original image PSD
FFTOrigImage=fft2(ConvertOrigImage);
PowerSpectralDensityOrigImage =fftshift((abs(FFTOrigImage).^2)./(Size*Size));

%noise
SPNoise = input('Enter Salt & Pepper noise density (Weiner Filter):  ');
SPNoisyImage = imnoise(OrigImage,'salt & pepper',SPNoise);
Convert_Sp_Noise_Image = im2uint8(SPNoisyImage);
Saltpnoise = imnoise(ConvertOrigImage, 'Salt & pepper', SPNoise);

Speckle_Noise = input('Enter Speckle noise variable (Weiner Filter):  ');
Speckle_NoisyImage = imnoise(OrigImage,'speckle', Speckle_Noise);
Convert_Speckle_Noise_Image = im2uint8(Speckle_NoisyImage);
Specklenoise = imnoise(ConvertOrigImage, 'Speckle', Speckle_Noise);


Poisson_NoisyImage = imnoise(OrigImage,'Poisson');
Convert_Poisson_Noise_Image = im2uint8(Poisson_NoisyImage);
Poissonnoise = imnoise(ConvertOrigImage, 'Poisson');

figure('units','normalized','outerposition',[0 0 1 1],'Name','Weiner filter (FFT)','NumberTitle','off')
subplot(3,3,1);
imshow(SPNoisyImage);
title('Image After adding Salt & Pepper noise');
subplot(3,3,2);
imshow(Speckle_NoisyImage);
title('Image After adding Speckle Noise');
subplot(3,3,3);
imshow(Poisson_NoisyImage);
title('Image After adding Poisson Noise');


%noise Salt & pepper PSD 
noiseFT=fft2(Saltpnoise);
noisePSD=fftshift((abs(noiseFT).^2)./(Size*Size));
eta=sum(sum(noisePSD))/(Size*Size);
%image+ Salt & pepper noise
SaltPnoisyImage=ConvertOrigImage+Saltpnoise;
ImageFT=fft2(SaltPnoisyImage);
Imageshifted=fftshift(ImageFT);



%noise Speckle PSD 
noiseFT1=fft2(Specklenoise);
noisePSD1=fftshift((abs(noiseFT1).^2)./(Size*Size));
eta1=sum(sum(noisePSD1))/(Size*Size);
%image+ speckle noise
SpecklenoisyImage=ConvertOrigImage+Specklenoise;
ImageFT1=fft2(SpecklenoisyImage);
Imageshifted1=fftshift(ImageFT1);

%noise Poisson PSD 
noiseFT2=fft2(Poissonnoise);
noisePSD1=fftshift((abs(noiseFT2).^2)./(Size*Size));
eta2=sum(sum(noisePSD1))/(Size*Size);
%image+ Poisson noise
PoissonnoisyImage=ConvertOrigImage+Poissonnoise;
ImageFT2=fft2(PoissonnoisyImage);
Imageshifted2=fftshift(ImageFT2);



%Salt & Pepper
FilterforSPnoise = fspecial('gaussian',[10 10], 1);
WeinerFilteredSp1mage = imfilter(uint8(SaltPnoisyImage), FilterforSPnoise, 'replicate');
FilterSPImageFFT=fft2(WeinerFilteredSp1mage);
FilterSPImagePSD=fftshift((abs(FilterSPImageFFT).^2)./(Size*Size));
%multiplication by wiener filter in the frequency domain
Cleared=zeros(Size);
ClearedFFT=zeros(Size);
for x=1:Size
    for y=1:Size
        F(x,y)=(FilterSPImagePSD(x,y)/(FilterSPImagePSD(x,y)+eta));
        ClearedFFT(x,y)=Imageshifted(x,y)*F(x,y);
    end
end

%inverse DFT to obtain the wiener filtered image
WeinerFilteredSPImage=(real(ifft2(ifftshift(ClearedFFT))));
subplot(3,3,4);
imshow(WeinerFilteredSp1mage);
title('Image after applying Weiner filter for Salt & pepper noise Image');
[M,N] = size(Convert_Sp_Noise_Image);
ResizedSPfilteredImage = imresize(WeinerFilteredSp1mage,[M,N]);
Convert_Sp_filtered_Image = im2uint8(ResizedSPfilteredImage);


%Speckle 
FilterforSpecklenoise = fspecial('gaussian',[5 5], 1);
WeinerFilteredSpeckle1mage = imfilter(uint8(SpecklenoisyImage), FilterforSpecklenoise, 'replicate');

%smoothed image PSD 
FilterSpeckleImageFFT=fft2(WeinerFilteredSpeckle1mage);
FilterSpeckleImagePSD=fftshift((abs(FilterSpeckleImageFFT).^2)./(Size*Size));
%multiplication by wiener filter in the frequency domain
Cleared1=zeros(Size);
ClearedFFT1=zeros(Size);
for a=1:Size
    for b=1:Size
        Fs(a,b)=(FilterSpeckleImagePSD(a,b)/(FilterSpeckleImagePSD(a,b)+eta1));
        ClearedFFT1(a,b)=Imageshifted1(a,b)*Fs(a,b);
    end
end

%inverse DFT to obtain the wiener filtered image
WeinerFilteredSpeckleImage=(real(ifft2(ifftshift(ClearedFFT1))));
subplot(3,3,5);
imshow(WeinerFilteredSpeckle1mage);
title('Image after applying Weiner filter for Speckle noisy Image');
[M,N] = size(Convert_Speckle_Noise_Image);
ResizedSpecklefilteredImage = imresize(WeinerFilteredSp1mage,[M,N]);
Convert_Speckle_filtered_Image = im2uint8(ResizedSpecklefilteredImage);

%Poisson
FilterforPoissonnoise = fspecial('gaussian',[15 15], 1);
WeinerFilteredPoisson1mage = imfilter(uint8(PoissonnoisyImage), FilterforPoissonnoise, 'replicate');
;
%smoothed image PSD 
FilterPoissonImageFFT=fft2(WeinerFilteredPoisson1mage);
FilterPoissonImagePSD=fftshift((abs(FilterPoissonImageFFT).^2)./(Size*Size));
%multiplication by wiener filter in the frequency domain
Cleared2=zeros(Size);
ClearedFFT2=zeros(Size);
for c=1:Size
    for d=1:Size
        Fp(c,d)=(FilterPoissonImagePSD(c,d)/(FilterPoissonImagePSD(c,d)+eta2));
        ClearedFFT2(c,d)=Imageshifted2(c,d)*Fp(c,d);
    end
end

%inverse DFT to obtain the wiener filtered image
WeinerFilteredPoissonImage=(real(ifft2(ifftshift(ClearedFFT2))));
subplot(3,3,6);
imshow(WeinerFilteredPoisson1mage);
title('Image after applying Weiner filter for Poisson noisy Image');
[M,N] = size(Convert_Poisson_Noise_Image);
ResizedPoissonfilteredImage = imresize(WeinerFilteredPoisson1mage,[M,N]);
Convert_Poisson_filtered_Image = im2uint8(ResizedPoissonfilteredImage);

SP_MSE =immse(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);
[peaksnr, snr] = psnr(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);


TextonFIG = subplot(3,3,7);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f \n', SP_MSE, peaksnr, snr),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Speckle_MSE =immse(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);
[peaksnr1, snr1] = psnr(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);

TextonFIG = subplot(3,3,8);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f', Speckle_MSE, peaksnr1, snr1),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Poisson_MSE =immse(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);
[peaksnr2, snr2] = psnr(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);


TextonFIG = subplot(3,3,9);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f', Poisson_MSE, peaksnr2, snr2),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off


%AVERAGE FILTER CODE STARTS FROM HERE
%Average filter
RGB = imread('Coins.png');
OrigImage = rgb2gray(RGB);
SPNoise = input('Enter Salt & Pepper noise density (Average filter):  ');
SPNoisyImage = imnoise(OrigImage,'salt & pepper',SPNoise);
Convert_Sp_Noise_Image = im2uint8(SPNoisyImage);
Speckle_Noise = input('Enter Speckle noise variable (Average filter):  ');
Speckle_NoisyImage = imnoise(OrigImage,'speckle', Speckle_Noise);
Convert_Speckle_Noise_Image = im2uint8(Speckle_NoisyImage);
%Poisson_Noise = input('Enter Poisson noise variable:  ');
Poisson_NoisyImage = imnoise(OrigImage,'Poisson');
Convert_Poisson_Noise_Image = im2uint8(Poisson_NoisyImage);
figure('units','normalized','outerposition',[0 0 1 1],'Name','Average Filter','NumberTitle','off')
subplot(3,3,1);
imshow(SPNoisyImage);
title('Image After adding Salt & Pepper noise');
subplot(3,3,2);
imshow(Speckle_NoisyImage);
title('Image After adding Speckle Noise');
subplot(3,3,3);
imshow(Poisson_NoisyImage);
title('Image After adding Poisson Noise');
SP_FilteredImage = filter2(fspecial('average',3),SPNoisyImage)/255;
Convert_SP_Filtered_Image = im2uint8(SP_FilteredImage);
subplot(3,3,4);
imshow(SP_FilteredImage);
title('Image after applying Average filter for Salt & pepper noisy Image');
Speckle_FilteredImage = filter2(fspecial('average',3),Speckle_NoisyImage)/255;
Convert_Speckle_Filtered_Image = im2uint8(Speckle_FilteredImage);
subplot(3,3,5);
imshow(Speckle_FilteredImage);
title('Image after applying Average filter for Speckle noisy Image');
Poisson_FilteredImage = filter2(fspecial('average',3),Poisson_NoisyImage)/255;
Convert_Poisson_Filtered_Image = im2uint8(Poisson_FilteredImage);
subplot(3,3,6);
imshow(Poisson_FilteredImage);
title('Image after applying Average filter for Poisson noisy Image');
SP_MSE =immse(Convert_Sp_Noise_Image, Convert_SP_Filtered_Image);
[peaksnr, snr] = psnr(Convert_Sp_Noise_Image, Convert_SP_Filtered_Image);


TextonFIG = subplot(3,3,7);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f', SP_MSE, peaksnr, snr),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Speckle_MSE =immse(Convert_Speckle_Noise_Image, Convert_Speckle_Filtered_Image);
[peaksnr1, snr1] = psnr(Convert_Speckle_Noise_Image, Convert_Speckle_Filtered_Image);

TextonFIG = subplot(3,3,8);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f\n Signal to Noise ratio (SNR): %.2f', Speckle_MSE, peaksnr1, snr1),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Poisson_MSE =immse(Convert_Poisson_Noise_Image, Convert_Poisson_Filtered_Image);
[peaksnr2, snr2] = psnr(Convert_Poisson_Noise_Image, Convert_Poisson_Filtered_Image);

TextonFIG = subplot(3,3,9);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f', Poisson_MSE, peaksnr2, snr2),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off

%MEDIAN FILTER CODE STARTS FROM HERE
RGB = imread('coins.png');
OrigImage = rgb2gray(RGB);
OrigImage=im2double(OrigImage);

SPNoise = input('Enter Salt & Pepper noise density (Median filter):  ');
SPNoisyImage = imnoise(OrigImage,'salt & pepper',SPNoise);
Convert_Sp_Noise_Image = im2uint8(SPNoisyImage);
Speckle_Noise = input('Enter Speckle noise variable (Median filter):  ');
Speckle_NoisyImage = imnoise(OrigImage,'speckle', Speckle_Noise);
Convert_Speckle_Noise_Image = im2uint8(Speckle_NoisyImage);
Poisson_NoisyImage = imnoise(OrigImage,'Poisson');
Convert_Poisson_Noise_Image = im2uint8(Poisson_NoisyImage);


SPfilteredImage=MedianFilter(SPNoisyImage);
Convert_Sp_filtered_Image = im2uint8(SPfilteredImage);
SpecklefilteredImage=MedianFilter(Speckle_NoisyImage);
Convert_Speckle_filtered_Image = im2uint8(SpecklefilteredImage);
PoissonfilteredImage=MedianFilter(Poisson_NoisyImage);
Convert_Poisson_filtered_Image = im2uint8(PoissonfilteredImage);

figure('units','normalized','outerposition',[0 0 1 1],'Name','Median Filter','NumberTitle','off')
subplot(3,3,1);
imshow(SPNoisyImage);
title('Image After adding Salt & Pepper noise');
subplot(3,3,2);
imshow(Speckle_NoisyImage);
title('Image After adding Speckle Noise');
subplot(3,3,3);
imshow(Poisson_NoisyImage);
title('Image After adding Poisson Noise');

subplot(3,3,4);
imshow(SPfilteredImage);
title('Image after applying Median filter for Salt & pepper noise Image');

subplot(3,3,5);
imshow(SpecklefilteredImage);
title('Image after applying Median filter for Speckle noisy Image');

subplot(3,3,6);
imshow(PoissonfilteredImage);
title('Image after applying Median filter for Poisson noisy Image');


SP_MSE =immse(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);
[peaksnr, snr] = psnr(Convert_Sp_Noise_Image, Convert_Sp_filtered_Image);

TextonFIG = subplot(3,3,7);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f.\n Signal to Noise ratio (SNR): %.2f', SP_MSE, peaksnr, snr),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Speckle_MSE =immse(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);
[peaksnr1, snr1] = psnr(Convert_Speckle_Noise_Image, Convert_Speckle_filtered_Image);


TextonFIG = subplot(3,3,8);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f\n Peak Signal to Noise Ratio(PSNR): %.2f\n Signal to Noise ratio (SNR): %.2f', Speckle_MSE, peaksnr1, snr1),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off
Poisson_MSE =immse(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);
[peaksnr2, snr2] = psnr(Convert_Poisson_Noise_Image, Convert_Poisson_filtered_Image);

TextonFIG = subplot(3,3,9);
text( 0,0, sprintf(' Mean Square Error(MSE): %.2f \n Peak Signal to Noise Ratio(PSNR): %.2f \n Signal to Noise ratio (SNR): %.2f', Poisson_MSE, peaksnr2, snr2),'Parent', TextonFIG,'fontsize',14 ,'color', 'R');
axis off


function Value=MedianFilter(OrigImage)
[a,b]=size(OrigImage);
for x=1:a
    for y=1:b
        First=x+1;
        second=x-1;
        third=y-1;
        fourth=y+1;
        if(second<1)
            second=x;
        elseif (First>a)
            First=x;
        end
        if(third<1)
            third=y;
        elseif (fourth>b)
            fourth=y;
        end
        Neighbours=[OrigImage(x,y) OrigImage(x,third) OrigImage(x,fourth) OrigImage(First,y) OrigImage(second,y) OrigImage(second,third) OrigImage(First,third) OrigImage(First,fourth) OrigImage(second,fourth)];
        FinalMedian=median(Neighbours);
        Value(x,y)=FinalMedian;
    end
end
end





