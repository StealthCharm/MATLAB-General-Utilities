%[text] This function is the compliment to `prod()`. Instead of computing the product along the specified dimensions it calculates the quotient.
function A = quot(A, dim, options)
    arguments(Input)
        A double
        dim (1, :) DimensionArgument = DimensionArgument(A, true);
    end
    arguments(Input, Repeating)
        options (1, 1) string {mustBeMember(options, ["default", "double", "native", "includemissing", "omitmissing"])};
    end

    % Unwrap the dimension
    dim = dim.dims(A);

    % Make the permutation
    [A, dimOrder, Asz] = permuteND(A, dim, Dim=1);

    % Invert all folded elements 
    A(2:end, :) = A(2:end, :).^-1;

    % Take the product of first element and inverse of all further to compute the quotient 
    A = prod(A, 1, options{:});

    % Conform the output shape accordingly
    A = ipermuteND(A, dimOrder, Asz);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
