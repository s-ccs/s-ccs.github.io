include("file_blacklist.jl")

# Formats the file names to title case
function apply_formatting(name)
    title = name
    if !(lowercase(name) in format_blacklist) && !(lowercase(name) in uppercase_list)
        title = titlecase(replace(name, "-" => " "))
    elseif lowercase(name) in uppercase_list
        title = uppercase(title)
    end

    return title
end