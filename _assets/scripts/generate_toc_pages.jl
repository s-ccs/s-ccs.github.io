include("file_blacklist.jl")
include("auxiliary_functions.jl")

function get_folders(path)
    file_list = readdir(path)
    filtered_list = filter(folder_and_not_blacklisted, file_list)
    folder_list = []

    for file in filtered_list
        path_to_file = string(path, "/",file)
        subfolders = get_folders(path_to_file)

        push!(folder_list, path_to_file)
        folder_list = cat(folder_list, subfolders, dims=1)
    end

    return folder_list
end

function folder_and_not_blacklisted(file)

    is_folder = isdir(file)
    black_listed = folder_blacklisted(file)

    return is_folder && !black_listed
end

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

function generate_toc_pages(folder_list)

    for folder in folder_list
        folder_content = sort(filter(f -> !folder_blacklisted(f) && !file_blacklisted(f), readdir(folder)), by=x->lowercase(x))

        start_content = ""
        if(isfile(string(folder, "/index_content.md")))
             start_content = open(f->read(f, String), string(folder, "/index_content.md"))
        end

        # regex needed.
        title = apply_formatting(replace(replace(folder, "-" => " "), "./" => ""))

        toc_content = "@def title = \"$title\" \n@def tags = [\"toc\"] \n# $title\n$start_content\n@@toc-wrapper\n"

        for md in folder_content
            if contains(md, ".md")
                # Regex needed
               toc_content =  string(toc_content, "\t@@toc-item ## [", apply_formatting(replace(md, ".md" => "")), "]($(replace(md, ".md" => ""))) @@\n")
            end
        end

        toc_content =  string(toc_content, "@@")

        open(string(folder, "/index.md"), "w") do io
            write(io, toc_content)
        end
    end



end

toc_page_folders  = get_folders(".")
generate_toc_pages(toc_page_folders)
