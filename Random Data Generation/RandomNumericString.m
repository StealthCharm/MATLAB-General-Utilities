%[text] Allows for easy generation of random data that relies on `alphanumerics` using a simplified format specifier.
function str = RandomNumericString(fmt, sz, id)
    arguments(Input)
        fmt (1, 1) string = "#"
    end
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end
    arguments(Input)
        id.Numbers (1, 1) string = "#";
        id.Letters (1, 1) string = "*";
    end

    % Normalize size input and determine the numeric substitution count
    sz = normalize_size_args(sz{:}, Default=[1, 1]);

    % Determine the count of each value type
    alpha_count = count(fmt, id.Letters);
    digit_count = count(fmt, id.Numbers);

    % Generate random values for each placeholder type
    alpha_data = char(randi([65, 90], [prod(sz), alpha_count], "int8"));
    digit_data = randi([0, 9], [prod(sz), digit_count], "int8");
   

    % Fill numeric placeholders 
    if(digit_count > 0)
        fmt = compose(replace(fmt, id.Numbers, "%i"), digit_data);
    end

    % Fill alphabetic placeholders 
    if(alpha_count > 0)
        fmt = compose(replace(fmt, id.Letters, "%c"), alpha_data);
    end

    % Reshape the output shape to conform to caller request
    str = reshape(fmt, sz);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
