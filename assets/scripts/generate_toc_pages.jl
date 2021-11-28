include("file_blacklist.jl")

function get_folders(path)
    folder_list = readdir(path)
    filtered_list = filter(blacklisted_or_folder, folder_list)
    @info filtered_list

    for file in filtered_list
        path_to_file = string(path, "/",file)

        subfolders = readdir(path_to_file)

        push!(folder_list, path_to_file)
        folder_list = cat(folder_list, subfolders, dims=1)
    end

    return folder_list
end

function blacklisted_or_folder(file)
    not_folder = !isdir(file)
    blacklisted = false

        for exclude in folder_black_list
            if contains(file, exclude)
                blacklisted = true
            end
        end

    return not_folder || blacklisted
end

function generate_toc_pages()

end

@info get_folders(".")