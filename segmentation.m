function [coloured, segment] = segmentation(labeled_matrix, connectivity_set)
    coloured = zeros(64);
    segment = zeros(64);
    % Traverse the labeled image
    for i = 1:64
        for j = 1:64
            if labeled_matrix(i, j) ~= 0
                % Find the label value among the label set
                for k = 1:size(connectivity_set, 1)
                    if ismember(labeled_matrix(i, j), connectivity_set(k,:))
                        % Increase the gap between labeled object values
                        segment(i, j) = k;
                        coloured(i, j) = k * 45;
                        break;
                    end
                end
            end
        end
    end
end