%[text] This function produces a random logical mask for the given input.
function mask = randm(A, options)
    arguments (Input)
        A
        options.Percent (1, 1) double = 0.50;
    end

    mask = randl(size(A), Percent=options.Percent);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
