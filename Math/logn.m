%[text] Take the log of a number to any base.
%[text] If Base is not supplied, then the natural log is presumed.
function z = logn(x, n)
    % Argument validation
    arguments
        x {mustBeMathematical};
        n {mustBeMathematical} = 10;
    end

    % Cast numerics to double class
    [x, n] = num2double(x, n);

    if(isscalar(n))
        % Check the broadcasted size and preallocate output
        sz = broadcast_size(x, n);

        % Find unique x values
        [x, ~, xn] = unique(x, "stable");

        % Compute and map the values to the output
        z = logb(x, n);
        z = reshape(z(xn), sz);

        % For scalars skip the unique mapping to save time
        % Assuming repeat log(x) computations are cheaper than sort() op
        % z = logb(x, n);
    else
        % Broadcast the inputs
        [idx, sz] = broadcast_map(x, n);

        % Find the unique elements to reduce computations
        [x, ~, xn] = unique(x, "stable");
        [n, ~, nn] = unique(n, "stable");

        % Reshape the unique index maps
        xn = reshape(xn(idx(1, :)), sz);
        nn = reshape(nn(idx(2, :)), sz);

        % Preallocate the output
        z = zeros(sz);

        % Convert to symbolics
        if(isSymbolic(x) || isSymbolic(n))
            z = sym(z);
        end

        % Perform the log calculation for each unique n value
        for i = 1:numel(n)
            % Find the elements that correspond to the current n value
            map = nn == i;

            % Perform the computation
            z(map) = logb(x(xn(map)), n(i));
        end
    end
end
%[text] Simple helper to divert to built-ins when available.
function z = logb(x, base)
    % Defaults to specific built-in functions where possible
    switch(base)
        case 2
            z = log2(x);
        case 10
            z = log10(x);
        case exp()
            z = log(x);
        otherwise
            z = log(x) ./ log(base);
    end
end

%[appendix]{"version":"1.0"}
%---
