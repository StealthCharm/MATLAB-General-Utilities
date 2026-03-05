%[text] Determines if the input is a vector without concern for the non-singleton dimension's position.
%[text] Note that because zeros do not disqualify empty tensors from being applied to other non empty vector like tensors so the decision was made to not include 0's as a disqualifying factor of the check. That is: this function determines if the input has at most 1 non-singleton dimension.
function [tf, dim] = isvectorND(A)
    % Determine if there is at most one, non-singleton dimension
    sz = size(A);
    tf = sum(sz > 1) < 2;

    % This is the old check doesn't work for empties that specify multiple non singletons
    % tf = length(A) == numel(A); 

    if(nargout > 1)
        % Optionally return the dimension that the input spans
        [~, dim] = max(sz, [], "all");
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
