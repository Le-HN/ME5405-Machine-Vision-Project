function [rotated, rotated_enlarged] = rotation(sequence, angle)
    a = deg2rad(angle);
    rot_matrix = [cos(a), -sin(a); sin(a), cos(a)];
    
    % Rotate the image
    [row, col] = size(sequence);
    % Create an empty grid
    rotated = zeros(row*3, col);
    [row, col] = find(sequence == 1);
    
    row_size = size(row, 1);

    for i = 1 : 1 : row_size
        coordinate = rot_matrix * [row(i); col(i)];

        % Due to the estimate, there is reduced resolution
        new_row = round(coordinate(1)) + 100; % Position Transformation by 100 so that the rotated image would not be out of the grid
        new_col = round(coordinate(2));
        
        % Assign a pixel 
        rotated(new_row, new_col) = 1;    
    end
    
    rotated_enlarged = imresize(rotated, 3); 
end