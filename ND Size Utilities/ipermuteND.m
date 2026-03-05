%[text] This function performs the same functionality as ipermute with added functionality to reduce boilerplate when performing dimensional manipulations.
%[text] In addition to automatically prepending unspecified dimensions to the dimOrder, this function allows a size to be specified; the output of the permutation will be reshaped accordingly. If the sz argument is unused, no reshape will occur; if \[\] is used as the size argument, the output of the ipermute operation will be reshaped so that is size matches that of the input; otherwise the size can be specified as it would in reshape directly, or as a double array with NaN specifying where to use \[\].
function A = ipermuteND(A, dimOrder, sz)
    arguments(Input)
        % The input to permute
        A;

        % The order of the dimensional permutation
        dimOrder (1, :) double {mustBeInteger, mustBePositive};

        % The size to reshape the argument to
        sz (1, :) double {mustBeInteger, mustBeNonnegative};
    end

    % Permutes the input such that the output is in the correct order
    A = ipermute(reshape(A, sz(dimOrder)), dimOrder);
end
%[text] ## More expensive implementation with size argument
%[text] This is the previous implementation I made prior to getting comfortable with permuted working algorithms. I thought that the revalidation of the dimOrder and size argument would be useful so included a nice "just works" API that resembles other size argument function syntaxes. In practice however, the dimOrder is not guarenteed to be recovered and the size flexibility doesn't make practical sense since this function is meant to be used directly with permuteND(). For these I'm removing the aforementioned functionality to improve performance. 
% function A = ipermuteND(A, dimOrder, sz)
%     arguments(Input)
%         % The input to permute
%         A;
% 
%         % The order of the dimensional permutation
%         dimOrder (1, :) double {mustBeInteger, mustBePositive};
%     end
%     arguments(Input, Repeating)
%         % The size of the input if modifications were made due to reductions
%         sz (1, :) double {mustBeInteger, mustBeNonnegative};
%     end
% 
%     % Ensure auto-padding if input isn't from permuteND()
%     dimOrder = permuteDims(A, dimOrder);
% 
%     % Normalize the reshape size according to the permutation dimension order
%     sz = normalize_size(A, dimOrder, sz);
% 
%     % Optionally reshapes the output
%     if(~isempty(sz))
%         % Calls reshape with multiple size arguments
%         A = reshape(A, sz{:});
%     end
% 
%     % Permutes the input such that the output is in the correct order
%     A = ipermute(A, dimOrder);
% end
%[text] This function handle formatting the reshape size arguments so that they're normalized and in the expected format.
% function sz = normalize_size(A, dimOrder, sz)
%     % Handle normalization for various patterns
%     if(isSentinelSz(sz))
%         % Allow [] to signal keep the input the same size
%         sz = {}; return;
%     elseif(isFullSize(A, sz))
%         % Unwrap unambiguous cases to avoid extra normalization overhead
%         sz = sz{1};
%     else
%         % Normalize the input reshape size arguments
%         sz = cell2size(sz{:});
% 
%         % Add the last dimension as resizable if needed
%         if(~anymissing(sz) && numel(A) ~= prod(sz))
%             sz = [sz, nan];
%         end
%     end
% 
%     % Reform reshape arguments as cell to avoid syntax issues
%     sz = size2cell(sz(dimOrder));
% end
%[text] Determine if a single size was provided as \[\] or nan, which act as sentinels to signal not to perform the shape
% function tf = isSentinelSz(sz)
%     tf = isempty(sz) || (isscalar(sz) && isEmptyOrMissing(sz{1}));
% end
%[text] This function determines if the size input is a fully qualified size specification for A.
% function tf = isFullSize(A, sz)
%     tf = isscalar(sz) && isnumeric(sz{1}) && numel(A) == prod(sz{1});
% end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
