function OutputName = Recognition(TestImage, TrainFiles)
%% 识别过程......
%
% 这个函数将比较两个图像投射到特征空间所测量得到的欧氏距离。
%
% 参数:      TestImage                  - 输入图像的路径
%
%                m                      - 训练集数据库的均值,它是由“EigenfaceCore”函数输出的。
%
%                Eigenfaces             - 训练数据库协方差矩阵的特征向量，是由“EigenfaceCore”函数的输出的。
%
%                A                      - 中心化图像矩阵的向量,它是由“EigenfaceCore”函数输出的。
% 
% 结果:       OutputName                - 在训练集数据库中所识别图象的名字。
%
% 调用函数: RESHAPE, STRCAT

    %% 导入人脸库中的数据
    load('eig_vectors.mat', 'A', 'm', 'Eigenfaces');
    
    ProjectedImages = [];
    Train_Number = size(Eigenfaces, 2);
    for i = 1 : Train_Number
        ProjectedImages = [ProjectedImages, Eigenfaces' * A(:, i)];     %训练集向特征向量投影 
    end
    InputImage = imread(TestImage);
    [row, col] = size(InputImage);
    InImage = reshape(InputImage, row * col, 1);
    ProjectedTestImage = Eigenfaces' * (double(InImage) - m);
    
    Euc_dist = [];
    for i = 1 : Train_Number
        q = ProjectedImages(:, i);
        Euc_dist = [Euc_dist, (norm( ProjectedTestImage - q ))^2];
    end
    [~, Recognized_index] = min(Euc_dist);
    OutputName = TrainFiles(Recognized_index).name;
end
%     %% 提取测试图片的主成分分析
%     img = imread(TestImage);
%     subImages = mat2cell(img, [50 50], [50 50]);
%     num_components = 83;
%     InImage = zeros(num_components, 4);
%     
%     for k = 1:4
%         subImage = double(subImages{k}(:))' - mean_face(:, k)';
%         InImage(:, k) = subImage * L_eig_vec(:, :, k);
%     end
% 
%     % 计算每个子图的欧氏距离并求和
%     Euc_dist = zeros(1, size(ProjectedImages, 1));
%     for i = 1:size(ProjectedImages, 1)
%         dist = 0;
%         for k = 1:4
%             q = ProjectedImages(i, :, k);
%             dist = dist + norm(InImage(:, k)' - q)^2;
%         end
%         Euc_dist(i) = dist;
%     end
% 
%     [~, Recognized_index] = min(Euc_dist);
%     OutputName = TrainFiles(Recognized_index).name;
% end
