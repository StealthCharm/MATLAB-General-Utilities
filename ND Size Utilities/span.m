%[text] This function returns the dimension with the longest length. If more than one dimension have the greatest length of any dimension it returns the first. If the dimension input is specified the function returns a vector aligned along the dimensions of length size(A, dim) comprised of incrementing integers.
function [vec, length] = span(A, dim, options)
    arguments
        A 
        dim (1, 1) double {mustBeInteger, mustBeNonnegative} = mdims(A);
        options.Size (1, 1) logical = false
    end

    if(nargin < 2)
        % Returns the dimension with the longest length or the 'span' of the input
        [length, vec] = max(size(A), [], "all");
    else
        % Normalize the input so that it always uses the size
        if(~options.Size)
            A = size(A, 1:max(dim, ndims(A)));
        end

        % Normalize the call signature so that multi-output, is safe
        length = A(dim);

        % Initialize the vector span
        vec = vector(1:length(1), dim(1));
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
