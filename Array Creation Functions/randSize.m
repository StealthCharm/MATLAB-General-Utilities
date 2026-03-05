%[text] This function generates random size vectors to allow for initialization of dynamic test inputs.
%[text] The dimN is specified as either the largest random dimension count (assuming 1 as the minimum bound), a range to randomly select the dimension count from, or a vector of valid random dimension counts to select from.
function sz = randSize(dimN, maxLength)
    arguments
        dimN (:, :) double {mustBeInteger, mustBeMatrix} = 2;
        maxLength double {mustBeInteger, mustBeGreaterThanOrEqual(maxLength, 0)} = [3, 10];
    end

    % Determine the relative and absolute dimension count of each row
    max_ndim = diff(ndim, 1, 2);
    fmax_ndim = dimN(:, 1);

    isrow(maxLength) && max(max_ndim, fmax_ndim)


    % dim_size = size(dimN);
    % length_size = size(maxLength);



    % Normalize the inputs for processing
    [dimN, maxLength] = normalize_args(dimN, maxLength);

    Dsz = size(dimN);
    Lsz = size(maxLength);

    mdim = max(dimN(:, 2));
    lwidth = Lsz(2);

    if(lwidth == 2 && Dsz(1) == Lsz(1))
        L = randi_vec(dimN);
    else
        for n = 1:numel(Lsz(1))
            maxLength(n, :) = randi_vec(maxLength(n, :));
        end
    end
    all(mdim >= lwidth, "all")

    r = randi_vec(dimN);

    



    % Record the dim count prior to invalid input elimination
    dimCount = numel(dimN);

    % Remove invalid dimension 
    % This allows for intent differentiation 
    % IE [1, 10] vs [1, 10, -1] 
    dimN(dimN < 0) = [];

    switch(dimCount)
        case 1
            % Generates a random size vector with the specified dimension count
            sz = randi(maxLength, [1, dimN]);
        case 2
            % Generates a random size vector inbetween the specified dimension bounds
            sz = randi(maxLength, [1, randi(maxLength, 1)]);
        case 3
            % Generates a random size vector with one of the specified specified dimension count
            sz = randi(maxLength, [1, dimN(rand([1, numel(dimN)]))]);
    end
end

function [dimN, maxLength] = normalize_args(dimN, maxLength)
    % Allow scalar inputs to represent max dimension count
    if(width(dimN) == 1)
        dimN = [1, dimN];
    else
        % Reshape all other inputs to form row-wise map
        dimN = transpose(reshape(dimN, 2, []));
    end

    % Record the input sizes
    Dsz = size(dimN);
    Dn = numel(dimN);
    Lsz = size(maxLength);

    % Allows scalar length to specify maximum length of all dimensions
    if(isscalar(maxLength))
        maxLength = [1, maxLength];
    end

    % Pad the size of the 
    if(Lsz(1) ~= Dsz(1))
        % Determine the expansion size of maxLength
        rep_size = Dsz(1) ./ Lsz(1);

        % Ensure expansion incompatibility error message is provided.
        if(~isint(rep_size))
            exception("JB:randSize:InvalidInput", "The maximum length needs to be capable of expansion to accommodate the dimN argument.");
        end

        % Pad the height to generate a value
        maxLength = repmat(maxLength, rep_size);
    end
end
%[text] This function generates random integers within the input range. The input range is a (n, 2) matrix where each n corresponds to a separate request range.
function r = randi_vec(dimN)
    % Check if the input is formatted as a vector 
    vec_fmt = isrow(dimN);
    % mat_fmt = width(dimN) == 2;

    % Allow row vectors to signify element wise upper bounds
    if(vec_fmt)
        n = numel(dimN);
        dimN = [ones([n, 1]), column(dimN)];
    end

    % Generate random values for each of the ranges provided
    r = rand([height(dimN), 1]);

    % Scaled each random value to the respective range
    r = rescale(r, dimN(:, 1), dimN(:, 2), InputMin=0, InputMax=1);
    r = round(r);

    % Conform the output to match input size
    if(vec_fmt)
        r = row(r);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
