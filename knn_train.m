function [accuracy, success] = knn_train()
    filepath = 'p_dataset_26/Sample';
    % 6 classes of images
    size = [26 26];
    % Whole image feature
    class_1 = zeros(762, prod(size));
    class_2 = zeros(762, prod(size));
    class_3 = zeros(762, prod(size));
    class_A = zeros(762, prod(size));
    class_B = zeros(762, prod(size));
    class_C = zeros(762, prod(size));
    % Work type
    TEST_SET = 1;
    
    % Extracted feature
%     class_1 = [0 0;];
%     class_2 = [0 0;];
%     class_3 = [0 0;];
%     class_A = [0 0;];
%     class_B = [0 0;];
%     class_C = [0 0;];
    
    % Training
    for i = 1:6
        % Get 75% images in the dataset to train
        for j = 1:762
            % Load images
            name = num2str(j);
            for k = 1:5-length(name)
                name = ['0' name];
            end
            if i <= 3
                temp = load([filepath num2str(i) '/img00' num2str(i+1) '-' name '.mat']);
            else
                temp = load([filepath char(i+61) '/img0' num2str(i+7) '-' name '.mat']);
            end
%             train_img = temp.imageArray;
            % Squeeze the image to 1D
            train_img = temp.imageArray(:)';
            
            % Store the image in different classes
            if i == 1
                class_1(j,:) = train_img;
            end
            if i == 2
                class_2(j,:) = train_img;
            end
            if i == 3
                class_3(j,:) = train_img;
            end
            if i == 4
                class_A(j,:) = train_img;
            end
            if i == 5
                class_B(j,:) = train_img;
            end
            if i == 6
                class_C(j,:) = train_img;
            end
            
            % Skeletonized feature
%             [sk_img, obj_num] = binary_for_character_and_thinning(train_img, 26);
%             if i == 1
%                 class_1(j, 2) = obj_num;
%             end
%             if i == 2
%                 class_2(j, 2) = obj_num;
%             end
%             if i == 3
%                 class_3(j, 2) = obj_num;
%             end
%             if i == 4
%                 class_A(j, 2) = obj_num;
%             end
%             if i == 5
%                 class_B(j, 2) = obj_num;
%             end
%             if i == 6
%                 class_C(j, 2) = obj_num;
%             end
            
            % Zoning feature
%             [zoning_img, obj_num] = binary_for_character_and_zoning(train_img, 13);
%             if i == 1
%                 class_1(j, 2) = obj_num;
%             end
%             if i == 2
%                 class_2(j, 2) = obj_num;
%             end
%             if i == 3
%                 class_3(j, 2) = obj_num;
%             end
%             if i == 4
%                 class_A(j, 2) = obj_num;
%             end
%             if i == 5
%                 class_B(j, 2) = obj_num;
%             end
%             if i == 6
%                 class_C(j, 2) = obj_num;
%             end
            
            % Distance feature
%             [obj_num] = binarize_and_distance(train_img, 26, 13);
%             if i == 1
%                 class_1(j, 2) = obj_num;
%             end
%             if i == 2
%                 class_2(j, 2) = obj_num;
%             end
%             if i == 3
%                 class_3(j, 2) = obj_num;
%             end
%             if i == 4
%                 class_A(j, 2) = obj_num;
%             end
%             if i == 5
%                 class_B(j, 2) = obj_num;
%             end
%             if i == 6
%                 class_C(j, 2) = obj_num;
%             end
            
            % Magnitude spectrum in frequecy domain
%             [obj_num] = magnitude_feature(train_img);
%             if i == 1
%                 class_1(j, 2) = obj_num;
%             end
%             if i == 2
%                 class_2(j, 2) = obj_num;
%             end
%             if i == 3
%                 class_3(j, 2) = obj_num;
%             end
%             if i == 4
%                 class_A(j, 2) = obj_num;
%             end
%             if i == 5
%                 class_B(j, 2) = obj_num;
%             end
%             if i == 6
%                 class_C(j, 2) = obj_num;
%             end
            
            % Gradient direction feature
%             [angle_distribution_most] = max_gradient_direction(train_img);
%             if i == 1
%                 class_1(j, 1) = angle_distribution_most;
%             end
%             if i == 2
%                 class_2(j, 1) = angle_distribution_most;
%             end
%             if i == 3
%                 class_3(j, 1) = angle_distribution_most;
%             end
%             if i == 4
%                 class_A(j, 1) = angle_distribution_most;
%             end
%             if i == 5
%                 class_B(j, 1) = angle_distribution_most;
%             end
%             if i == 6
%                 class_C(j, 1) = angle_distribution_most;
%             end
            
        end
    end
    
    % Testing
    % Merge 6 classes
    all_class = [class_1; class_2; class_3; class_A; class_B; class_C];
    k_value = 5;
    success = 0;
    
    % Test set v1
