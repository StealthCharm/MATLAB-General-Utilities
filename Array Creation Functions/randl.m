%[text] Extension of the `randi()` method setting the parameters such that the output is a random logical array of the specified size.
function tf = randl(sz, options)
    arguments(Input, Repeating)
        sz (1, :) {};
    end
    arguments(Input)
        options.Like;
        options.Percent (1, 1) double = 0.50;
    end

    % Initialize integer array for comparison 
    % Note: I'm not sure if rand() is equally probable or it is some fancy distribution so just using integers and a comparison
    tf = randi([0, 100], sz{:}, "int8");
    tf = isbetween(tf, 0, options.Percent .* 100);

    % Pass casting options through to calling class method
    if(isfield(options, "Like"))
        tf = cast(tf, Like=options.Like);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
