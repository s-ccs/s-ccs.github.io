# LAB homepage
This is the git repository, containing the homepage for the eeg-lab at the VIS of the University of Stuttgart.
The readme will be updated as the project grows, if you feel something is missing, feel free to add an issue. 

## How to deploy the website locally
1. Make sure you have [Julia](https://julialang.org/) installed. This Website is running on Julia 1.6.3, but later versions should work as well.
1. Install Franklin for Julia, by going into the [package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/) and typing `add Franklin; add CSV; add Printf`.
1. Clone this git repository.
1. In Julia, exit the package manager, if you didn't already and [cd](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.cd-Tuple{AbstractString}) into your local repository.
1. Then type the following:
   ```
   using Franklin
   using CSV
   serve()
   ```
   This should open up your browser and render the website. It might take a few seconds to intialize.
   
If you experience any trouble, have a look at the Franklin doc: [Quick Start](https://franklinjl.org/#quick_start)

## Update side_nav.html
If you add any pages, they will be added to the navigation menu, whenever you push the changes to Github. If you wan't to update the nav bar locally, 
just cd into the folder where you would normally start Franklin. There run
```
include("./_assets/scripts/generate_side_nav.jl");
```
!Make sure Printf is installed!

## Update Lunr search index
If you change any content inside the website, make sure to update the lunr search index:
1. Make sure you have Lunr and Cheerio installed with:
   1. Pkg.add(NodeJS)
   2. using NodeJS
   3. run(\`$(npm_cmd) install lunr\`); run(\`$(npm_cmd) install cheerio\`); 
2. Update the search index by calling lunr()
3. You're good to go! Now you can just run serve() as usual

## Licensing
This repository is licensed under the MIT license.
