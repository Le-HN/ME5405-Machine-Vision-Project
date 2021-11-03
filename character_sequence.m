function [one_line, one_line_enlarged] = character_sequence(binary, segment, original)
    % Create an empty grid
    [row, col] = size(binary);
    col_idx = 0;
    next_col_idx = 10;
    one_line = zeros(row/2, col*2 + 50);
    % AB123C order
    order = [4, 5, 1, 2, 3, 6];
    
    % Extract the objects/characters
    for i = 1 : 1 : 6
        idx = order(i);
        [row,col] = find(segment == idx);
        obj = binary(min(row):max(row),min(col):max(col));
        [row_obj,col_obj] = size(obj);
        % Character storage
%         characters = int16(original(min(row):max(row),min(col):max(col))) * 8;
        characters = int16(obj) * 255;
%         characters = original(min(row):max(row),min(col):max(col));
        pad_chr = padarray(characters, [round((26-row_obj)/2) round((26-col_obj)/2)], 0, 'pre');
        pad_chr = padarray(pad_chr, [26-size(pad_chr, 1) 26-size(pad_chr, 2)], 0, 'post');
        pad_chr = 255 - pad_chr;
%         pad_chr = 31 - pad_chr;
        filename = append('extracted_characters\', num2str(idx), '.mat');
        save(filename, 'pad_chr');        

        col_idx = col_idx + next_col_idx;
        next_col_idx = 10 + col_obj + 10;

        for r = 1 : 1 : row_obj
            for c = 1 : 1 : col_obj
                one_line(10+r,col_idx+c) = obj(r,c);
            end
        end
    end
    
    one_line_enlarged = imresize(one_line, 3); 
end