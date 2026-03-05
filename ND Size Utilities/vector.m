%[text] A utility to reshape the input into a vector with a length along the specified dimension.
%[text] Note: When it is claimed the input will be a vector, this refers to an array with at most 1 non-singleton dimension. This varies from the definition in MATLAB's design; IE: `'isvector(vector(foo, 3)) == false'`.
function A = vector(A, dim)
    arguments
        A
        dim (1, 1) double {mustBeInteger, mustBePositive} = 1;
    end

    A = reshape(A, [], 1);

    if(dim ~= 1)
        A = permute(A, dim:-1:1);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
