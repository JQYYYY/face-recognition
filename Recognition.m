function OutputName = Recognition(TestImage, TrainFiles)
%% ʶ�����......
%
% ����������Ƚ�����ͼ��Ͷ�䵽�����ռ��������õ���ŷ�Ͼ��롣
%
% ����:      TestImage                  - ����ͼ���·��
%
%                m                      - ѵ�������ݿ�ľ�ֵ,�����ɡ�EigenfaceCore����������ġ�
%
%                Eigenfaces             - ѵ�����ݿ�Э���������������������ɡ�EigenfaceCore������������ġ�
%
%                A                      - ���Ļ�ͼ����������,�����ɡ�EigenfaceCore����������ġ�
% 
% ���:       OutputName                - ��ѵ�������ݿ�����ʶ��ͼ������֡�
%
% ���ú���: RESHAPE, STRCAT

    %% �����������е�����
    load('eig_vectors.mat', 'A', 'm', 'Eigenfaces');
    
    ProjectedImages = [];
    Train_Number = size(Eigenfaces, 2);
    for i = 1 : Train_Number
        ProjectedImages = [ProjectedImages, Eigenfaces' * A(:, i)];     %ѵ��������������ͶӰ 
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
%     %% ��ȡ����ͼƬ�����ɷַ���
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
%     % ����ÿ����ͼ��ŷ�Ͼ��벢���
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
