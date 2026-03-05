%[text] Instead of returning logicals return integers to enumerate the states.
function n = xorn(A, B, options)
    arguments
        A logical
        B logical
        options.Like = [];
    end

    % Instead of returning logicals return integers to
    % enumerate the states.
    %     0: ~A  & ~B
    %     1:  A  & ~B
    %     2: ~A  &  B
    %     3:  A  &  B
    % n = (int8(1) .* int8(A)) + (int8(2) .* int8(B));
    
    

    if(~matlab.lang.internal.countNamedArguments || isa(options.Like, "double"))
        % If no option is used or the type is still double we use cast-less call
        n = A + (2 .* B);
    else
        % Otherwise we will cast all arguments since even logicals can't broadcast with integers
        classname = class(options.Like);
        n = (cast(1, classname) .* cast(A, classname)) + (cast(2, classname) .* cast(B, classname));
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
