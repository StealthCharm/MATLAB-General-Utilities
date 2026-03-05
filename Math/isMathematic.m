%[text] This function returns a logical value representing whether the input is a mathematical compatible object, that is that it is numeric, logical, or symbolic.
function tf = isMathematic(obj)
    arguments(Input)
        obj
    end

    tf = isnumeric(obj) || islogical(obj) || isa(obj, "sym") || isa(obj, "symfun") || isa(obj, "symmatrix") || isa(obj, "symfunmatrix");
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
