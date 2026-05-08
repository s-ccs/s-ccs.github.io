@def title = "Members"
@def tags = ["people", "team", "about"]

# Members

## Current
```julia:team_cards_current
#hideall
include("./_assets/scripts/generate_members_html.jl")
gen_html("current")
```
\textoutput{team_cards_current}

## Hiwi
```julia:team_cards_Hiwi
#hideall
include("./_assets/scripts/generate_members_html.jl")
gen_html("Hiwi")
```
\textoutput{team_cards_Hiwi}


## Alumni
```julia:team_cards_alumni
#hideall
include("./_assets/scripts/generate_members_html.jl")
gen_html("alumni")
```
\textoutput{team_cards_alumni}



