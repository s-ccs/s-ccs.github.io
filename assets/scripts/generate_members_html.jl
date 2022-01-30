import CSV
using CSV
using Random

function gen_html(team_type)
    colors = ["orange", "blue", "green"]

    person_list = readdir("./_assets/team/$team_type")
    @info person_list
    for person in person_list
        if isempty(colors)
            colors = ["orange", "blue", "green"]
        end

        color = rand(colors)
        colors = filter(e->e!=color, colors)
        person_data_reader = CSV.File("./_assets/team/$(team_type)/$(person)/profile_info.csv", delim=";")
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
                $(row.interests === missing ? "" : row.interests)
            </div>
            <div>
                <i class=\"fas fa-envelope\"></i>
                <a href=\"mailto:$(row.contact)\">$(row.contact)</a>
            </div>
        </div>
        ~~~")
    end    
end