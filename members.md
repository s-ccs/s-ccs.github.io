@def title = "Members"
@def tags = ["people", "team", "about"]

\newcommand{\currentCard}[5]{
    ~~~
    <div class="teamcard-column-wrapper">
        <div class="teamcard-box"></div>
        <div class="teamcard-container">
            <div class="teamcard-image"> 
                <img src="/assets/team/!#1/profile_image.jpg" alt="!#3">
            </div>
            <div class="teamcard-info">
                <div class="title">!#2</div>
                <h3>#3</h3>
                <div class="hobbys">!#4</div> 
            </div>
            <div class="teamcard-email"> 
                <a href="mailto:#5">!#5</a> 
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

person_list = readdir("./_assets/team/current")
for person in person_list
    person_data_reader = CSV.File(string("./_assets/team/current/", person, "/profile_info.csv"), delim=";")
    for row in person_data_reader
        """
        \\currentCard{current/$(person)}{$(row.title)}{$(row.name)}{$(row.hobbys)}{$(row.contact)}
        """ |> print
    end
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

person_list = readdir("./_assets/team/alumni")
for person in person_list
    person_data_reader = CSV.File(string("./_assets/team/alumni/", person, "/profile_info.csv"), delim=";")
    for row in person_data_reader
        """
        \\currentCard{alumni/$(person)}{$(row.title)}{$(row.name)}{$(row.hobbys)}{$(row.contact)}
        """ |> print
    end
end   
```
\textoutput{alumni_cards}
@@