include("file_blacklist.jl")
include("auxiliary_functions.jl")

function get_folders(path)
    folder_list = []
    try
        file_list = readdir(path)
        filtered_list = filter(folder_and_not_blacklisted, file_list)
        folder_list = []

        for file in filtered_list
            path_to_file = string(path, "/",file)
            subfolders = get_folders(path_to_file)

            push!(folder_list, path_to_file)
            folder_list = cat(folder_list, subfolders, dims=1)
        end
    catch e
        @info e
    end

    return folder_list
end

function generate_toc_pages(folder_list)

    for folder in folder_list

        folder_content = []
        try
            folder_content = sort(filter(f -> !folder_blacklisted(f) && !file_blacklisted(f), readdir(folder)), by=x->lowercase(x))
        catch e
            @info e
        end

        start_content = ""
        try
            if(isfile(string(folder, "/index_content.md")))
                start_content = open(f->read(f, String), string(folder, "/index_content.md"))
            end
        catch e
            @info e
        end

        title_raw = last(split(folder, "/"))
        title = apply_formatting(replace(title_raw, "-" => " "))

        html_head_content = "<html lang=\"en\">\n\t{{ insert head.html }}\n\t<div class=\"franklin-content\">\n\t\t<h1 id=\"$title_raw\"><a href=\"#$title_raw\">$title</a></h1>\n\t\t\t<div class=\"toc-wrapper\">\n"
        html_end_content = "\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t{{ insert page_foot.html }}\n\t</body>\n</html>"
        toc_content = ""

        for file in folder_content
            file_edited = apply_formatting(replace(replace(file, ".md" => ""), "-" => " "))
            if contains(file, ".md")
                toc_content = string(toc_content, "\t\t\t\t<a href=\"$(replace(file, ".md" => ""))\">\n\t\t\t\t<div class=\"toc-titles\">$file_edited</div><div class=\"teamcard-image img-var-$(rand((1,3)))\">\n\t\t\t\t\t<img src=\"/assets/toc-previews/$(replace(folder, "./" => ""))/$(replace(file, ".md" => "")).jpg\">\n\t\t\t\t\t<div class=\"circle-1\"></div>\n\t\t\t\t\t<div class=\"circle-2\"></div>\n\t\t\t\t\t<div class=\"circle-3\"></div>\n\t\t\t\t</div>\n\t\t\t\t</a>")                
            end
        end

        toc_write = string(html_head_content, toc_content, html_end_content)
        open(string(folder, "/index.html"), "w") do io
            write(io, toc_write)
        end

        # toc_content = "@def title = \"$title\" \n@def tags = [\"toc\"] \n# $title\n$start_content\n@@toc-wrapper\n"

        # for md in folder_content
        #     if contains(md, ".md")

        #       toc_content =  string(toc_content, "\t@@image-var-1 [![](/assets/toc-previews/$(replace(folder, "./" => ""))/$(replace(md, ".md" => "")).jpg)](", replace(md, ".md" => ""), ")\n\t\t@@circle-1@@\n\t\t@@circle-2@@\n\t\t@@circle-3@@\n\t@@\n") #\n ### [", apply_formatting(replace(md, ".md" => "")), "]($(replace(md, ".md" => ""))) 
        #     end
        # end

        # toc_content =  string(toc_content, "@@")

        # open(string(folder, "/index.md"), "w") do io
        #     write(io, toc_content)
        # end
    end
end

toc_page_folders  = get_folders(".")
generate_toc_pages(toc_page_folders)
