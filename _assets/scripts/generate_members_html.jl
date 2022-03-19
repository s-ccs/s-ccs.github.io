import CSV
using CSV
using Random

function gen_html(team_type)
    image_vars = ["img-var-1", "img-var-2", "img-var-3"]

    try
        person_list = readdir("./_assets/team/$team_type")

        for person in person_list
            if isempty(image_vars)
                image_vars = ["img-var-1", "img-var-2", "img-var-3"]
            end

            image_var = rand(image_vars)
            image_vars = filter(e->e!=image_var, image_vars)
            person_data_reader = CSV.File("./_assets/team/$(team_type)/$(person)/profile_info.csv", delim=";")
            row = person_data_reader[1]

            println("
            ~~~
            <div class=\"teamcard-wrapper\">
                <div class=\"teamcard-image $(image_var)\">
                    <img src=\"/assets/team/$team_type/$person/profile_image.jpg\" alt=\"$(row.name)\">
                    <div class=\"circle-1\"></div>
                    <div class=\"circle-2\"></div>
                    <div class=\"circle-3\"></div>
                </div>
                <div>
                    <div class=\"teamcard-header\">
                        <div class=\"teamcard-title\">$(row.title)</div>
                        <h2>$(row.name)</h2>
                        <div class=\"teamcard-position\">$(row.position)</div>
                    </div>
                    <div class=\"teamcard-text\">
                        $(row.interests === missing ? "" : row.interests)
                    </div>
                    <div class=\"teamcard-link\">
                        <i class=\"fas fa-envelope\"></i>
                        <a href=\"mailto:$(row.contact)\">$(row.contact)</a>
                    </div>
                </div>
            </div>
            ~~~")
        end

    catch e
        @info e
        print("")
    end
end