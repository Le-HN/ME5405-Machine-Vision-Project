function [histogram_num, small_gray_img, gray_img] = original_image()
    filepath = 'ME5405-Machine-Vision-Project\chromo.txt';
    fileID = fopen(filepath,'r');
    Image = fscanf(fileID,'%s',[64 1]);
    % Matrix transpose
    Image = Image';

    for x = 1:64
        for y = 1:64
            % Convert the letters and numbers to the gray level using
            % ascii code
            if (double(Image(x, y))>=65) && (double(Image(x, y))<=90)
                number2image(x, y) = int8(Image(x, y)) - 55;
            else
                number2image(x, y) = int8(Image(x, y)) - 48;
            end
        end
    end
    
    histogram_num = number2image;
    small_gray_img = mat2gray(number2image);
    gray_img = imresize(small_gray_img, 3);
end