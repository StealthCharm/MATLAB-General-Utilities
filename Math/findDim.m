%[text] Given a logical input array, this function returns the indices along the specified dimension that are true.
%[text] This function can return the true indices along a given dimension. Using the n input allows for the n-th true value to be returned; nCount is a logical allowing the first n results to be returned rather than just n. If n is specified nOrLast can be assert; doing so will return the nth true value, or in the event a nth true value doesn't exist, the last true value along that axis. Finally the RowOutput option allows for the results to be return in a row wise matrix where each row is the nth index in dimension dim.
function idx = findDim(A, dim, n, opts)
    arguments
        A logical;
        dim (1, 1) double {mustBeInteger} = firstNonscalarDim(A);
        n (1, :) double {mustBeIntegerOrInf} = [];
        opts.RowOutput (1, 1) logical = false;
        opts.nOrLast (1, 1) logical = isscalar(n) && isinf(n);
    end

    % Simple case where the return is for invalid indices
    if(~isempty(n) && all(~n, "all"))
        idx = double.empty(sizeND(A, dim, Dim=0));
        return
    end

    % Permute the input to work in the first dimension
    [A, dimOrder, Asz] = permuteND(A, dim);

    % Determine the depth, or count of true values on an axis
    depth = sum(A, 1);
    max_depth = max(depth, [], "all");
    % max_depth = max(1, max(depth, [], "all"));

    % Use sort to compact mask and sort indices
    [tf, idx] = sort(A, 1, "descend");

    % Nullify false indices
    idx(~tf) = 0;
    
    % Clip output to minimum range required
    idx = idx(1:max_depth, :);

    % Handle full depth output vs n values
    if(~isempty(n))
        % Check which requests are for the last true value
        nInf = isinf(n);
        infRequest = any(nInf, "all");

        % Store the inf value
        if(infRequest)
            infVal = max(idx, [], 1);
        end

        % Expand the selection pool to +1 to allow OOB requests to return sentinel
        idx = [idx; zeros(1, width(idx))];

        % Clip output to minimum range required (+1 for out of bound n values) 
        n = clip(n, 0, max_depth + 1);

        % CONSIDERING MAKING nOrLast ONLY APPLICABLE TO SCALAR n VALUES
        if(opts.nOrLast)
            % Propagate indices for indexing
            idx = cummax(idx, 1);
        end

        % Gather the desired indices
        idx = idx(n, :);

        % Replace inf request
        if(infRequest)
            idx(nInf, :) = repmat(infVal, sum(nInf, "all"), 1);
        end
    end

    % Format output as requested
    if(opts.RowOutput)
        % Transpose to present each index into the specified dimension as a row
        idx = transpose(idx);
    else
        % Reformat output to span along the specified dimension
        Asz(dim) = height(idx);
        idx = ipermuteND(idx, dimOrder, Asz);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
