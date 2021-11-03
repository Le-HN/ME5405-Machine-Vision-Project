function [small_gray_img, counter] = binary_for_character_and_thinning(histogram_num, size)
    % Binary image matrix
    binary_img = zeros(size);
    
    % Binarization
    for i = 1:size
        for j = 1:size
            % Define the threshold and processing the image
            threshold = 254;
                    if histogram_num(i, j) <=threshold
                        binary_img(i, j) = 0;
                    else
                        binary_img(i, j) = 1;
                    end
        end
    end
    
    binary_img = 1 - binary_img;
    sk = bwmorph(binary_img,'skel',Inf);
    sk = 1 - sk;
    
    counter = 0;
    % Counter for black pixels (object)
    for i = 1:size
        for j = 1:size
            if sk(i, j) == 0
                counter = counter + 1;
            end
        end
    end

    small_gray_img = mat2gray(sk);

end