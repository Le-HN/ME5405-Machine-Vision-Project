function [angle_distribution_most] = max_gradient_direction(histogram_num)

    % Padding the image in order to implement gradient calculation
    pad_img = padarray(histogram_num, [1 1], 255);
    % Matrixes to save gradients and angles
    gradient = zeros(28);
    angle = zeros(28);
    % 6 degree as a period
    angle_distribution = zeros(1, 36);
    angle_distribution_most = 0;
    % The 3*3 computation kernel
    % p9   p2   p3
    % p8   p1   p4
    % p7   p6   p5
    for i = 2:27
        for j = 2:27
            x = zeros(1,180);
            x(1) = pad_img(i, j);
            x(2) = pad_img(i-1, j);
            x(3) = pad_img(i-1, j+1);
            x(4) = pad_img(i, j+1);
            x(5) = pad_img(i+1, j+1);
            x(6) = pad_img(i+1, j);
            x(7) = pad_img(i+1, j-1);
            x(8) = pad_img(i, j-1);
            x(9) = pad_img(i-1, j-1);
            Gx = (x(7)+2*x(6)+x(5)) - (x(9)+2*x(2)+x(3));
            Gy = (x(3)+2*x(4)+x(5)) - (x(9)+2*x(8)+x(7));
            G = abs(Gx) + abs(Gy);
            A = atan(Gy/Gx);
            
            % angle & angle+180 can be seen as the same direction
            if A < 0
                A = A + pi;
            end
            gradient(i, j) = G;
            angle(i, j) = rad2deg(A);
            index = ceil(angle(i, j) / 5);
            
            if isnan(angle(i, j))
                continue;
            end
            if index == 0
                index = 1;
            end
            angle_distribution(index) = angle_distribution(index) + 1;
        end
    end
    
    angle_distribution_most_coor = find(angle_distribution == max(angle_distribution));
    angle_distribution_most = angle_distribution_most_coor(1);
end
       