%[text] Alias log() which is the natural log in MATLAB to allow easier use for those use to `ln()` syntax.
function x = ln(x)
    arguments(Input)
        x {mustBeMathematical};
    end

    x = log(x);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
