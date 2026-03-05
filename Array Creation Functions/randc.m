%[text] Generates generates a random string array of alphabet characters.
function A = randc(sz, options)
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end
    arguments(Input)
        options.Case (1, 1) string {mustBeMember(options.Case, ["lower", "upper"])} = "upper";
    end

    % Normalize repeating inputs and generate the random sign values
    sz = normalize_size_args(sz{:}, Default=[1, 1]);
    A = string(num2cell(char(randi([97, 122] - (32 .* strcmp(options.Case, "upper")), sz))));
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
