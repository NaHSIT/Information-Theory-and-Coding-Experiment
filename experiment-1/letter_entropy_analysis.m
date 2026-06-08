%% =========================================================
% 文件名称：letter_entropy_analysis.m
% 功能：
%   1. 读取文本文件 test.txt
%   2. 统计 A~Z 及空格出现次数
%   3. 计算字符出现频率
%   4. 计算信息熵
%
% 作者：lql
% 日期：2026.6.8
%% =========================================================

clc;
clear;
close all;

%% ==================== 文件读取 ====================
filename = 'test.txt';

if ~isfile(filename)
    error('文件 "%s" 不存在！', filename);
end

% 读取整个文件
textData = fileread(filename);

% 字符总数
totalChars = length(textData);

%% ==================== 初始化统计数组 ====================
% A~Z 共26个字母
% 第27个元素统计空格
count = zeros(1,27);

%% ==================== 字符统计 ====================
for k = 1:totalChars

    ch = textData(k);

    % 空格统计
    if ch == ' '
        count(27) = count(27) + 1;

    % 小写字母
    elseif ch >= 'a' && ch <= 'z'
        index = double(ch) - double('a') + 1;
        count(index) = count(index) + 1;

    % 大写字母
    elseif ch >= 'A' && ch <= 'Z'
        index = double(ch) - double('A') + 1;
        count(index) = count(index) + 1;
    end

end

%% ==================== 计算频率 ====================
frequency = count / totalChars;

%% ==================== 输出频率 ====================
fprintf('文档中各字符出现频率：\n\n');

for k = 1:26

    fprintf('%c : %.6f\t', char(k+64), frequency(k));

    if mod(k,3)==0
        fprintf('\n');
    end

end

fprintf('\n');
fprintf('Space : %.6f\n\n', frequency(27));

%% ==================== 计算信息熵 ====================
entropyValue = 0;

for k = 1:length(frequency)

    if frequency(k) > 0

        % Shannon信息熵
        entropyValue = entropyValue ...
            - frequency(k) * log2(frequency(k));

    end

end

%% ==================== 输出结果 ====================
fprintf('----------------------------------\n');
fprintf('信息熵 H = %.6f bit/char\n', entropyValue);
fprintf('----------------------------------\n');

%% ==================== 绘制频率分布图 ====================
figure;
bar(frequency);

xticks(1:27);
labels = [arrayfun(@(x) char(x), 'A':'Z', 'UniformOutput', false), 'Space'];

xticks(1:27);
xticklabels(labels);

xlabel('字符');
ylabel('出现频率');
title('字符频率统计');

grid on;
