classdef Sex < int8
    %Sex Enumerate sex/gender to enable easier processing.
    %   Detailed explanation goes here

    %% Enumeration members

    % Default missing element
    enumeration(Hidden)
        invalid    (-1)
        missing    (-1)
    end

    % Public members
    enumeration
        both       (0)
        male       (1)
        female     (2)
    end

    % Variants
    enumeration(Hidden)
        man        (1)
        woman      (2)

        men        (1)
        women      (2)

        males      (1)
        females    (2)
    end

    %% Utility methods
    methods
        function tf = ismissing(obj, indicators)
            %ismissing Implements missing semantics for the invalid sex/gender.
            arguments(Input)
                obj Sex
                indicators Sex = Sex.invalid;
            end

            % Flatten the comparison indicators to enable broadcasting
            dim = mdims(obj);
            tf = any(obj == vector(indicators, dim), dim);
        end
    end
end