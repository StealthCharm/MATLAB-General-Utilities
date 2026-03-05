%[text] This function performs binning of numeric values using cyclic edge values.
function A = floorn(A, m)
    arguments(Input)
        A {mustBeMathematic};
        m {mustBeMathematic};
    end
    arguments(Output)
        A
    end

    A = floor((A - 1) ./ m) + 1;
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
