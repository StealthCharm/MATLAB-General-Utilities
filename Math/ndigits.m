%[text] This function will return the number of digits in the whole number and decimal portion of the input.
function [n, d] = ndigits(A, base, options)
    arguments(Input)
        A double
        base (1, 1) double = 10;
        options.Max DimensionArgument = DimensionArgument().empty;
        options.Min DimensionArgument = DimensionArgument().empty;
    end
    arguments(Output)
        n
        d
    end

    % NV pair option validation
    if(matlab.lang.internal.countNamedArguments > 1)
        ME = MException("JB:ndigits:InvalidOptions", "The 'Max' and 'Min' options are mutually exclusive.");
        throw(ME);
    end
    
    % Take the magnitude for digit counting and find floored value
    A = abs(A);
    n = floor(A);

    % To avoid storing n we will just compute d first if both are desired
    if(nargout > 1)
        % Determine the number of digits for the decimal portion
        d = A - n;
        d = floor(abs(logn(d, base))) + 1;
    else
        d = [];
    end

    % Determine the number of digits for whole number portion
    n = floor(logn(n, base)) + 1;
    n(isinf(n)) = nan;
    d(isinf(d)) = nan;

    % Perform any required reductions
    if(~isempty(options.Max))
        options.Max = dims(options.Max, A);
        n = max(n, [], options.Max);
        d = max(d, [], options.Max);
    elseif(~isempty(options.Min))
        options.Min = dims(options.Min, A);
        n = min(n, [], options.Max);
        d = min(d, [], options.Max);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
