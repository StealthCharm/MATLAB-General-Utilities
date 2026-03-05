%[text] This function returns outputs detailing the uniqueness of elements with respect to the given dimensions.
function [tf, ia, ic] = isUnique(A, dim, flags, options)
    arguments(Input)
        A
        dim (1, :) DimensionArgument = DimensionArgument(A, true);
    end
    arguments(Input, Repeating)
        flags (1, 1) string {mustBeMember(flags, ["rows", "sorted", "stable", "first", "last"])}
    end
    arguments(Input)
        options.TreatMissingAsDistinct (1, 1) logical = false;
    end

    % Dispatch to the proper algorithm for function execution
    if(istext(+dim))
        [tf, ia, ic] = isUnique__all(A, flags, options);
    else
        [tf, ia, ic] = isUnique__dim(A, dim, flags, options);
    end
end
%[text] Simple function to return the results if dimensional independence is desired.
function [tf, ia, ic] = isUnique__all(A, flags, options)
    % Simple logical map generation 
    [~, idx, ia] = mw_unique(A, flags, options);
    Asz = size(A);

    % Generate simplified outputs
    tf = false(Asz); tf(idx) = true;
    ia = reshape(ia, Asz);
    ic = column(1:numel(A));
end
%[text] This function performs the isUnique check in relation to specified dimensions.
function [tf, ia, ic] = isUnique__dim(A, dim, flags, options)
    % Normalize the input argument
    dim = dims(dim, A);

    % Initialize the condition
    options.Last = ~isempty(flags);

    % Check the ordering of indices for dispatching
    if(options.Last)
        [options.Last, idx] = ismember("last", [flags{:}]);
        if(idx); flags(idx) = []; end        
    end

    % Permute the input according to the specified dimensions and record the flattened working size
    [A, dimOrder, sz] = permuteND(A, dim);
    Asz = size(A);

    % Compute the unique elements to enable index checks to do relative uniqueness
    [~, ia, ic] = mw_unique(A, flags, options);
    ic = reshape(ic, Asz); ia = ia(ic);
    
    % Sort the ic values to allow diff comparison to determine uniqueness
    [U, Un] = sort(ic, 1);
    
    % Depending on the first/last flag we switch diff comparison method
    if(options.Last)
        % Use diff and append trues to end
        tf = [logical(diff(U, 1, 1)); true(1, Asz(2))];
        ic = cumsum(tf, 1, "reverse");
    else
        % Use rdiff and append trues to beginning
        tf = [true(1, Asz(2)); logical(rdiff(U, 1, 1))];
        ic = cumsum(tf, 1);
    end
    
    % Compute the indices to access elements such that their order is restored
    On = Un + [0, Asz(1) .* (1:(width(ic) - 1))];
    
    % Restore the order of elements in the mask and relative index map
    tf = tf(On);
    ic = ic(On);
    
    % Restore the input shape and dimension order
    tf = ipermuteND(tf, dimOrder, sz);
    ia = ipermuteND(ia, dimOrder, sz);
    ic = ipermuteND(ic, dimOrder, sz);
end
% function [tf, ia, ic] = isUnique__dim(A, dim, flags, options)
%     % Normalize the input argument
%     dim = dims(dim, A);
% 
%     % Initialize the condition
%     options.Last = ~isempty(flags);
% 
%     % Check the ordering of indices for dispatching
%     if(options.Last)
%         [options.Last, idx] = ismember("last", [flags{:}]);
% 
%         if(idx)
%             flags(idx) = [];
%         end        
%     end
% 
%     % Record the input size
%     [A, dimOrder, sz] = permuteND(A, dim);
%     sz = sz(dimOrder);
%     Asz = size(A);
% 
%     % Get the results of the unique call and format the index map to match the input shape
%     [~, ia, ic] = mw_unique(A, flags, options);
%     ia = ia(reshape(ic, Asz));
% 
%     % Create a column index offset for the sorting maps
%     map_offset = (Asz(1) .* (0:Asz(2)-1));
% 
%     % Sort the indices & generate the map for reverting indices
%     [U, Un] = sort(ia, 1, "ascend");
%     [~, Bn] = sort(Un, 1);
%     Bm = Bn + map_offset;
% 
%     % Depending on the first/last flag we switch diff comparison method
%     if(options.Last)
%         % Use diff and append trues to end
%         tf = [logical(diff(U, 1, 1)); true(1, Asz(2))];
%         ic = cumsum(tf, 1, "reverse");
% 
%         % Provides top down but isnt whats desired
%         % ic = (sum(tf, 1) + 1) - cumsum(tf, 1, "reverse");
%     else
%         % Use rdiff and append trues to beginning
%         tf = [true(1, Asz(2)); logical(rdiff(U, 1, 1))];
%         ic = cumsum(tf, 1);
%     end
% 
%     % Map the mask and group number back to their proper locations
%     tf = tf(Bm);
% 
%     % Don't compute the rest of the mapping unless requested
%     if(nargout > 1)
%         ic = ic(Bm);
% 
%         % Count the number of unique elements per column
%         dim_count = sum(tf, 1);
% 
%         % Determine the position of the true values in each column
%         dim_indices = row(find(tf));
%         dim_offset = cumsum([0, dim_count(1:end-1)], 2);
% 
%         % Find the relative indices depending on the first/last flag
%         ia = dim_indices(ic + dim_offset);
% 
%         % A final sort allows us to gather Cn relative to the first column element
%         [~, Ca, ic] = unique(ia, "stable");
%         ic = reshape(Ca(ic), Asz) - map_offset;
%         ic = clip(ic, 1, dim_count);
% 
%         % Offset An so that references are valid
%         ia = ia - map_offset;
% 
%         % Reform the outputs to match the input shape 
%         ia = ipermute(reshape(ia, sz), dimOrder);
%         ic = ipermute(reshape(ic, sz), dimOrder);
%     end
% 
%     % Remap the correct orientation to the array
%     tf = ipermute(reshape(tf, sz), dimOrder);
% end
%[text] This function normalizes behavior to allow older versions of MATLAB to call the function. The validation of arguments is handled by the main function so the order is changed to avoid re-validation.
function [A, ia, ic] = mw_unique(A, flags, options)
    arguments(Input)
        A
        flags
        options
    end

    % Dispatch the function that is supported depending on the version of MATLAB install
    if(isMATLABReleaseOlderThan("R2026a"))
        % Make original call
        [A, ia, ic] = unique(A, flags{:});

        % Modify the output so behavior matches TreatMissingAsDistinct
        if(options.TreatMissingAsDistinct)
            % Check for missing elements
            missing_elements = row(find(ismissing(A)));

            % Set the value to reference the unique value and those that need replaced
            if(options.Last)
                uidx = missing_elements(end);
                missing_elements(end) = [];
            else
                uidx = missing_elements(1);
                missing_elements(1) = [];
            end

            % Modify the results to match the newer function behavior
            A(missing_elements) = [];
            ia(missing_elements) = [];
            ic(any(ic == missing_elements, 2)) = uidx;
        end
    else
        % Make updated function call
        [A, ia, ic] = unique(A, flags{:}, TreatMissingAsDistinct=options.TreatMissingAsDistinct);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
