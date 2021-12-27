@def title = "Members"
@def tags = ["people", "team", "about"]

\newcommand{\currentCard}[7]{
    ~~~
    <div class="teamcard-column-wrapper">
        <div class="teamcard-box-!#7"></div>
        <div class="teamcard-container">
            <div class="teamcard-image"> 
                <img src="/assets/team/!#1/profile_image.jpg" alt="!#3">
            </div>
            <div class="teamcard-info">
                <div class="title">!#2</div>
                <h3>#3</h3>
                <div class="position">!#4</div>
                <h4>Hobbys:</h4>
                <div class="hobbys">!#5</div> 
            </div>
            <div class="teamcard-email"> 
                <a href="mailto:#6">!#6</a> 
            </div>
        </div>
    </div>
    
    ~~~
}

# Members
@@teamcard-wrapper
```julia:team_cards
#hideall
import CSV
using CSV
using Random
colors = ["orange", "blue", "green"]

person_list = readdir("./_assets/team/current")
for person in person_list
    if isempty(colors)
        global colors = ["orange", "blue", "green"]
    end
    color = rand(colors)
    global colors = filter(e->e!=color, colors)
    person_data_reader = CSV.File(string("./_assets/team/current/", person, "/profile_info.csv"), delim=";")
    row = person_data_reader[1]
    """
    \\currentCard{current/$(person)}{$(row.title)}{$(row.name)}{$(row.position)}{$(row.hobbys)}{$(row.contact)}{$(color)}
    """ |> print
end   
```
\textoutput{team_cards}
@@

# Alumni
@@teamcard-wrapper
```julia:alumni_cards
#hideall
import CSV
using CSV
using Random
colors = ["orange", "blue", "green"]

person_list = readdir("./_assets/team/alumni")
for person in person_list
    if isempty(colors)
        global colors = ["orange", "blue", "green"]
    end
    color = rand(colors)
    global colors = filter(e->e!=color, colors)
    person_data_reader = CSV.File(string("./_assets/team/alumni/", person, "/profile_info.csv"), delim=";")
    row = person_data_reader[1]
    """
    \\currentCard{alumni/$(person)}{$(row.title)}{$(row.name)}{$(row.position)}{$(row.hobbys)}{$(row.contact)}{$(color)}
    """ |> print
end   
```
\textoutput{alumni_cards}
@@