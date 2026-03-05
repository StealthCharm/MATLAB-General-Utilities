%[text] This function performs the same computation as numunique but relative to the specified dimensions.
function n = numuniqueND(A, dim, options)
    arguments(Input)
        A
        dim (1, :) DimensionArgument = DimensionArgument(A, true);
        options.TreatMissingAsDistinct (1, 1) logical = false;
    end

    % Normalize the input argument
    dim = dims(dim, A);

    % Record the input size
    [A, dimOrder, sz] = permuteND(A, dim, Dim=1);
    Asz = size(A);

    % Get the results of the unique call and format the index map to match the input shape
    [~, ~, ic] = mw_unique(A, options);
    An = reshape(ic, Asz);

    % Sort the indices & generate the map for reverting indices
    U = sort(An, 1);
    n = sum([logical(diff(U, 1, 1)); true(1, Asz(2))], 1);

    % Remap the correct orientation to the array
    n = ipermute(reshape(n, sz(dimOrder)), dimOrder);
end
%[text] This function normalizes behavior to allow older versions of MATLAB to call the function. The validation of arguments is handled by the main function so the order is changed to avoid re-validation. Since 2026a the TreatMissingAsDistinct Name-value option was added, this ensures that even older versions can use this function.
function [U, ia, ic] = mw_unique(A, options)
    arguments(Input)
        A
        options
    end

    % Dispatch the function that is supported depending on the version of MATLAB install
    if(isMATLABReleaseOlderThan("R2026a"))
        % Make original call
        [U, ia, ic] = unique(A);

        % Modify the output so behavior matches TreatMissingAsDistinct
        if(options.TreatMissingAsDistinct)
            % Check for missing elements
            missing_elements = row(find(ismissing(A)));

            % Set the remap values for the missing entries
            uidx = missing_elements(1);
            missing_elements(1) = [];

            % Modify the results to match the newer function behavior
            ic(any(ic == missing_elements, 2)) = uidx;
        end
    else
        % Make updated function call
        [~, ~, ic] = unique(A, TreatMissingAsDistinct=options.TreatMissingAsDistinct);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
