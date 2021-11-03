function [counter] = magnitude_feature(train_img)
    
    im = 1 - train_img;
    [im_height,im_width] = size(im);
    % compute the Fourier spectrum using fft2
    F = fft2(double(im), im_height, im_width);
    % applying fftshift of Matlab to F
    F_shift = fftshift(F);
    % return to spatial domain after filtering
    magnitude = abs(F_shift);
    
%     figure(10);
%     imshow(magnitude);
    
    counter = round(magnitude(20, 20)*100);

end