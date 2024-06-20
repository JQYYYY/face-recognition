% 基于PCA的人脸识别
% 调用函数库: CREATEDATABASE, EIGENFACECORE, RECOGNITION        

clear;
clc;
close all;

% TrainDatabasePath = uigetdir('D:\assignment\模式识别\实验七\TrainDatabase', 'Select training database path');     % 弹出选择文件夹窗口
% TestDatabasePath = uigetdir('D:\assignment\模式识别\实验七\TestDatabase', 'Select test database path');
TrainDatabasePath = 'D:\assignment\模式识别\实验七\TrainDatabase';     % 弹出选择文件夹窗口
TestDatabasePath = 'D:\assignment\模式识别\实验七\TestDatabase';


%% 选择文件夹中的图片，并读取
prompt = {'Enter test image name (a number between 1 to 24):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines = 1;
def = {'1'};
TestImage = inputdlg(prompt, dlg_title, num_lines, def);
TestImage = strcat(TestDatabasePath, '\', char(TestImage), '.bmp');
im = imread(TestImage);

%% 创建数据库
[T, TrainFiles] = CreateDatabase(TrainDatabasePath);
% EigenfaceCore(T);
OutputName = Recognition(TestImage, TrainFiles);
SelectedImage = strcat(TrainDatabasePath, '\', OutputName);
SelectedImage = imread(SelectedImage);

%% 显示识别结果
imshow(im)
title('Test Image');
figure,imshow(SelectedImage);
title('Equivalent Image');
str = strcat('Matched image is :  ', OutputName);
disp(str)