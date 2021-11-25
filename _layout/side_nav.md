~~~
<div class="side-nav-wrapper">
    <div class="side-nav">
        <div class="search-bar">
            <form id="lunrSearchForm" name="lunrSearchForm">
            <input class="search-input" name="q" placeholder="Search..." type="text">
            <input type="submit" value="Search" formaction="/search/index.html">
        </form>
        </div>
        <h2>
            Navigation
        </h2>
~~~
```julia\nav_list

page_list = []
black_list = ["404.md", "README.md", "config.md", "search.md"]

for file in readdir()
    if contains(file, ".md") && not !contains(black_list, file)
        push!(page_list, replace(file, ".md" => ""))  
   end
    
end

println("<ul class=\"first\">")
for page in page_list
    println("<li><a class=\"{{ispage %s}}active{{end}}\" href=\"/%s/\">%s</a></li>", page)
end
println("</ul>")
```
\textoutput(nav_list)
~~~
    </div>
</div>
~~~