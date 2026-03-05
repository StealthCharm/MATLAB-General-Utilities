%[text] Determines if the input is a matrix without concern for the non-singleton dimension's position.
%[text] Note that because zeros do not disqualify empty tensors from being applied to other non empty vector like tensors so the decision was made to not include 0's as a disqualifying factor of the check. That is: this function determines if the input has at most 2 non-singleton dimension.
function [tf, dim] = ismatrixND(A)
    % Determine which dimensions are nonsingleton or empty 
    % (padding 1 & 2 for empty and vector dim outputs)
    dim = size(A);

    % Check that at most 2 dimensions have a significant length
    tf = sum(dim > 1, "all") <= 2;
    
    % Gather the largest 2 dimensions and order them for the output
    [~, dim] = max(dim, [], 2, "descend");
    dim = dim([2, 1]);
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
