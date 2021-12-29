using DataStructures

import Base.Ordering
import Base.lt
import DataStructures.eq

include("file_blacklist.jl")
include("auxiliary_functions.jl")

#=
 # Custom Order Dictionaires
=#
nav_order = Lt((a, b) ->
    begin
        custom_order = ["members", "papers", "philosophy", "teaching-ressources", "thesis-art", "open-projects-and-positions", "contact-us"]
        a_in = a in custom_order
        b_in = b in custom_order
        if(a_in && b_in)
            return findfirst(isequal(a), custom_order) < findfirst(isequal(b), custom_order) ? true : false
        elseif(a_in && !b_in)
             return true
        elseif(!a_in && b_in)
            return false
        else
            return isless(lowercase(a), lowercase(b))
        end
    end)

#=
 # Appends all files and folders, subfolders and their contents of a given path into the provided
 # dict, but ignoring all black listed files and folders.
 # Every folder is pointed at another dict, containing all subfiles and -folders.
=#
function append_files!(dict, folder)
    for file in readdir(string("./", folder))

        # Check for .md file and add to dict, pointing to empty dict
        if contains(file, ".md") && !file_blacklisted(file)

            push!(dict, replace(file, ".md" => "") => SortedDict{String, SortedDict}(nav_order))

        # If not .md check for (black-listed) folders and add them to the dict. This dict is then
        # filled recursivly.
        elseif isdir(file) && !(folder_blacklisted(file))

            inner_dict = SortedDict{String, SortedDict}(nav_order)
            push!(dict, file => inner_dict)
            append_files!(inner_dict, file)

        end
    end
end

