include("file_blacklist.jl")
include("auxiliary_functions.jl")

function get_folders(path)
    file_list = readdir(path)
    filtered_list = filter(blacklisted_or_folder, file_list)
    folder_list = []

    for file in filtered_list
        path_to_file = string(path, "/",file)
        subfolders = get_folders(path_to_file)

        push!(folder_list, path_to_file)
        folder_list = cat(folder_list, subfolders, dims=1)
    end

    return folder_list
end

function blacklisted_or_folder(file)
    is_folder = isdir(file)
    blacklisted = false

        for exclude in folder_black_list
            if contains(file, exclude)
                blacklisted = true
            end
        end

    return is_folder && !blacklisted
end

function generate_toc_pages(folder_list)

    for folder in folder_list
        folder_content = sort(filter(e->e!="index.md", readdir(folder)), by=x->lowercase(x))

        # regex needed.
        title = apply_formatting(replace(replace(folder, "-" => " "), "./" => ""))

        toc_content = "@def title = \"$title\" \n@def tags = [\"toc\"] \n# $title\n@@toc-wrapper\n"

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
