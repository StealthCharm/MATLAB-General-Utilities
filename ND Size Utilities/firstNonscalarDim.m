%[text] This function returns the first nonscalar dimension of the input. Returns 0 if no dimension has a length greater than one, that is that for scalar and empty inputs the output is zero.
function dim = firstNonscalarDim(A)
    arguments
        A 
    end

    dim = find(size(A) > 1, 1);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
