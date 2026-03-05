%[text] Allows a cyclical span to be produced for the output.
function s = cspan(A, k, dim, options)
    arguments
        A
        k (1, 1) double {mustBeInteger, mustBePositive} = 2;
        dim (1, 1) double {mustBeInteger, mustBePositive} = firstNonscalarDim(A);
        options.Size (1, 1) logical = false;
        options.Logical (1, 1) logical = false;
    end
    
    % Gather regular span
    s = span(A, dim, Size=options.Size);

    if(options.Logical)
        % Cheaper alternative if you want true at k
        s = ~mod(s, k);
    else
        % Perform circular modulo for working rulers
        s = modn(s, k);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
