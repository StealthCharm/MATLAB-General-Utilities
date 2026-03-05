%[text] This script produces full N-D grids for each dimension of an array where the output for the nth dimension is flattened and represented by the nth column.
function grid = ndgrids(N)
    arguments(Repeating)
        N (1, :) {mustBeNumeric, mustBeGreaterThanOrEqual(N, 0)};
    end

    % Input validation
    if(isscalar(N))
        % Take input in format of single vector
        N = row(N{1});
    elseif(all(cellfun("length", N) == 1, "all"))
        % Take input in form of separate scalars
        N = [N{:}];
    else
        % Throw error for invalid inputs
        throw(MException("JB:ndgrids:InvalidInput", "Input must be a single double array or scalar repeating doubles."));
    end

    % Preallocate the output
    grid = zeros([prod(N), numel(N)]);

    % Create the expansion multiplier to produce properly broadcasted dimensions
    if(isscalar(N))
        expansion_factor = 1;
    else
        expansion_factor = zeros(N) + 1;
    end

    % Create column vector for each dimension
    for n = 1:width(grid)
        grid(:, n) = column(vector(1:N(n), n) .* expansion_factor);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"referenceBackgroundColor":"#121212","title":{"color":"#0072bd","fontSize":"18"}}
%---
