function points = show_robot(dh_params, q)
    e = 1.125;
    g = q(end);
    
    num_of_frames = size(dh_params, 1);
    dh_params(:, 4) = dh_params(:, 4) + q(1 : num_of_frames);
    
    tform = dh_params_to_tform(dh_params);
    base_frame = eye(4);
    
    frame = zeros(4, 4, 1 + num_of_frames);
    h = eye(4);
    frame(:, :, 1) = base_frame;
    for idx = 1 : num_of_frames
        h = h * tform(:, :, idx);
        frame(:, :, idx + 1) = h * base_frame;
    end
    
    robot_points = zeros(3, num_of_frames);
    for idx = 1 : num_of_frames
        robot_points(:, idx) = frame(1 : 3, 4, idx);
    end
    
    gripper_points = [ 0,  g/2, -g/2,  g/2, -g/2;
                       0,    0,    0,    0,    0;
                      -e,   -e,   -e,    0,    0;
                       1,    1,    1,    1,    1 ];
    temp = frame(:, :, end) * gripper_points;
    gripper_points = temp(1 : 3, :);
    
    draw_robot(robot_points);
    draw_gripper(robot_points(:, end), gripper_points);
    
    colour = ['r', 'g', 'b'];
    axe = ['x', 'y', 'z'];
    for idx1 = 1 : num_of_frames + 1
        tf = frame(:, :, idx1);
        r = tf(1 : 3, 1 : 3);
        p = tf(1 : 3, 4);
        xyz = p + r * eye(3);
        
        for idx2 = 1 : 3
            plot3([p(1), xyz(1, idx2)], ...
                  [p(2), xyz(2, idx2)], ...
                  [p(3), xyz(3, idx2)], colour(idx2));
            axis_text = ['$', axe(idx2), '_{', num2str(idx1 - 1), '}$']; 
            text(xyz(1, idx2), ...
                 xyz(2, idx2), ...
                 xyz(3, idx2), axis_text, 'Interpreter', 'latex', 'FontSize', 8);
            hold on;
        end
        
        pos = ['$(', num2str(p(1), '%.3f'), ', ', ...
                     num2str(p(2), '%.3f'), ', ', ...
                     num2str(p(3), '%.3f'), ')$'];
        text(p(1), p(2), p(3), pos, 'Interpreter', 'latex', 'FontSize', 8);
    end
    
    grid on;
    axis equal;
    axis([-15, 15, -15, 15, -5, 15]);
    xlabel('$x, \rm m$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$y, \rm m$', 'Interpreter', 'latex', 'FontSize', 12);
    zlabel('$z, \rm m$', 'Interpreter', 'latex', 'FontSize', 12);
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    
    hold off;
    
    points = [robot_points, gripper_points]';
end

