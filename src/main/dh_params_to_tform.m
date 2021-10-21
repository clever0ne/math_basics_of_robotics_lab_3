function tform = dh_params_to_tform(dh_params)
    a = reshape(dh_params(:, 1), 1, 1, []);
    alpha = reshape(dh_params(:, 2), 1, 1, []);
    d = reshape(dh_params(:, 3), 1, 1, []);
    theta = reshape(dh_params(:, 4), 1, 1, []);
    
    h1 = zeros(4, 4, size(dh_params, 1));
    h1(1, 1, :) =  cos(theta);
    h1(1, 2, :) = -sin(theta);
    h1(2, 2, :) =  cos(theta);
    h1(2, 1, :) =  sin(theta);
    h1(3, 3, :) =  1;
    h1(3, 4, :) =  d;
    h1(4, 4, :) =  1;
                
    h2 = zeros(4, 4, size(dh_params, 1));
    h2(2, 2, :) =  cos(alpha);
    h2(2, 3, :) = -sin(alpha);
    h2(3, 3, :) =  cos(alpha);
    h2(3, 2, :) =  sin(alpha);
    h2(1, 4, :) =  a;
    h2(1, 1, :) =  1;
    h2(4, 4, :) =  1;
      
    tform = zeros(4, 4, size(dh_params, 1));
    for idx = 1 : size(dh_params, 1)
        tform(:, :, idx) = h1(:, :, idx) * h2(:, :, idx);
    end
end

