%[text] This function replaces strncmp by performing broadcasted comparisons. In addition the N value can be left unspecified, if it is the function will return the max N value that would result in a true for calls of `strncmp(A, B, N)`.
function n = strncmpi(A, B, N)
    arguments
        A string
        B string = [];
        N double {mustBeInteger, mustBeNonnegative} = [];
    end
        
    % For single argument syntax we perform implicit self comparison
    if(nargin == 1)
        B = vector(A, mdims(A));
    end

    % Gather the input sizes
    args = {A, B, N};
    [sz, sizes] = broadcast.size(args{1:nargin}, StrictCompatiblity=false);

    % Conform empties to just use algorithm
    switch(xorn(isempty(A), isempty(B)))
        case 1
            A = string.empty([sizes(2, :), 0]);
        case 2
            B = string.empty([sizes(1, :), 0]);
    end

    % Create missing map to nullify false positives
    A_missing = ismissing(A);
    B_missing = ismissing(B);
    missing_idx = A_missing | B_missing;

    % Replace missing elements to enable character comparisons
    A(A_missing) = "";
    B(B_missing) = "";

    % Determine the lengths of the strings pre char padding
    A_length = fillempty(strlength(A), 0);
    B_length = fillempty(strlength(B), 0);
    cmp_length = max(A_length, B_length);
    max_length = max(cmp_length, [], "all");

    % Compare the inputs and take the cummin to determine the last equal character
    n = cummin(char(pad(lower(A), max_length)) == char(pad(lower(B), max_length)), 2);

    % Generate size vector for true/false padding and use diff to find indices of downshifts
    Nsz = size(n, [1, 5, 3, 4]); 
    n = diff([true(Nsz), n, false((Nsz))], 1, 2);

    % Find the column index of each true value since diff made it such that -1 indicated col + 1
    n = modn(find(mpermute(n, 2)), max_length+1) - 1;

    % Find the last true value along the second dimension to gather the max n for strncmp
    n = reshape(n, sz);

    % Make sure to clip max n to max strlength of either input so added padding does not skew results
    n = min(n, min(A_length, B_length));

    % If N is provide confirm that at least the first N characters match
    if(~isempty(N))
        % Ensure that length constraint is clipped to the
        % strlength so that strings shorter than N match
        n = min(N, cmp_length) <= n & ~missing_idx;
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
