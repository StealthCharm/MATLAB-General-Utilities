%[text] This function validates that the input is semantically a mathematical object, that is that it is numeric, logical, or symbolic.
function mustBeMathematic(obj)
    arguments(Input)
        obj
    end

    if(~isMathematic(obj))
        throwAsCaller(MException("JB:Validators:mustBeMathematic", "The input must be a numerical object, or a symbolic object."));
    end
end


%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
