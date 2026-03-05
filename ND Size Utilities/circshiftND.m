%[text] A broadcast capable version of circshift.
function A = circshiftND(A, k, dim)
    arguments
        A 
        k double {mustBeInteger} = 1;
        dim (1, 1) double {mustBeInteger, mustBePositive} = firstNonscalarDim(A);
    end

    % Default value for k = [] is an increasing negative offset 
    if(isempty(k))
        if(dim == 1)
            k = -(span(A, 2) - 1);
        else
            k = -(span(A, dim-1) - 1);
        end
    end

    % Vectorizing circular shifts along a given dimension is not define, 
    % nor intuitive, so we'll error assuming unintentional k span
    if(size(k, dim) ~= 1)
        throw(MException("JB:circshiftND:InvalidInput", "The shift count 'k' must be scalar in the dimension of shifting 'dim'."));
    end

    % Record input size and generate index map
    Asz = size(A);
    idx = matrix(Asz);
    
    % Modulo arithmetic to normalize k values
    k = mod(k, Asz(dim));
    
    % Generate the inputs stride vector and determine which elements are circularly wrapped
    stride = [1, cumprod(Asz)];
    is_wrapped = span(idx, dim) <= k;
    
    % Compute the index offsets to adjust the index map
    static_offset = stride(dim) .* (k - is_wrapped);
    circ_offset = is_wrapped .* (stride(dim + 1) - stride(dim));
    
    % Use indexing with the offsets applied to perform the broadcasted circshift
    A = A(idx + (circ_offset - static_offset));
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
