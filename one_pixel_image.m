% Z-S Algorithm which works on a two-step iteration method which is combined with directional approach.
% General Algorithm: This will result in obtaining the skeleton from the original image. The selected pixel is eliminated if the
% following steps are executed:

% Step 1:
% (a) 2<B(p1)<6
% (b) A(p1)=1
% (c) p2*p4*p6=0
% (d) p4*p6*p8=0

% Step 2:
% (a) 2<B(p1)<6
% (b) A(p1)=1
% (c) p2*p4*p8=0
% (d) p2*p6*p8=0

% The 3*3 computation kernel
% p9   p2   p3
% p8   p1   p4
% p7   p6   p5

function [no_pad, no_pad_enlarged] = one_pixel_image(binary)
    binary = 1 - binary;
    % Padding the image in order to implement Zhang-Suen algorithm
    pad_img = padarray(binary, [1 1], 0);
    % Matrix to save the image as the original size
    no_pad = zeros(64);
    
    done = 0;
    while done ~= 1
        
        pre_img = pad_img;
        % Step 1
        for i = 2:64
            for j = 2:64
                x = zeros(1,10);
                x(1) = pad_img(i, j);
                x(2) = pad_img(i-1, j);
                x(3) = pad_img(i-1, j+1);
                x(4) = pad_img(i, j+1);
                x(5) = pad_img(i+1, j+1);
                x(6) = pad_img(i+1, j);
                x(7) = pad_img(i+1, j-1);
                x(8) = pad_img(i, j-1);
                x(9) = pad_img(i-1, j-1);
                x(10) = x(2);
                circle_rise = 0;
                circle_count = 0;
                for k = 3:10
                    if x(k) > x(k-1)
                        circle_rise = circle_rise + 1;
                    end
                    if x(k) == 1
                        circle_count = circle_count + 1;
                    end
                end
                if (x(1) == 1)&&...
                       (circle_rise == 1)&&...
                       (2 < circle_count)&&(circle_count < 6)&&...
                       (x(2) * x(4) * x(6) == 0)&&...
                       (x(4) * x(6) * x(8) == 0)
                   pad_img(i, j) = 0;
                end
            end
        end
        
        % When the previous processed image is equal to the current image,
        % terminate the procedure
        done = isequal(pre_img, pad_img);
        if done
            break
        end
        
        pre_img = pad_img;
        % Step 2        
        for i = 2:64
            for j = 2:64
                x = zeros(1,10);
                x(1) = pad_img(i, j);
                x(2) = pad_img(i-1, j);
                x(3) = pad_img(i-1, j+1);
                x(4) = pad_img(i, j+1);
                x(5) = pad_img(i+1, j+1);
                x(6) = pad_img(i+1, j);
                x(7) = pad_img(i+1, j-1);
                x(8) = pad_img(i, j-1);
                x(9) = pad_img(i-1, j-1);
                x(10) = x(2);
                circle_rise = 0;
                circle_count = 0;
                for k = 3:10
                    if x(k) > x(k-1)
                        circle_rise = circle_rise + 1;
                    end
                    if x(k) == 1
                        circle_count = circle_count + 1;
                    end
                end
                if (x(1) == 1)&&...
                       (circle_rise == 1)&&...
                       (2 < circle_count)&&(circle_count < 6)&&...
                       (x(2) * x(4) * x(8) == 0)&&...
                       (x(2) * x(6) * x(8) == 0)
                   pad_img(i, j) = 0;
                end
            end
        end
        
        % When the previous processed image is equal to the current image,
        % terminate the procedure
        done = isequal(pre_img, pad_img);
    end

    pad_img = 1 - pad_img;
    for i = 2:65
        for j = 2:65
            no_pad(i-1, j-1) = pad_img(i,j);
        end
    end

    no_pad_enlarged = imresize(no_pad, 3);

end