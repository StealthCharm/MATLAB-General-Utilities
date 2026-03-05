%[text] This function allows for the quick generation of test data representing people.
function data = RandomPersonData(sz, nameOpts, ageOpts, opts)
    arguments(Input, Repeating)
        sz (1, :) double {mustBeInteger};
    end
    arguments(Input)
        % Options related to sex of output names
        nameOpts.Sex (1, 1) string {mustBeMember(nameOpts.Sex, ["both", "male", "female"])} = "both";
        nameOpts.Percent (1, 1) double {mustBeInRange(nameOpts.Percent, 0, 1, "inclusive")} = 0.50;

        % Options related to name format
        nameOpts.NameFormat (1, 1) string {mustBeMember(nameOpts.NameFormat, ["first", "last", "full"])} = "full";

        % Age/DoB Options
        ageOpts.AgeRange (1, 2) double = [0, 100];

        % Output formats options
        opts.Fields (1, :) string {mustBeMember(opts.Fields, ["name", "sex", "age", "DoB", "phone", "ssn"])} = ["name", "sex", "age", "DoB", "phone", "ssn"];
        opts.OutputFormat (1, 1) string {mustBeMember(opts.OutputFormat, ["struct", "table"])} = "struct";
    end

    % Allocate space for valid fields and field data
    fields = ["name", "sex", "age", "DoB", "phone", "ssn"];
    data = cell(1, 6);

    % Check what mock data is desired
    tf = transpose(fields) == opts.Fields;
    idx = row(modn(find(tf), 6));
    tf = transpose(any(tf, 2));

    % Normalize input size
    sz = normalize_size_args(sz{:}, Default=[1, 1]);

    % Modify size for table types to streamline processing
    if(opts.OutputFormat == "table")
        sz = [prod(sz, "all"), 1];
    end

    % Fill out name or sex data
    if(any(tf(1:2), "all"))
        [data{1:2}] = RandomNames(sz, Sex=nameOpts.Sex, Percent=nameOpts.Percent, NameFormat=nameOpts.NameFormat);
    end

    % Fill out age data
    if(any(tf(3:4), "all"))
        [data{[4, 3]}] = RandomDoB(ageOpts.AgeRange, sz);
    end

    % Fill out phone data
    if(tf(5))
        data{5} = RandomNumericString("(614) ###-####", sz);
    end

    % Fill out SSN data
    if(tf(6))
        data{6} = RandomNumericString("### ##-####", sz);
    end

    % Format the output appropriately
    switch(opts.OutputFormat)
        case "struct"
            data = [cellstr(fields(idx)); data(idx)];
            data = struct(data{:});
        case "table"
            data = table(data{idx}, VariableNames=fields(idx));
    end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:styles]
%   data: {"code":{"fontSize":"10"},"heading1":{"color":"#1171be","fontSize":"14"},"heading2":{"color":"#1171be","fontSize":"12"},"heading3":{"color":"#1171be","fontSize":"10"},"normal":{"fontSize":"10"},"referenceBackgroundColor":"#ffffff","title":{"color":"#0072bd","fontSize":"16"}}
%---
