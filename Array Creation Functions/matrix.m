%[text] Initializes an array of the given size where each element has a value equivalent to its linear index.
function data = matrix(sz, opts)
    arguments(Repeating)
        sz (1, :) double {mustBeInteger(sz)};
    end
    arguments
        opts.Dim (1, 1) double {mustBeInteger} = 1;
        opts.Like;
        opts.Class (1, 1) string;
    end

    % Normalize the size input
    sz = [sz{:}];

    % Allow square or repeating dimensional patterns
    sz = repmat(sz, [1, opts.Dim]);

    % Mimic the scalar -> square size pattern from other initialization patterns
    if(isscalar(sz))
        sz = [sz, sz];
    end

    % Either creates the matrix or returns empty double
    if(isempty(sz))
        % No argument call will produce empty array
        data = [];
    else
        % Initializes an array where the value of each element is its linear index
        data = reshape(1:prod(sz), sz);
    end

    % Allow casting to classes
    if(isfield(opts, "Class"))
        data = cast(data, opts.Class);
    elseif(isfield(opts, "Like"))
        data = cast(data, Like=opts.Like);
    end
end

%[appendix]{"version":"1.0"}
%---
