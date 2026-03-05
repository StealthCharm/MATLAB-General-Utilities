%[text] Simple wrapper function to inline the replacement of zero values with that of the modulo value.
function A = remn(A, m)
    arguments
        A {mustBeMathematic}
        m {mustBeMathematic}
    end
    
    % Perform remainder operation and replace the zero values with m
    s = sign(A);
    A = rem(A - s, m) + s;
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
