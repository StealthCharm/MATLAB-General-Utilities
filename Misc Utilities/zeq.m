%[text] This function produces the equivalent impedance along the specified dimension.
function z = zeq(z, dim, options)
    arguments
        z 
        dim (1, :) double {mustBeInteger, mustBePositive} = firstNonscalarDim(z);
        options.Mode (1, 1) string {mustBeMember(options.Mode, ["parallel", "series"])} = "parallel";
    end

    switch(options.Mode)
        case "parallel"
            z = 1 ./ sum(z.^-1, dim);
        case "series"
            z = sum(z, dim);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
