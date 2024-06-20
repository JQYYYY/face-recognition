% ����PCA������ʶ��
% ���ú�����: CREATEDATABASE, EIGENFACECORE, RECOGNITION        

clear;
clc;
close all;

% TrainDatabasePath = uigetdir('D:\assignment\ģʽʶ��\ʵ����\TrainDatabase', 'Select training database path');     % ����ѡ���ļ��д���
% TestDatabasePath = uigetdir('D:\assignment\ģʽʶ��\ʵ����\TestDatabase', 'Select test database path');
TrainDatabasePath = 'D:\assignment\ģʽʶ��\ʵ����\TrainDatabase';     % ����ѡ���ļ��д���
TestDatabasePath = 'D:\assignment\ģʽʶ��\ʵ����\TestDatabase';


%% ѡ���ļ����е�ͼƬ������ȡ
prompt = {'Enter test image name (a number between 1 to 24):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines = 1;
def = {'1'};
TestImage = inputdlg(prompt, dlg_title, num_lines, def);
TestImage = strcat(TestDatabasePath, '\', char(TestImage), '.bmp');
im = imread(TestImage);

%% �������ݿ�
[T, TrainFiles] = CreateDatabase(TrainDatabasePath);
% EigenfaceCore(T);
OutputName = Recognition(TestImage, TrainFiles);
SelectedImage = strcat(TrainDatabasePath, '\', OutputName);
SelectedImage = imread(SelectedImage);

%% ��ʾʶ����
imshow(im)
title('Test Image');
figure,imshow(SelectedImage);
title('Equivalent Image');
str = strcat('Matched image is :  ', OutputName);
disp(str)