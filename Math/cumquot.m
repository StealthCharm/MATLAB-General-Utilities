%[text] This function is the compliment to `cumprod()`. Instead of computing the product along the specified dimensions it calculates the quotient.
function A = cumquot(A, dim, options)
    arguments(Input)
        A
        dim (1, 1) double {mustBeInteger, mustBePositive} = firstNonscalarDim(A);
    end
    arguments(Input, Repeating)
        options (1, 1) string {mustBeMember(options, ["forward", "reverse", "includemissing", "omitmissing"])};
    end

    % Record the input size and reshape to align the specified dimensions in each column
    [A, dimOrder, Asz] = permuteND(A, dim);

    % Invert all folded elements
    A(2:end, :) = A(2:end, :).^-1;

    % Take the product of first element and inverse of all further to compute the quotient 
    A = cumprod(A, 1, options{:});

    % Conform the output shape accordingly
    A = ipermuteND(A, dimOrder, Asz);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
