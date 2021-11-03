function [small_gray_img, gray_img] = binary_image(histogram_num)
    % Binary image matrix
    binary_img = zeros(64);
    % Rows or columns will be divided into some sections
    row_col_sec = 4;
    % Then the whole image will be divided into several blocks
    block_size = 64 / row_col_sec;

    for block_row = 1:row_col_sec
        for block_col = 1:row_col_sec
            histogram = zeros([1 32]);
            % Calculate the pixels of different gray levels in 
            % different small blocks
            for i = block_size*(block_row-1)+1:block_size*block_row
                for j = block_size*(block_col-1)+1:block_size*block_col
                    for k = 1:32
                        if histogram_num(i, j) == k - 1
                            histogram(k) = histogram(k) + 1;
                        end
                    end
                end
            end
            % Find the highest increase among histogram in
            % period of 8 gray levels
            max_delta = 0;
            max_index = 0;
            for k = 8:32
                if histogram(k)-histogram(k-7) > max_delta
                    max_delta = histogram(k)-histogram(k-7);
                    max_index = k-7;
                end
            end
            % Define the threshold and processing the image
            threshold = max_index - 1;
            for i = block_size*(block_row-1)+1:block_size*block_row
                for j = block_size*(block_col-1)+1:block_size*block_col
                    if histogram_num(i, j) <=threshold
                        binary_img(i, j) = 0;
                    else
                        binary_img(i, j) = 1;
                    end
                end
            end

        end
    end

    small_gray_img = mat2gray(binary_img);
    gray_img = imresize(small_gray_img, 3);

end