function [T, TrainFiles] = CreateDatabase(TrainDatabasePath)
    TrainFiles = dir(fullfile(TrainDatabasePath, '*.bmp'));
    Train_Number = length(TrainFiles);  % 计算图像文件数量
    
    % 2维图像矩阵变成1维列向量
    T = [];
    for i = 1:Train_Number
        str = fullfile(TrainDatabasePath, TrainFiles(i).name);
        img = imread(str);
        [row, col] = size(img);
        T = [T, reshape(img, row * col, 1)];
    end
% function [T, TrainFiles] = CreateDatabase(TrainDatabasePath)
% % 对齐的脸图像
%     % 统计图像数量
%     subImagesSize = [50, 50];
%     TrainFiles = dir(fullfile(TrainDatabasePath, '*.bmp'));
%     Train_Number = length(TrainFiles);  % 计算图像文件数量
% 
%     % 2维图像矩阵变成1维列向量
%     T = zeros(Train_Number, 2500, 4);
%     for i = 1 : Train_Number
%         str = fullfile(TrainDatabasePath, TrainFiles(i).name);
%         img = imread(str);
%         % 划分为四个子图
%         subImages = mat2cell(img, subImagesSize(1) * ones(2, 1), subImagesSize(2) * ones(2, 1));
%         for j = 1:4
%             T(i, :, j) = subImages{j}(:)';  % 展平成一维向量
%         end
%     end
% end