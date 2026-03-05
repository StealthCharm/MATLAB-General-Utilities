%[text] This function interleaves the inputs along the specified dimension.
function A = interleave(dim, A)
    arguments
        dim double {mustBeInteger, mustBeScalarOrEmpty, mustBeGreaterThan(dim, 0)} = [];
    end
    arguments(Repeating)
        A 
    end

    % Allows default skipping
    if(isempty(dim))
        dim = firstNonscalarDim(dim);
    end
    
    % Record the input count and generate the broadcast map
    An = numel(A);
    sz = broadcast.size(A{:});
    
    % Modify the output size and generate a permutation order for the output shape
    sz(dim) = sz(dim) .* An;
    dimOrder = [dim, setdiff(1:numel(sz), dim)];
    
    for n = 1:An
        A{n} = permute(A{n}, dimOrder);
    end
    
    % Flatten the input structure for normalized indexing syntax 
    [A, map] = broadcast.flatmap(A{:});
    
    % Generate output by indexing appropriate elements and normalize the output shape
    A = reshape([A{ipermuteND(map, dimOrder, sz)}], sz);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
