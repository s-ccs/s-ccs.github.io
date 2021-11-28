include("file_blacklist.jl")


#=
 # Appends all files and folders, subfolders and their contents of a given path into the provided
 # dict, but ignoring all black listed files and folders.
 # Every folder is pointed at another dict, containing all subfiles and -folders.
=#
function append_files!(dict, folder)
    for file in readdir(string("./", folder))

        # Check if folder or file is in black list.
        folder_in_blacklist = false

        for exclude in folder_black_list
            if contains(file, exclude)
                folder_in_blacklist = true
            end
        end

        # Check for .md file and add to dict, pointing to empty dict
        if contains(file, ".md") && !(file in file_black_list)

            push!(dict, replace(file, ".md" => "") => Dict{String, Dict}())

        # If not .md check for (black-listed) folders and add them to the dict. This dict is then
        # filled recursivly.
        elseif isdir(file) && !(folder_in_blacklist)

            inner_dict = Dict{String, Dict}()
            push!(dict, file => inner_dict)
            append_files!(inner_dict, file)

        end
    end
end

# Recursivly generates the HTML code for the side nav, given a dict and a path.
function write_html(dict, path, level)

    level_indent = "\t"^(3+level)

    html_string = ""
    for key in keys(dict)

        title = apply_formatting(key)
        href_link = string(path, key)

        # Checks if the dict, the key element is pointing to is empty, implying it being a page,
        # not a folder
        if length(keys(get(dict, key, Dict{String, Dict}()))) == 0
            level_indent = "\t"^(3+level)
            list_element_string = "$(level_indent)<li><a class=\"{{ispage $key}}active{{end}}\" href=\"/$href_link/\">$title</a></li>\n"
            html_string = string(html_string, list_element_string)

        else

            list_element_string = "$(level_indent) <li><a href=\"/$path$key\">$title</a>\n $(level_indent)\t <ul class=\"second\"> \n"

            inner_dynamic_string = write_html(get(dict, key, Dict()), string(path, key, "/"), level + 1)
            html_string = string(html_string, list_element_string, inner_dynamic_string, "$(level_indent)\t</ul> \n $(level_indent)</li> \n")

        end
    end

    return html_string
end

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


function generate_side_nav()
    # Static first part of HTML file
    file_start =
    "<div class=\"side-nav-wrapper\">
        <div class=\"side-nav\">
            <div class=\"search-bar\">
                <form id=\"lunrSearchForm\" name=\"lunrSearchForm\">
                <input class=\"search-input\" name=\"q\" placeholder=\"Search...\" type=\"text\">
                <input type=\"submit\" value=\"Search\" formaction=\"/search/index.html\">
            </form>
            </div>
            <h2>
                Navigation
            </h2>\n"

    # Static end of file
    file_end =
    "   </div>
    </div>\n"

    # Index files
    @info "Indexing files..."
    file_list = Dict{String, Dict}()
    append_files!(file_list, "")

    # Custom add Home page
    file_string_gen = ""
    file_string_gen = string(file_string_gen, "\t \t <ul class=\"first\">\n")
    file_string_gen = string(file_string_gen, "\t \t \t <li><a class=\"{{ispage index}}active{{end}}\" href=\".\">Home</a></li>\n")

    # Generate dynamic nav HTML
    @info "Generating side-nav..."
    dynamic_string = write_html(file_list, "", 0)
    file_string_gen = string(file_string_gen, dynamic_string)

    # Custom add Impressum page
    file_string_gen = string(file_string_gen, "\t \t \t<li><a class=\"{{ispage impressum}}active{{end}}\" href=\"/impressum/\">Impressum</a></li>\n")
    file_string_gen = string(file_string_gen, "\t \t </ul>\n")

    page = string(file_start, file_string_gen, file_end)

    # write HTML
    open("./_layout/side_nav.html", "w") do io
        write(io, page)
    end
    @info "Successfully written to HTML file!"
end