# Recursivly generates the HTML code for the side nav, given a dict and a path.
function write_html_side_nav(dict, path, level)
    level_indent = "\t"^(3+level)

    html_string = ""
    for key in keys(dict)

        title = apply_formatting(key)
        href_link = string(path, key)
        #@info "SIDE_NAV_GEN: \n" title

        # Checks if the dict, the key element is pointing to is empty, implying it being a page,
        # not a folder
        if length(keys(get(dict, key, SortedDict{String, SortedDict}(nav_order)))) == 0
            level_indent = "\t"^(3+level)
            list_element_string = "$(level_indent)<li><a class=\"{{ispage $href_link}}active{{end}}\" href=\"/$href_link/\">$title</a></li>\n"
            html_string = string(html_string, list_element_string)

        else

            list_element_string = "$(level_indent)<li><a class=\"second-action\" onclick=\"hideFolder('$key')\"><i id=\"$(string(key,"-folder-icon"))\" class=\"fas fa-chevron-circle-right\"></i></a><a class=\"{{ispage $(string(href_link, "/*"))}}active{{end}}\" href=\"/$path$key\">$title</a>\n $(level_indent)\t<ul id=\"$(string(key,"-folder"))\" class=\"second-invisible\"> \n"

            inner_dynamic_string = write_html_side_nav(get(dict, key, SortedDict(nav_order)), string(path, key, "/"), level + 2)
            html_string = string(html_string, list_element_string, inner_dynamic_string, "$(level_indent)\t</ul>\n $(level_indent)</li>\n")

        end
    end

    return html_string
end

function write_html_top_nav(dict, path, level)

    level_indent = "\t"^(5+level)

    html_string = ""
    for key in keys(dict)

        title = apply_formatting(key)
        href_link = string(path, key)

        # Checks if the dict, the key element is pointing to is empty, implying it being a page,
        # not a folder
        if length(keys(get(dict, key, SortedDict{String, SortedDict}(nav_order)))) == 0
            list_element_string = "$(level_indent)<li><a href=\"/$href_link/\">$title</a></li>\n"
            html_string = string(html_string, list_element_string)

        else

            list_element_string = "$(level_indent)<li><a href=\"/$path$key\">$title</a>\n$(level_indent)\t<ul class=\"nav-second\">\n"

            inner_dynamic_string = write_html_top_nav(get(dict, key, SortedDict(nav_order)), string(path, key, "/"), level + 2)
            html_string = string(html_string, list_element_string, inner_dynamic_string, "$(level_indent)\t</ul>\n$(level_indent)</li>\n")

        end
    end

    return html_string
end

function generate_side_nav()
    # Static first part of HTML file
    file_start =
    "<div class=\"side-nav-wrapper\">
    <div class=\"side-nav\">
    \t<div class=\"search-bar\">
    \t\t<form id=\"lunrSearchForm\" name=\"lunrSearchForm\">
    \t\t\t<input class=\"search-input\" name=\"q\" placeholder=\"Search...\" type=\"text\">
    \t\t\t<input type=\"submit\" value=\"Search\" formaction=\"/search/index.html\">
    \t\t</form>
    \t</div>
    \t<h2>
    \t\tNavigation
    \t</h2>\n"

    # Static end of file
    file_end =
    "\t</div>
</div>\n"

    # Index files
    @info "Indexing files..."
    file_list = SortedDict{String, SortedDict}(nav_order)
    append_files!(file_list, "")

    # Custom add Home page
    file_string_gen = ""
    file_string_gen = string(file_string_gen, "\t\t<ul class=\"first\">\n")
    file_string_gen = string(file_string_gen, "\t\t\t<li><a class=\"{{ispage index}}active{{end}}\" href=\"\\.\\\">Home</a></li>\n")

    # Generate dynamic nav HTML
    @info "Generating side-nav..."
    dynamic_string = write_html_side_nav(file_list, "", 0)
    file_string_gen = string(file_string_gen, dynamic_string)

    # Custom add Impressum page
    file_string_gen = string(file_string_gen, "\t\t</ul>\n")

    page = string(file_start, file_string_gen, file_end)

    # write HTML
    open("./_layout/side_nav.html", "w") do io
        write(io, page)
    end
    @info "Successfully written to HTML file!"
end


function generate_top_nav()
    # Static first part of HTML file
    file_start =
    "<div class=\"masthead\">
    <div class=\"masthead__inner-wrap\">
    \t<div class=\"masthead__menu\">
    \t\t<nav id=\"site-nav\" class=\"greedy-nav\">
    \t\t\t<a class=\"site-title\" href=\"/\"><img src=\"/assets/text_logo.png\"></a>
    \t\t\t<ul class=\"visible-links\">
    \t\t\t\t<a href=\"/open-projects-and-positions/\"> <li class=\"masthead__menu-item\">Open Positions</li> </a>
    \t\t\t\t<a href=\"/members/\"><li class=\"masthead__menu-item\">Members</li></a>
    \t\t\t\t<a href=\"/teaching-ressources/\"><li class=\"masthead__menu-item\">Teaching Ressources</li></a>
    \t\t\t</ul>
    \t\t\t<a href=\"javascript:void(0);\" onclick=\"toggleHamburger()\">
    \t\t\t\t<div class=\"hamburger\">
    \t\t\t\t\t<div class=\"hamburger-elem1\"></div>
    \t\t\t\t\t<div class=\"hamburger-elem2\"></div>
    \t\t\t\t\t<div class=\"hamburger-elem1\"></div>
    \t\t\t\t</div>
    \t\t\t</a>
    \t\t</nav>
    \t\t<div class=\"invisible-hamburger-links\" id=\"hamburgerLinks\">
    \t\t\t<ul class=\"nav-first\">\n"

     # Static end of file
    file_end =
"\n\t\t\t\t</ul>
\t\t\t</div>
\t\t</div>
\t</div>
</div>"

    # Custom add Home page
    file_string_gen = ""
    file_string_gen = string(file_string_gen, "\t\t\t\t\t<li><a href=\".\">Home</a></li>\n")

    # Index files
    @info "Indexing files..."
    file_list = SortedDict{String, SortedDict}(nav_order)
    append_files!(file_list, "")

    # Generate dynamic nav HTML
    @info "Generating top-nav..."
    dynamic_string = write_html_top_nav(file_list, "", 0)
    file_string_gen = string(file_string_gen, dynamic_string)

    # Custom add Impressum and static end of page
    file_string_gen = string(file_string_gen, "\t\t\t\t\t<li><a href=\"/impressum/\">Impressum</a></li>")

    page = string(file_start, file_string_gen, file_end)

    # write HTML
    open("./_layout/nav.html", "w") do io
        write(io, page)
    end
    @info "Successfully written to HTML file!"

end

generate_side_nav()
generate_top_nav()
