%[text] This function uses relational operations to perform the equivalence of `sign(diff(A, 1, dim))`. Since `diff()` is not guaranteed to produce a result, let alone an numeric one, this function uses relational operations for classes that define them to signify the difference in magnitude between elements by using relational operators.
function A = cmpdiff(A, dim)
    arguments
        A 
        dim (1, 1) double {mustBeInteger, mustBePositive} = firstNonscalarDim(A); 
    end
    
    if(isnumeric(A))
        % For numerics we will simply use the built in diff() for efficiency
        A = sign(diff(A, 1, dim));
    else
        % Normalize the input orientation to work along columns
        [A, dimOrder, Asz] = permuteND(A, dim, Dim=-1);
    
        % Split comparison groups into separate pages
        A = cat(3, A(1:end-1, :), A(2:end, :));
        mask = any(ismissing(A), 3);
        
        % Generate the diff equality comparison results
        % ~(A(n) == A(n+1)):        Acts to zero-ize equal elements
        % (A(n) > A(n+1)):          Sets up shifts to 1
        % (-1 .* A(n) < A(n+1)):    Sets down shifts to -1
        A = ...
            ~(A(:, :, 1) == A(:, :, 2)) .* ...
            ((A(:, :, 1) < A(:, :, 2)) + (-1 .* A(:, :, 1) > A(:, :, 2)));
        
        % By using pre-check logical mask we dont make assignments unless missing exists 
        % This means we won't encounter errors when classes that don't support missing are used
        % (Besides symbolics probably since they're no-element mask assignment behaves improperly)
        A(mask) = missing;
    
        % Reform the output
        A = ipermuteND(A, dimOrder, Asz);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
