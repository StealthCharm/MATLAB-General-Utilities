%[text] This function returns true when there is only one unique value along the given dimensions.
%[text] The MissingFlag option can be used to ignore missing values in the unique count.
function tf = noneunique(A, dim, options)
    arguments
        A;
        dim DimensionArgument = DimensionArgument(A, true);
        options.MissingFlag (1, 1) Enums.MW_Flags.MissingFlag = Enums.MW_Flags.MissingFlag.includemissing;
    end

    if(istext(+dim))
        % Simple case we check that only one unique value exists
        if(omit(options.MissingFlag))
            tf = numunique(rmmissing(A)) == 1;
        else
            tf = numunique(A) == 1;
        end
    else
        % Reshape input so each column is reduction dimension
        [A, dimOrder, Asz] = permuteND(A, +dim);
        
        % Either ignore missing cases or include them
        if(omit(options.MissingFlag))
            % Compare all values to first entry and ensure no differences along reduction dimensions
            tf = all(ismissing(A) | broadcast_isequaln(A, A(1, :)), 1);
            % tf = all(A == A(1, :) | ismissing(A), 1);
        else
            % Compare all values to first entry and ensure no differences along reduction dimensions
            tf = all(ismissing(A), 1) | all(broadcast_isequaln(A, A(1, :)), 1);
            % tf = all(ismissing(A), 1) | all(A == A(1, :), 1);
        end
        
        % Normalize size considering reduction
        Asz(dim) = 1;
        
        % Reshape the output accordingly
        tf = ipermuteND(tf, dimOrder, Asz);        
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
