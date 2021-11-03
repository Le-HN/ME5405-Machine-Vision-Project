% Input: binary image
% Output: 4-connectivity labeled matrix and the connection set
function [matrix, set] = connectivity_4(binary)
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
            % Both west and north have no neighbours
            if (pad_img(i-1, j) == 1) && (pad_img(i, j-1) == 1) && (pad_img(i, j) == 0)
                matrix(i-1, j-1) = counter;
                counter = counter + 1;
            else
                % Both west and north have neighbours
                % Choose a smaller index and save connected pairs
                if (pad_img(i-1, j) == 0) && (pad_img(i, j-1) == 0) && (pad_img(i, j) == 0)
                    matrix(i-1, j-1) = min([matrix(i-2, j-1) matrix(i-1, j-2)]);
                    if (pair_pointer > 1)&&(connect_pairs(pair_pointer-1, 1) == matrix(i-2, j-1))&&(connect_pairs(pair_pointer-1, 2) == matrix(i-1, j-2))
                        continue;
                    end
                    connect_pairs(pair_pointer, 1) = min([matrix(i-2, j-1) matrix(i-1, j-2)]);
                    connect_pairs(pair_pointer, 2) = max([matrix(i-2, j-1) matrix(i-1, j-2)]);
%                     connect_pairs(pair_pointer, 1) = matrix(i-2, j-1);
%                     connect_pairs(pair_pointer, 2) = matrix(i-1, j-2);
                    pair_pointer = pair_pointer + 1;
                else
                    % North has a neighbour
                    % Save connected pairs
                    if (pad_img(i-1, j) == 0) && (pad_img(i, j) == 0)
                        matrix(i-1, j-1) = matrix(i-2, j-1);
                        if (pair_pointer > 1)&&(connect_pairs(pair_pointer-1, 1) == matrix(i-2, j-1))
                            continue;
                        end
                        connect_pairs(pair_pointer, 1) = matrix(i-2, j-1);
                        connect_pairs(pair_pointer, 2) = matrix(i-2, j-1);
                        pair_pointer = pair_pointer + 1;
                    end
                    
                    % West has a neighbour
                    % Save connected pairs
                    if (pad_img(i, j-1) == 0) && (pad_img(i, j) == 0)
                        matrix(i-1, j-1) = matrix(i-1, j-2);
                        if (pair_pointer > 1)&&(connect_pairs(pair_pointer-1, 1) == matrix(i-1, j-2))
                            continue;
                        end
                        connect_pairs(pair_pointer, 1) = matrix(i-1, j-2);
                        connect_pairs(pair_pointer, 2) = matrix(i-1, j-2);
                        pair_pointer = pair_pointer + 1;
                    end
                end
            end
        end
    end
    
    % Find the single-pixel object and add them into connected pairs
    for i = 2:65
        for j = 2:65
            if (pad_img(i-1, j) == 1) && (pad_img(i, j-1) == 1) && (pad_img(i+1, j) == 1) && (pad_img(i, j+1) == 1) && (pad_img(i, j) == 0)
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
    