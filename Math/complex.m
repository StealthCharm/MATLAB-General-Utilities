%[text] This function is an extension/modification of the default complex function. 
%[text] Normally the sizes of the real and imaginary inputs are required to be the same, this function uses addition which means that any broadcast compatible sized inputs will produce desired output. In addition to this change this modification allows a single input call signature which splits the real and imaginary components into separate outputs.
function [r, i] = complex(r, i)
    arguments(Input)
        r
        i = 0;
    end
    arguments (Output)
        r
        i
    end

    if(nargin == 1)
        % Single input argument acts to split real and imaginary portions of the input to separate outputs
        i = imag(r);
        r = real(r);
    else
        % Otherwise we broadcast the imaginary portion applying it to the real
        r = r + (i .* 1i);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
