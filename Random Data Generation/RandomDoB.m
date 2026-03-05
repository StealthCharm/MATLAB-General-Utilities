%[text] Generates random date of births such that they ensure the individual is between the specified age range.
function [DoB, age] = RandomDoB(rng, sz)
    arguments(Input)
        rng (1, 2) double = [0, 100];
    end
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end

    % Normalize input for use
    sz = normalize_size_args(sz{:}, Default=[1, 1]);

    % Generate a normalized random value to scale against age
    age = rescale(rand(sz), rng(1), rng(2), InputMin=0, InputMax=1);
    
    % Generate the date of birth for each random person
    DoB = datetime("today") - years(age);
    
    % Round the age for display
    age = floor(age);
end
% function [DoB, age] = RandomDoB(sz, age_range)
%     arguments
%         sz (1, :) double {mustBeInteger} = 1;
%         age_range (1, 2) double = [0, 100];
%     end
% 
%     % Generate a normalized random value to scale against age
%     age = rand(sz);
%     age = rescale(age, age_range(1), age_range(2), "InputMin", 0, "InputMax", 1);
% 
%     % Generate the date of birth for each random person
%     DoB = datetime("today") - years(age);
% 
%     % Round the age for display
%     age = floor(age);
% end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
