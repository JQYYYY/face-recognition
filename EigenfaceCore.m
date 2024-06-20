function EigenfaceCore(T)
% 运用主成分分析法
%
% 参数:      TestImage                  - 输入图像的路径
%
%                m                      - 训练集数据库的均值,它是由“EigenfaceCore”函数输出的。
%
%                Eigenfaces             - 训练数据库协方差矩阵的特征向量，是由“EigenfaceCore”函数的输出的。
%
%                A                      - 中心化图像矩阵的向量,它是由“EigenfaceCore”函数输出的。
% 
% 
% 结果:       OutputName                - 在训练集数据库中所识别图象的名字。
%
% 调用函数:   EIG
    m = mean(T, 2);
    A = double(T) - m;
    L = A' * A;     % L是协方差矩阵
    [V, D] = eig(L);
    L_eig_vec = [];
    
    sum = 0;
    for i = 1:size(V, 2)
        sum = sum + D(i, i);
    end
    sub = 0;
    rate = 0;
    while(rate < 0.99)
        sub = sub + D(i, i);
        rate = sub / sum;
        L_eig_vec = [L_eig_vec, V(:, i)];
        i = i - 1;  % 对角阵特征值是从小到大
    end
    Eigenfaces = A * L_eig_vec;
    save('eig_vectors.mat', 'A', 'm', 'Eigenfaces');
end
%     N = prod([50, 50]);
%     M = 96;                 % 图片数
%     num_components = 83;    % 选择的主要特征向量数量
%     L_eig_vec = zeros(N, num_components, 4);
%     ProjectedImages = zeros(M, num_components, 4); % 每个子图的投影
%     for k = 1:4
%         % 中心化数据
%         mean_face = mean(T(:, :, k), 1); % 计算每个像素的均值
%         T_centered = T(:, :, k) - mean_face; % 中心化数据
% 
%         % 计算协方差矩阵并进行特征值分解
%         C = cov(T_centered);
%         [eig_vec, eig_val] = eig(C);
%         % 按特征值降序排序特征向量
%         [~, idx] = sort(diag(eig_val), 'descend');
%         eig_vec = eig_vec(:, idx);
%         % 选择主要特征向量
%         L_eig_vec(:, :, k) = eig_vec(:, 1:num_components);
%         % 将训练图像投影到特征脸空间
%         ProjectedImages(:, :, k) = T_centered * L_eig_vec(:, :, k);
%     end
%     save('eig_vectors.mat', 'L_eig_vec', 'mean_face', 'ProjectedImages');
% end