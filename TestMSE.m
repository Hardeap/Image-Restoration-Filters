OrigImage = imread('test.tif');
convert = im2uint8(OrigImage);
MSE = immse(convert, convert);
[peaksnr snr] = psnr (convert, convert);
fprintf('Mean Square Error = %.2f \n' , MSE);
fprintf('Mean Square Error = %.2f \n' , peaksnr);
fprintf('Mean Square Error = %.2f \n' , snr);
