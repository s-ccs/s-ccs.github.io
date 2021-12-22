@def title = "Thesis Art"
@def tags = ["Images", "Project"]

# Thesis Art: Karolis Degutis \date{12. August 2020}

The idea of thesis art is to inspire discussion with persons who do not have an academic background or work in a different field. Each student that finishes his thesis with me, receives a poster print of this piece from me. One copy for them, one for me.

The thesis is hidden in the drawer, but the poster is out there at the wall for everyone to see. You can find all past thesis art pieces here

![](/assets/a2_karolis-727x1024.jpg)

In his project Karolis Degutis (@karolisdegutis) tried to replicate two laminar fMRI effects, but not at high-field 7T, but at 3T. Unfortunately, we failed to replicate these effects – on the one hand, we had to stop acquisition early due to COVID-19, on the other hand, we found anecdotal evidence in favour of the H0.

Karolis made use of laminar fMRI, and accordingly in this thesis art, I used a layerified horizontal slice of brain (bigBrain). The layers are completely made up by the words of his thesis – overall ~55.000 characters were used. This was the first time that I completed a thesis art in Julia. It was a blast! Not only could I completely extract all PDF text easily, but I also used a nice library to solve a large travelling salesman problem. Finally, using makie.jl, plotting that many characters took only 0.5s – and it did not crash at all (compared to my experience with matlab/ggplot).
You can find the julia code here