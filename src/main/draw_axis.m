function draw_axis(frames)
    num_of_frames = size(frames, 3);
    colour = ['r', 'g', 'b'];
    axe = ['x', 'y', 'z'];
    for idx1 = 1 : num_of_frames
        tf = frames(:, :, idx1) * 10;
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
        
        % pos = ['$(', num2str(p(1), '%.3f'), ', ', ...
        %              num2str(p(2), '%.3f'), ', ', ...
        %              num2str(p(3), '%.3f'), ')$'];
        % text(p(1), p(2), p(3), pos, 'Interpreter', 'latex', 'FontSize', 8);
    end
    
    grid on;
    axis equal;
    axis([-150, 150, -150, 150, -50, 250]);
    xlabel('$x, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$y, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    zlabel('$z, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    
    hold off;
end

