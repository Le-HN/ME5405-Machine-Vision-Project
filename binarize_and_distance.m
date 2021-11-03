function [counter] = binarize_and_distance(histogram_num, size, row)
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
    
    counter = 0;
    for i = 1:size
        if binary_img(row, i) == 1
            counter = counter + 1;
        else
            break;
        end
    end
end