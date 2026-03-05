%[text] Generalizes the Kronecker tensor product for higher dimensional inputs.
function K = kronND(A, B)
    arguments
        A {mustBeMathematic};
        B {mustBeMathematic};
    end
    
    % Find the highest dim of either operand
    dim = max(ndims(A), ndims(B));
    
    % Gather the size of the operands and output
    Asz = size(A, 1:dim);
    Bsz = size(B, 1:dim);
    Ksz = Asz .* Bsz;
    
    % Cell-ularize the size arguments for reshape operations
    Asz = num2cell([Asz; ones([1, dim])]);
    Bsz = num2cell([ones([1, dim]); Bsz]);
    Ksz = num2cell(Ksz);
    
    % Perform transformations
    A = reshape(A, Asz{:});
    B = reshape(B, Bsz{:});
    K = reshape(A .* B, Ksz{:});
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
