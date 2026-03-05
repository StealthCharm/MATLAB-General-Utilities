%[text] Determines if the input is an integer value. Unlike the provide in `isinteger()` which tests the underlying type.
function tf = isint(A)
    arguments
        A {mustBeMathematic};
    end

    % Check that the input is an integer value by comparing its floored value to its actual value
    tf = ~isnan(A) & ~isinf(A) & isreal(A) & logical(A == floor(A));
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
