function [T, TrainFiles] = CreateDatabase(TrainDatabasePath)
    TrainFiles = dir(fullfile(TrainDatabasePath, '*.bmp'));
    Train_Number = length(TrainFiles);  % ����ͼ���ļ�����
    
    % 2άͼ�������1ά������
    T = [];
    for i = 1:Train_Number
        str = fullfile(TrainDatabasePath, TrainFiles(i).name);
        img = imread(str);
        [row, col] = size(img);
        T = [T, reshape(img, row * col, 1)];
    end
% function [T, TrainFiles] = CreateDatabase(TrainDatabasePath)
% % �������ͼ��
%     % ͳ��ͼ������
%     subImagesSize = [50, 50];
%     TrainFiles = dir(fullfile(TrainDatabasePath, '*.bmp'));
%     Train_Number = length(TrainFiles);  % ����ͼ���ļ�����
% 
%     % 2άͼ�������1ά������
%     T = zeros(Train_Number, 2500, 4);
%     for i = 1 : Train_Number
%         str = fullfile(TrainDatabasePath, TrainFiles(i).name);
%         img = imread(str);
%         % ����Ϊ�ĸ���ͼ
%         subImages = mat2cell(img, subImagesSize(1) * ones(2, 1), subImagesSize(2) * ones(2, 1));
%         for j = 1:4
%             T(i, :, j) = subImages{j}(:)';  % չƽ��һά����
%         end
%     end
% end