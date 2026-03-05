%[text] This function returns the dimension of the input that represents the first trailing singleton dimension.
%[text] Generally this can be used to safely expand inputs along the returned dimension. For example say we wanted to return the results of extract(str, pat) in a vectorized manner. We can expand along the last dimension, and use missing elements for the padded results.
function dim = mdims(A, options)
    arguments
        A = [];
        options.Size (1, 1) logical = false;
    end

    % Added size checks from size input and checks using size equivalent calls, to avoid real branching just leaving
    % both here. Functionally this acts like two functions with the same name, where the option toggles the
    % implementation. 
    if(~options.Size)
        % Since both these classes lie about their size (don't get me started on this)
        % we need to call formula so they're unwrapped and will report size properly
        if(isa(A, "symfun") || isa(A, "symfunmatrix"))
            A = formula(A);
        end
    
        % Find the expansion dimension
        if(isempty(A) && ismatrix(A))
            % Matrix check ensures true 0x0 size; reasoning being that expanding blindly into
            % the first dimension, when shaped empties are allowable, is not generally valid
            dim = 1;
        elseif(isscalar(A))
            % Generalized mdims() algorithm below fails for scalars since all elements are 1
            dim = 2;
        else
            % Find the last dimension that is not a scalar; this works for empty arrays that
            % have shape information about the non-zero dimensions as well
            dim = find(size(A, 1:ndims(A)+1) ~= 1, 1, "last") + 1;
        end
    else
        if(all(~A, "all"))
            % Matrix check ensures true 0x0 size; reasoning being that expanding blindly into
            % the first dimension, when shaped empties are allowable, is not generally valid
            dim = 1;
        elseif(all(A == 1, "all"))
            % Generalized mdims() algorithm below fails for scalars since all elements are 1
            dim = 2;
        else
            % Find the last dimension that is not a scalar; this works for empty arrays that
            % have shape information about the non-zero dimensions as well
            dim = find([A, 1] ~= 1, 1, "last") + 1;
        end
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
