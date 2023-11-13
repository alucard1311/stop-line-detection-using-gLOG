function H = compute_homography(src, dst)
    N = size(src, 1);
    A = zeros(2 * N, 9);

    for i = 1:N
        x = src(i, 1);
        y = src(i, 2);
        u = dst(i, 1);
        v = dst(i, 2);

        A(2 * i, :) = [-x, -y, -1, 0, 0, 0, x * u, y * u, u];
        A(2 * i + 1, :) = [0, 0, 0, -x, -y, -1, x * v, y * v, v];
    end

    [~, ~, V] = svd(A);
    H = reshape(V(:, end), [3, 3]);
end

% TO DO: Implement the apply_homography function
function dst = apply_homography(src, H)
    N = size(src, 1);
    src_homogeneous = [src, ones(N, 1)]; % Add 1 to make points homogeneous
    dst_homogeneous = src_homogeneous * H';
    dst = dst_homogeneous(:, 1:2) ./ dst_homogeneous(:, 3);
end


