clear;
clc;
TrainDatabasePath = 'D:\assignment\模式识别\实验七\TrainDatabase';
TrainFiles = dir(fullfile(TrainDatabasePath, '*.bmp'));
for i = 1:length(TrainFiles)
    oldName = fullfile(TrainDatabasePath, TrainFiles(i).name);
    newName = fullfile(TrainDatabasePath, [num2str(i), '.bmp']);
    movefile(oldName, newName);
end