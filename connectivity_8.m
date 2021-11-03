% Input: binary image
% Output: 8-connectivity labeled matrix and the connection set
function [matrix, set] = connectivity_8(binary)
    % Label matrix
    matrix = zeros(64);
    % Padding matrix in order to label
    pad_img = padarray(binary, [1 1], 1);
    % Object counter
    counter = 1;
    % Save the connected pairs
    connect_pairs = [0 0;];
    % Count the pair number
    pair_pointer = 1;
    for i = 2:65
        for j = 2:65
            % A neighbour list include West, North-west, North, North-east
            neighbour_list = [pad_img(i, j-1) pad_img(i-1, j-1) pad_img(i-1, j) pad_img(i-1, j+1)];
            % To see how many neighbours the current pixel has
            sum_neighbour = sum(neighbour_list);
            
            % Limit the boundary and save the labels of neighbours
            if (i > 2) && (j > 2)
                if j < 65
                    label_list = [matrix(i-1, j-2) matrix(i-2, j-2) matrix(i-2, j-1) matrix(i-2, j)];
                else
                    label_list = [matrix(i-1, j-2) matrix(i-2, j-2) matrix(i-2, j-1) 0];
                end
            end
            if (i <= 2) && (j > 2)
                label_list = [matrix(i-1, j-2) 0 0 0];
            end
            if (i > 2) && (j <= 2)
                label_list = [0 0 matrix(i-2, j-1) matrix(i-2, j)];
            end
            if (i <= 2) && (j <= 2)
                label_list = [0 0 0 0];
            end
            
            % Find the max label and min label
            % One pixel can only has two kinds of differently labeled neighbours
            max_label = max(label_list);
            min_label = max_label;
            for k = 1:4
            	if label_list(k) == 0
                    continue
                end
                if label_list(k) < min_label
                    min_label = label_list(k);
                end
            end
            % All directions have no neighbours
            if (sum_neighbour == 4) && (pad_img(i, j) == 0)
                matrix(i-1, j-1) = counter;
                counter = counter + 1;
                continue
            else
                % Label the current pixel
                if (min_label ~= 0) && (pad_img(i, j) == 0)
                    matrix(i-1, j-1) = min_label;
                end
                
                % Check if the pair has already existed in the pair list
                % If not, add the pair
                if ~ismember([min_label max_label], connect_pairs, 'rows')
                    connect_pairs(pair_pointer, 1) = min_label;
                    connect_pairs(pair_pointer, 2) = max_label;
                    pair_pointer = pair_pointer + 1;
                end
            end
        end
    end
    
    % Find the single-pixel object and add them to connected pairs
    for i = 2:64
        for j = 2:64
            if (pad_img(i-1, j) == 1) && (pad_img(i, j-1) == 1) && (pad_img(i+1, j) == 1) && (pad_img(i, j+1) == 1)...
                    &&(pad_img(i-1, j-1) == 1) && (pad_img(i-1, j+1) == 1) && (pad_img(i+1, j+1) == 1) && (pad_img(i+1, j-1) == 1)...
                    &&(pad_img(i, j) == 0)
                connect_pairs(end+1, 1) = matrix(i-1, j-1);
                connect_pairs(end, 2) = matrix(i-1, j-1);
            end
        end
    end
    % Eliminate repeated pairs and sort the pairs
    unique_pairs = unique(connect_pairs, 'rows', 'sorted');
    % Count the set number
    set_row_pointer = 1;
    % Record unique_pairs' dimention 
    dim = size(unique_pairs, 1);
    % Initialize the set
    set = [0;0];
    for i = 1:dim
        % Check if the first number of the pair is in the set
        % If it is not in the set, create a new subset
        if ~ismember(set, unique_pairs(i, 1))
            set(set_row_pointer, 1) = unique_pairs(i, 1);
            row = set_row_pointer;
%             col = 1;
            set_row_pointer = set_row_pointer + 1;
        %If it is in the set, record the row number it in
        else
            [row, col] = find(set == unique_pairs(i, 1));
%             row = link(1);
%             col = link(end + 1);
        end
        % Decide where the second number should be added 
        if ~ismember(set,unique_pairs(i, 2))
            for j = 1:size(set, 2)
                if set(row, j) == 0
                    set(row, j) = unique_pairs(i, 2);
                    break
                end
                if j == size(set, 2)
                    set(row, end + 1) = unique_pairs(i, 2);
                    break
                end
            end
        end
    end
    % Sort the set
    set = sort(set, 2);
    % Eliminate zero in the set
    for i = 1:size(set, 1)
        zero_counter = 0;
        if set(i, 1) ~= 0
            continue
        else
            for j = 1:size(set, 2)
                if set(i, j) == 0
                    zero_counter = zero_counter + 1;
                else
                    set(i, j-zero_counter) = set(i, j);
                    set(i, j) = 0;
                end
            end
        end
    end
end