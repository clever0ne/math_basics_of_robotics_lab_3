% Лабораторная работа №3
clc; close all; clear;

%% Задание 1. Преобразование параметров Денавита — Хартенберга в матрицу однородных преобразований

dh_params = load_data('../../test_dh_params.txt');
tform = dh_params_to_tform(dh_params);

id = fopen('../../transform.txt', 'wt');
fprintf(id, 'tform = [');
fprintf(id, '%8.4f', tform(1, :));
fprintf(id, '\n         ');
fprintf(id, '%8.4f', tform(2, :));
fprintf(id, '\n         ');
fprintf(id, '%8.4f', tform(3, :));
fprintf(id, '\n         ');
fprintf(id, '%8.4f', tform(4, :));
fprintf(id, ' ]\n\n');
fclose(id);

%% Задание 2. Прямая задача кинематики для пятизвенного манипулятора
dh_params = load_data('../../dh_params.txt');
q = load_data('../../joint_coordinates.txt')';

points_1 = direct_kinematics(q(:, 1), dh_params);
points_2 = direct_kinematics(q(:, end), dh_params);