%     if TEST_SET == 1
%         for i = 1:6
%             % Get 25% images in the dataset to test
%             for j = 763:1016
%                 % Load images
%                 name = num2str(j);
%                 for k = 1:5-length(name)
%                     name = ['0' name];
%                 end
%                 if i <= 3
%                     temp = load([filepath num2str(i) '/img00' num2str(i+1) '-' name '.mat']);
%                 else
%                     temp = load([filepath char(i+61) '/img0' num2str(i+7) '-' name '.mat']);
%                 end
%     %             test_img = temp.imageArray;
%                 test_img = temp.imageArray(:)';
% 
%                 % Whole image feature
%                 D = zeros(762*6, 26*26);
%                 for k = 1:762*6
%                     D(k,:) = pdist2(all_class(k,1:26*26), test_img, 'euclidean');
%                 end
%                 d = sum(D, 2);
% 
%                 % Determine the distance between 2 images and save the index
%                 [d, idx] = sort(d, 1, 'ascend');
%                 idx = idx(1:k_value);
%                 idx = ceil(idx / 762);
% 
%                 % Determine the class based on the training set
%                 k_n_n = zeros(1, 6);
%                 for k = 1:k_value
%                     if idx(k) == 0
%                         idx(k) = 1;
%                     end
%                     k_n_n(idx(k)) = k_n_n(idx(k)) + 1; 
%                 end
%                 max_class = find(k_n_n == max(k_n_n));
%                 
%                 % Check if the test result is the same with the class
%                 if max_class == i
%                     success = success + 1;
%                 end
%             end
%         end
                % Zoning feature
    %             [zoning_img, obj_num] = binary_for_character_and_zoning(test_img, 13);
                % Distance feature
    %             [obj_num] = binarize_and_distance(train_img, 26, 13);
                % Skeletonized feature
    %            [sk_img, obj_num] = binary_for_character_and_thinning(train_img, 26);
                % Magnitude spectrum in frequecy domain
    %             [obj_num] = magnitude_feature(train_img);
                % Gradient direction feature
    %             [angle_distribution_most] = max_gradient_direction(test_img);
    % 
    %             test_feature = [0 0];
    %             test_feature(1) = angle_distribution_most;
    %             test_feature(2) = obj_num;
    %             
    %             count = 0;
    %             range = 0;
    %             k_n_n = zeros(1, 6);
    %             
    %             while count < k_value
    %                 range = range + 1;
    %                 temp = [];
    %                 i_count = 1;
    %                 for row = test_feature(1)-range:test_feature(1)+range
    %                     for col = test_feature(2)-range:test_feature(2)+range
    %                         for c = 1:762*4
    %                             if all_class(c, 1) == row && all_class(c, 2) == col
    %                                 temp(i_count) = ceil(c / 762);
    %                                 i_count = i_count + 1;
    %                             end
    %                         end
    %                        
    %                         for k = 1:length(temp)
    %                             k_n_n(temp(k)) = k_n_n(temp(k)) + 1;
    %                             count = count + 1;
    %                             if count == k_value
    %                                 break
    %                             end
    %                         end
    %                         if count == k_value
    %                             break
    %                         end
    %                     end
    %                     if count == k_value
    %                         break
    %                     end
    %                     
    %                 end
    %             end
    %             max_class = find(k_n_n == max(k_n_n));
    %             if max_class == i
    %                 success = success + 1;
    %             end

    % Test set v2
    test_class = zeros((1016-762)*6, 26*26);
    if TEST_SET == 1
        for i = 1:6
            % Get 25% images in the dataset to test
            for j = 763:1016
                % Load images
                name = num2str(j);
                for k = 1:5-length(name)
                    name = ['0' name];
                end
                if i <= 3
                    temp = load([filepath num2str(i) '/img00' num2str(i+1) '-' name '.mat']);
                else
                    temp = load([filepath char(i+61) '/img0' num2str(i+7) '-' name '.mat']);
                end
                test_img = temp.imageArray(:)';
                test_class((i-1)*(1016-762) + j - 762,:) = test_img;
            end
        end

        % Whole image feature
        for i = 1:(1016-762)*6
            d = zeros(762*6, 1);
            for k = 1:762*6
                d(k) = norm(test_class(i,:) - all_class(k,1:26*26));
            end

            % Determine the distance between 2 images and save the index
            [d, idx] = sort(d, 'ascend');
            idx = idx(1:k_value);
            idx = ceil(idx / 762);

            % Determine the class based on the training set
            k_n_n = zeros(1, 6);
            for k = 1:k_value
                if idx(k) == 0
                    idx(k) = 1;
                end
                k_n_n(idx(k)) = k_n_n(idx(k)) + 1; 
            end
            max_class = find(k_n_n == max(k_n_n));

            % Check if the test result is the same with the class
            if max_class == ceil(i / (1016-762))
                success = success + 1;
            end
        end
        
        % Measure the accuracy
        accuracy = success / ((1016 - 762)*6);
    end
    
    
    % Test the effect on the given characters
    if TEST_SET ~= 1
        test_filepath = 'extracted_characters/';
        success = 0;
        for i = 1:6
            temp = load([test_filepath num2str(i) '.mat']);

            test_img = temp.pad_chr(:)';

            % Whole image feature
            d = zeros(762*6, 1);
            for k = 1:762*6
                d(k) = norm(double(test_img) - all_class(k,:));
            end

            [d, idx] = sort(d, 'ascend');
            idx = idx(1:k_value);
            idx = ceil(idx / 762);

            k_n_n = zeros(1, 6);
            for k = 1:k_value
                k_n_n(idx(k)) = k_n_n(idx(k)) + 1; 
            end
            max_class = find(k_n_n == max(k_n_n));
            if max_class == i
                success = success + 1;
            end
        end
    success
    accuracy = success / 6;
    end
end