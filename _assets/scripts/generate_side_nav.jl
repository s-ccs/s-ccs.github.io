using Printf

function append_files!(dict, folder)
    @info folder
    for file in readdir(string("./../../", folder))

        folder_in_blacklist = false
        for exclude in folder_black_list
            if contains(file, exclude)
                folder_in_blacklist = true
            end
        end

        if contains(file, ".md") && !(file in file_black_list)
            @info "FILE: " file
            push!(dict, replace(file, ".md" => "") => Dict{String, Dict}())

        elseif !contains(file, ".md") && !(folder_in_blacklist)
            @info "Folder: " file
            inner_dict = Dict{String, Dict}()
            push!(dict, file => inner_dict)
            append_files!(inner_dict, file)
        end
    end
end

function write_html(dict, path, level)
    html_string = ""
    for key in keys(dict)
        @info "KEY:" key
        if length(keys(get(dict, key, Dict{String, Dict}()))) == 0

            list_element_string = @sprintf("%s<li><a class=\"{{ispage %s}}active{{end}}\" href=\"/%s/\">%s</a></li>\n", "\t"^(3+level), key, string(path, key), key)
            html_string = string(html_string, list_element_string)
        else
            list_element_string = @sprintf("%s <li>%s\n %s <ul class=\"second\"> \n", "\t"^(3+level), key, "\t"^(4+level))
            inner_dynamic_string = write_html(get(dict, key, Dict()), string(path, key, "/"), level + 1)
            html_string = string(html_string, list_element_string, inner_dynamic_string, @sprintf("%s</ul> \n %s</li> \n", "\t"^(4+level),  "\t"^(3+level)))
        end
    end
    return html_string
end

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
file_end =
"   </div>
</div>\n"


file_list = Dict{String, Dict}()

file_black_list = ["404.md", "README.md", "config.md", "search.md", "impressum.md", "index.md"]
folder_black_list = ["_", "node_modules", ".git", "LICENSE", ".json", ".jl", ".toml", ".idea"]

append_files!(file_list, "")

file_string_gen = ""
file_string_gen = string(file_string_gen, "\t \t <ul class=\"first\">\n")
file_string_gen = string(file_string_gen, "\t \t \t <li><a class=\"{{ispage index}}active{{end}}\" href=\".\">Home</a></li>\n")

dynamic_string = write_html(file_list, "", 0)
file_string_gen = string(file_string_gen, dynamic_string)

file_string_gen = string(file_string_gen, "\t \t \t<li><a class=\"{{ispage impressum}}active{{end}}\" href=\"/impressum/\">Impressum</a></li>\n")
file_string_gen = string(file_string_gen, "\t \t </ul>\n")

page = string(file_start, file_string_gen, file_end)

open("./../../_layout/side_nav.html", "w") do io
    write(io, page)
end