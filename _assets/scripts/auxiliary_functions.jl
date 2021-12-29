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

# Checks wether a path leads to a folder and a non blacklisted file
function folder_and_not_blacklisted(file)

    is_folder = isdir(file)
    black_listed = folder_blacklisted(file)

    return is_folder && !black_listed
end

# Checks wether a folder is blacklisted.
function folder_blacklisted(file)
    blacklisted = false

    for exclude in folder_black_list
        if contains(file, exclude)
            blacklisted = true
            break
        end
    end

    return blacklisted
end

# Checks wether a file is blacklisted.
function file_blacklisted(file)
    blacklisted = false

    for exclude in file_black_list
        
        if contains(file, exclude)
            blacklisted = true
            break
        end
    end

    return blacklisted
end