%[text] Finds the true values of an array put returns the indices according to the subscript for the specified dimension.
function idx = pfind(A, dim)
    arguments
        A logical
        dim (1, :) double {mustBeInteger, mustBePositive, mustBeUnique} = ndims(A);
    end

    idx = row(find(permute(A, union(dim, 1:max(ndims(A), dim), "stable"))));
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
