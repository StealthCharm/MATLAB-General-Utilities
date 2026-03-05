%[text] This function permutes the input accordingly and then row-izes the results. This is useful when expanding inputs along a dimension such that a vectorized condition can be selected from the expanded elements, and then the selected element is desired, but in the order of the original input ordering.
function [A, dimOrder, ndim] = rpermute(A, dim)
    arguments
        A
        dim (1, :) double {mustBeInteger, mustBePositive};
    end
    
    [dimOrder, ndim] = permuteDims(A, dim);
    A = row(permute(A, dimOrder));
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
