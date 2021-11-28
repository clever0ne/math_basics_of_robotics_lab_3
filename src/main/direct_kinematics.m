function points = direct_kinematics(q, dh_params)
    e = 1.125;
    g = q(end);
    
    num_of_frames = size(dh_params, 1);
    dh_params(:, 4) = dh_params(:, 4) + q(1 : num_of_frames);
    
    tform = dh_params_to_tform(dh_params);
    base_frame = eye(4);
    
    frames = zeros(4, 4, 1 + num_of_frames);
    h = eye(4);
    frames(:, :, 1) = base_frame;
    for idx = 1 : num_of_frames
        h = h * tform(:, :, idx);
        frames(:, :, idx + 1) = h * base_frame;
    end
    
    robot_points = zeros(3, num_of_frames);
    for idx = 1 : num_of_frames
        robot_points(:, idx) = frames(1 : 3, 4, idx);
    end
    
    gripper_points = [ 0,  g/2, -g/2,  g/2, -g/2;
                       0,    0,    0,    0,    0;
                      -e,   -e,   -e,    0,    0;
                       1,    1,    1,    1,    1 ];
    temp = frames(:, :, end) * gripper_points;
    gripper_points = temp(1 : 3, :);
    
    figure();
    draw_robot(frames);
    draw_axis(frames);
    draw_gripper(robot_points(:, end), gripper_points);
    
    points = [robot_points, gripper_points]';
end

