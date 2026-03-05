%[text] Permutes the input such that the columns are the length of the combined dimensions and all higher dimensions are collapsed.
%[text] This is functionally a cheaper version of `permuteND()` without the size book-keeping for sequential inverse permutations. Because there is far less input  validation, and robust normalization attempts, it would be ideal to use `mpermute()` over `permuteND()` when possible.
function [A, dimOrder, ndim] = mpermute(A, dim)
    arguments
        A
        dim (1, :) double {mustBeInteger, mustBePositive};
    end

    [dimOrder, ndim] = permuteDims(A, dim);
    A = reshape(permute(A, dimOrder), prod(size(A, dim)), []);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
