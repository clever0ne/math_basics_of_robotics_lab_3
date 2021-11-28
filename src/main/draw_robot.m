function draw_robot(frames)
    num_of_frames = size(frames, 3);
    p = zeros(3, num_of_frames);
    for idx = 1 : num_of_frames
        p(:, idx) = frames(1 : 3, 4, idx) * 10;
    end
    plot3(p(1, :), p(2, :), p(3, :), 'k');
    hold on;
end
