function [outline_img, outline_enlarged] = outline_image(binary)
    outline_img = zeros(64);
    % Row
    for i = 1:64
        for j = 2:63
            if binary(i, j) > binary(i, j+1)
                outline_img(i, j) = 1;
            end
            if binary(i, j) > binary(i, j-1)
                outline_img(i, j-1) = 1;
            end
        end
    end
    % Column
    for i = 2:63
        for j = 1:64
            if binary(i, j) > binary(i+1, j)
                outline_img(i, j) = 1;
            end
            if binary(i, j) > binary(i-1, j)
                outline_img(i-1, j) = 1;
            end
        end
    end
    
    outline_enlarged = imresize(outline_img, 3);
end