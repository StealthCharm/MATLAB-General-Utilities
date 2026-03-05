%[text] Simple utility to check whether no elements are asserted instead of all.
function tf = none(A, dim)
    arguments
        A 
        dim (1, :) DimensionArgument = DimensionArgument(A, true);
    end

    tf = ~any(A, +dim);
end
%[text] Utility function to validate dimensional inputs
function mustBeValidDim(dim)
    arguments
        dim {mustBeNonempty, mustBeA(dim, ["numeric", "string"])};
    end

    % Check inputs base on type
    if(isnumeric(dim))
        if(anymissing(dim))
            mustBeScalar(dim);
        else
            mustBeInteger(dim);
            mustBeGreaterThanOrEqual(dim, 0);
        end
    else
        mustBeScalarOrEmpty(dim)
        mustBeMember(dim, "all")
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
