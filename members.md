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

## Alumni
```julia:team_cards_alumni
#hideall
include("./_assets/scripts/generate_members_html.jl")
gen_html("alumni")
```
\textoutput{team_cards_alumni}

