function EigenfaceCore(T)
% �������ɷַ�����
%
% ����:      TestImage                  - ����ͼ���·��
%
%                m                      - ѵ�������ݿ�ľ�ֵ,�����ɡ�EigenfaceCore����������ġ�
%
%                Eigenfaces             - ѵ�����ݿ�Э���������������������ɡ�EigenfaceCore������������ġ�
%
%                A                      - ���Ļ�ͼ����������,�����ɡ�EigenfaceCore����������ġ�
% 
% 
% ���:       OutputName                - ��ѵ�������ݿ�����ʶ��ͼ������֡�
%
% ���ú���:   EIG
    m = mean(T, 2);
    A = double(T) - m;
    L = A' * A;     % L��Э�������
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
        i = i - 1;  % �Խ�������ֵ�Ǵ�С����
    end
    Eigenfaces = A * L_eig_vec;
    save('eig_vectors.mat', 'A', 'm', 'Eigenfaces');
end
%     N = prod([50, 50]);
%     M = 96;                 % ͼƬ��
%     num_components = 83;    % ѡ�����Ҫ������������
%     L_eig_vec = zeros(N, num_components, 4);
%     ProjectedImages = zeros(M, num_components, 4); % ÿ����ͼ��ͶӰ
%     for k = 1:4
%         % ���Ļ�����
%         mean_face = mean(T(:, :, k), 1); % ����ÿ�����صľ�ֵ
%         T_centered = T(:, :, k) - mean_face; % ���Ļ�����
% 
%         % ����Э������󲢽�������ֵ�ֽ�
%         C = cov(T_centered);
%         [eig_vec, eig_val] = eig(C);
%         % ������ֵ����������������
%         [~, idx] = sort(diag(eig_val), 'descend');
%         eig_vec = eig_vec(:, idx);
%         % ѡ����Ҫ��������
%         L_eig_vec(:, :, k) = eig_vec(:, 1:num_components);
%         % ��ѵ��ͼ��ͶӰ���������ռ�
%         ProjectedImages(:, :, k) = T_centered * L_eig_vec(:, :, k);
%     end
%     save('eig_vectors.mat', 'L_eig_vec', 'mean_face', 'ProjectedImages');
% end