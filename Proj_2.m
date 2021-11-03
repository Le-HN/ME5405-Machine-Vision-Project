clc;

% Problem 1:
% Show the original image (enlarged)
filepath = 'charact1.txt';
[histogram_num, original, enlarged] = original_image(filepath);
figure(1);
imshow(enlarged);

% Problem 2:
% Show the binary image (enlarged)
[binary, enlarged_binary] = binary_image(histogram_num);
figure(2);
imshow(enlarged_binary);

% Problem 3:
% Determine one-pixel image
binary_reverse = 1 - binary;
[one_pixel, one_pixel_enlarged] = one_pixel_image(binary_reverse);
figure(3);
imshow(one_pixel_enlarged);

% Problem 4:
% Determine the outline of objects
[outline, outline_enlarged] = outline_image(binary_reverse);
figure(4)
imshow(outline_enlarged)

% Pre-process
% To link similar points
% [processed_num, processed, processed_enlarged] = local_processing(outline);
% figure(5);
% imshow(processed_enlarged);

% Problem 5:
% Label different objects
% 8 connectivity
[labeled_matrix_8, connectivity_set_8] = connectivity_8(binary_reverse);
% Colour different parts
[coloured, segment] = segmentation(labeled_matrix_8, connectivity_set_8);
figure(5);
image(coloured);

figure(6);
% Find the properties of the labeled image
image(coloured);
stats = regionprops(segment, 'BoundingBox');

% Plot the bounding box
for i = 1 : 1 : size(stats,1)
    rect = rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
    pos = rect.Position;
    title_name = ['', num2str(i)];
    
    % Label the bounding boxes
    text(pos(1)+pos(3)/2, pos(2)+pos(4)/2, title_name, 'HorizontalAlignment', 'center', 'Color', 'green', 'FontSize', 14);
end

% Problem 6:
% Arrange the characters in sequence: AB123C
% Addtional function: save the image of each characters
[sequence, sequence_enlarged] = character_sequence(binary, segment, histogram_num);
figure(7);
imshow(sequence_enlarged);

% Problem 7:
% Rotate the image in Problem 6 30 degree in counter-clockwise direction
angle = 30;
[rotated, rotated_enlarged] = rotation(sequence, angle);
figure(8);
imshow(rotated_enlarged);

% Problem 8:
% Using kNN to identify the character
TRAIN = 1;
if TRAIN == 1
    [accuracy, success] = knn_train();    
end
accuracy
