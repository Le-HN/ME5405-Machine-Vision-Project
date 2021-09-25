clc;

% Problem 1:
% Show the original image (enlarged)
[histogram_num, original, enlarged] = original_image();
figure(1);
imshow(enlarged);

% Problem 2:
% Show the binary image (enlarged)
[binary, enlarged_binary] = binary_image(histogram_num);
figure(2);
imshow(enlarged_binary);

% Problem 3:
% Determine one-pixel image
[one_pixel, one_pixel_enlarged] = one_pixel_image(binary);
figure(3);
imshow(one_pixel_enlarged);

% Problem 4:
% Determine the outline of objects
[outline, outline_enlarged] = outline_image(binary);
figure(4)
imshow(outline_enlarged)

% Problem 5.1:
% Label different objects
% 4 connectivity
[labeled_matrix_4, connectivity_set_4] = connectivity_4(binary);
% Print matrix and set
labeled_matrix_4
connectivity_set_4

% Problem 5.2:
% Label different objects
% 8 connectivity
[labeled_matrix_8, connectivity_set_8] = connectivity_8(binary);
labeled_matrix_8
connectivity_set_8

