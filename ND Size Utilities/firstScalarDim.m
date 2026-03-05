%[text] This function returns the first singleton, or length 1, dimension of the input.
function dims = firstScalarDim(A)
    arguments(Repeating)
        A 
    end

    % Preallocate the output
    dims = zeros(size(A));

    % Iterate through inputs gather dimension the vector like tensor spans
    for n = 1:numel(dims)
        dims(n) = find(size(A{n}, 1:(ndims(A{n})) + 1) == 1, 1);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
