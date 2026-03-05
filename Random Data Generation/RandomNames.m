%[text] Generates random names for testing purposes.
function [names, sex] = RandomNames(sz, opts)
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end
    arguments(Input)
        % Options related to sex of output names
        opts.Sex (1, 1) Sex = Sex.both;
        opts.Percent (1, 1) double {mustBeInRange(opts.Percent, 0, 1, "inclusive")} = 0.50;

        % Options related to output format
        opts.NameFormat (1, 1) string {mustBeMember(opts.NameFormat, ["first", "last", "full"])} = "full";
        opts.OutputFormat (1, 1) string {mustBeMember(opts.OutputFormat, ["uniform", "array", "struct", "table"])} = "uniform";
        opts.FieldNames (1, 2) string {mustBeValidVariableName} = ["name", "sex"];
    end

    % Read in the random name table
    filename = fullfile(fileparts(mfilename("fullpath")), "RandomNameTable.mat");
    names_data = load(filename, "NameArray").NameArray;
    name_count = height(names_data);

    % Normalize the size input and percentage value
    sz = normalize_size_args(sz{:}, Default=[1, 1]);

    % Normalize the percentage for sex selection generation
    switch(opts.Sex)
        case Sex.male
            opts.Percent = 1 - opts.Percent;
        case Sex.both
            opts.Percent = 0.5;
    end

    % Generate the random sexes
    sex = randl(sz, Percent=opts.Percent);

    % Generate the names 
    switch(opts.NameFormat)
        case "first"
            names = names_data(randi([1, name_count], sz) + (name_count .* sex));
        case "last"
            names = names_data((2 .* name_count) + randi([1, name_count], sz));
        case "full"
            names = names_data(randi([1, name_count], sz) + (name_count .* sex));
            names = names + " " + names_data((2 .* name_count) + randi([1, name_count], sz));
    end

    % Convert to enumeration class
    sex = Sex(sex + 1);

    % Format the output accordingly
    switch(opts.OutputFormat)
        case "struct"
            args = [cellstr(opts.FieldNames); [num2cell(names), num2cell(sex)]];
            names = struct(args{:});
        case "table"
            names = table(column(names), column(sex), VariableNames=opts.FieldNames);
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
