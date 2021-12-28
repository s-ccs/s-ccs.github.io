# This file was generated, do not modify it. # hide
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