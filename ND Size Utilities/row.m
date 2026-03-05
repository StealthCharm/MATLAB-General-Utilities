%[text] Reshapes the input into a row vector.
function A = row(A, options)
    arguments(Input, Repeating)
        A
    end
    arguments(Input)
        options.Flatten (1, 1) logical = false;
    end
    arguments(Output, Repeating)
        A
    end

    for n = 1:numel(A)
        A{n} = reshape(A{n}, 1, []);
    end

    if(options.Flatten)
        A = {horzcat(A{:})};
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"referenceBackgroundColor":"#121212","title":{"color":"#0072bd","fontSize":"18"}}
%---
