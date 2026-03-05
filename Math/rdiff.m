%[text] This function performs the same operation as diff but in sequential order. 
%[text] Note that when referring to index n, n is dimensionally static. So you could consider a vector input, or just understand that the operation is done dimensionally.
%[text] The `diff()` function results in an output `B` where `B(n) = A(n+1) - A(n)`. This function does the reverse: returning `B(n) = A(n) - A(n + 1)`. No I certainly didn't fail to recognize this was the default behavior of the `diff()` function for an embarrassingly long time... But if I had, in my defense it would have been because I usually only use to to do conditional switch detection on logical masks...
function A = rdiff(A, n, dim)
    arguments(Input)
        A {mustBeMathematical};
        n (1, 1) double {mustBeIntegerOrInf} = 1;
        dim (1, 1) double = firstNonscalarDim(A);
    end
    
    % Allow semantic value to signify as many diffs as the dimension supports
    if(isinf(n))
        n = prod(size(A, dim)) - 1;
    end

    % Perform the reverse diff
    A = flip(diff(flip(A, dim), n, dim), dim);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
