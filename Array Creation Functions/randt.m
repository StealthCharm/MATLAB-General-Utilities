%[text] Generates a random array of ternary values from -1:1.
function A = randt(sz, classOpts)
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end
    arguments(Input)
        classOpts.Like = [];
    end

    % Normalize repeating inputs and generate the random sign values
    sz = normalize_size_args(sz{:}, Default=[1, 1]);
    A = randi([-1, 1], sz, Like=classOpts.Like);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
