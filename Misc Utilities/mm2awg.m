%[text] Converts a diameter in mm to AWG.
%[text] Rounding options allow the output to be normalized to a valid AWG size, the mm return value is the exact diameter that would produce the AWG without requiring rounding.
function [awg, mm] = mm2awg(mm, opts)
    arguments
        mm double
        opts.Round (1, 1) string {mustBeMember(opts.Round, ["", "Round", "Ceil", "Floor"])} = "Floor";
        opts.TieBreaker (1, 1) string {mustBeMember(opts.TieBreaker, ["fromzero", "tozero", "even", "odd", "plusinf", "minusinf"])} = "fromzero";
    end

    % Calculates the wire gauge
    awg = 36 - (39 * log((1000 * mm) / 127)) / log(92);

    % Handles rounding for the output according to user selection
    switch(opts.Round)
        case "Round"
            awg = round(awg, "TieBreaker", opts.TieBreaker);
        case "Ceil"
            awg = ceil(awg);
        case "Floor"
            awg = ceil(awg);
        otherwise
    end

    % Also returns the diameter for the rounded value
    mm = awg2mm(awg);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"referenceBackgroundColor":"#121212","title":{"color":"#0072bd","fontSize":"18"}}
%---
