@def title = "Members"
@def tags = ["people", "team", "about"]

\newcommand{\currentCard}[5]{
    ~~~
    <div class="teamcard-container">
        <div class="teamcard-image"> 
            <img src="/assets/team/current/!#1/profile_image.jpg" alt="!#3">
        </div>
        <div class="teamcard-info">
            <div class="title">!#2</div>
            <h3>#3</h3>
            <div class="hobbys">!#4</div> 
        </div>
        <div class="teamcard-email"> 
            <a href="!#5">mailto:#5</a> 
        </div>
    </div>
    <div class="teamcard-box"></div>
    ~~~
}

# Members
@@teamcard-wrapper
\currentCard{001_benedikt_ehinger}{Jun.-Prof. Dr.}{Benedikt Ehinger}{Lorem ipsum doloret}{benedikt.ehinger@vis.uni-stuttgart.de}
@@


```julia:team_cards
#hideall
person_list = readdir("./_assets/team/current")
for person in person_list
    println(person)
end
    
```
[comments]: <>\textoutput{team_cards}