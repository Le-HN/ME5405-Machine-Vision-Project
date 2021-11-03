function [small_gray_img, counter] = binary_for_character_and_zoning(histogram_num, size)
    % Binary image matrix
    binary_img = zeros(size);
    
    % Counter for black pixels (object)
    counter = 0;
    for i = 1:size
        for j = 1:size
            % Define the threshold and processing the image
            threshold = 254;
                    distance = round(size / 2);
                    if histogram_num(i+distance, j) <=threshold
                        binary_img(i, j) = 0;
                        counter = counter + 1;
                    else
                        binary_img(i, j) = 1;
                    end
        end
    end

    small_gray_img = mat2gray(binary_img);

end