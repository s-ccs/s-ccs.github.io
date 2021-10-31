# This file was generated, do not modify it. # hide
#hideall
import CSV
using CSV

person_list = readdir("./_assets/team/current")
for person in person_list
    person_data_reader = CSV.File(string("./_assets/team/current/", person, "/profile_info.csv"))
end