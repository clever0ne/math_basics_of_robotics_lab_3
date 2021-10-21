% Лабораторная работа №3
clc; close all; clear;

%% Задание 1. Преобразование параметров Денавита — Хартенберга в матрицу однородных преобразований

dh_params = load_data('../../test_dh_params.txt');
tform = dh_params_to_tform(dh_params);

id = fopen('../../output.txt', 'wt');
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

dt = 0.001;
n = 100;
q0 = q(:, 1);
qend = q(:, end);
dq = (qend - q0) / n;

for idx = 1 : n + 1
    qi = q0 + dq * (idx - 1);
    points = show_robot(dh_params, qi);
    pause(dt);
end
