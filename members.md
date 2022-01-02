@def title = "Members"
@def tags = ["people", "team", "about"]


```julia:team_gen_function
#hideall
import CSV
using CSV
using Random

function gen_html(team_type)
    colors = ["orange", "blue", "green"]

    person_list = readdir("./_assets/team/$team_type")
    for person in person_list
        if isempty(colors)
            colors = ["orange", "blue", "green"]
        end

        color = rand(colors)
        colors = filter(e->e!=color, colors)
        person_data_reader = CSV.File("./_assets/team/$(team_type)/$(person)/profile_info.CSV", delim=";")
        row = person_data_reader[1]

        println("
        ~~~
        <div class=\"teamcard-wrapper\">
            <div class=\"teamcard-image\">
                <img src=\"/assets/team/$team_type/$person/profile_image.jpg\" alt=\"$(row.name)\">
                <div class=\"teamcard-color-strip $(color)\"></div>
            </div>
            <div class=\"teamcard-header\">
                <div class=\"teamcard-title\">$(row.title)</div>
                <h2>$(row.name)</h2>
                <div class=\"teamcard-position\">$(row.position)</div>
            </div>
            <div>
                $(row.hobbys)
            </div>
            <div>
                <i class=\"fas fa-envelope\"></i>
                <a href=\"mailto:$(row.contact)\">$(row.contact)</a>
            </div>
        </div>
        ~~~")
    end    
end
    
```
\textoutput{team_gen_function}

# Current
```julia:team_cards
#hideall
gen_html("current")
```
\textoutput{team_cards}

# Alumni
```julia:team_cards
#hideall
gen_html("alumni")
```
\textoutput{team_cards}

