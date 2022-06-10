# LAB homepage
This is the git repository, containing the homepage for the eeg-lab at the VIS of the University of Stuttgart.
The readme will be updated as the project grows, if you feel something is missing, feel free to add an issue. 

## **TEETHBREAKER** (List of strange, unrational and seemingly unfixable bugs)
### **Code does not get published on live site**
If you ever think you fixed a simple bug like changing a link or some text and publish it, but the the online version of the page does not change, altough the code was published correctly to the main branch, check the **automated scripts**. It's very likely your change get's overwritten when pushed to the gh-pages branch.

## How to deploy the website locally
1. Make sure you have [Julia](https://julialang.org/) installed. This Website is running on Julia 1.6.3, but later versions should work as well.
1. Install Franklin for Julia, by going into the [package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/) and typing `add Franklin; add CSV; add DataStructures`.
1. Clone this git repository.
1. In Julia, exit the package manager by pressing CTRL-C or pressing the backspace key at the beginning of the line, if you didn't already and [cd](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.cd-Tuple{AbstractString}) into your local repository.
1. Then type the following:
   ```
   using Franklin
   using CSV
   serve()
   ```
   This should open up your browser and render the website. It might take a few seconds to intialize.
   
If you experience any trouble, have a look at the Franklin doc: [Quick Start](https://franklinjl.org/#quick_start)

### Troubleshooting
1. If your local preview of the members page shows something along the lines of
   Argument Error: Package CSV not found in current path: Run `import Pkg; Pkg.add("CSV")` to install CSV package.
   Have a look [here](https://franklinjl.org/code/#projecttoml). This problem might be due to a wrong path in the project.toml or manifest.toml. 
   The most reliable way to fix this so far, is deleteing both .toml files and re-adding the packages in julia by cd'ing into the project folder and adding, as well as       activating the packages (see link above).

## File Structure 
Generally, the site follows the Franklin folder structure, documented [here](https://franklinjl.org/workflow/#folder_structure). If you just want to edit the content of the website, get familiar with Markdown and the basic functionality of [Franklin](https://franklinjl.org/)
Folders are made into master pages, linking to the `*.md` pages found in that folder. This allows you to group content. If you don't want a folder to be part of the website you can blacklist it (as well as any other file). If you want to extend the site generation, all scripts can be found under `.\_assets\scritps\`

### Blacklists
In the `.\_assets\scritps\` folder is file named `file_blacklist.jl`. It contains all needed blacklist for the site generation.\
The **file blacklist** lists MD files that should not be reached by any navigation element. The names of the file have to be added in whole, casesensitive and with file extension.\
In contrast the **folder blacklist** only needs keywords and/ or symbols that need to be contained in a folder or non-md file for not to be part of the website as all, i.g as a toc page to group content. \
**Uppercase list** is a list of pages, that should be rendered in uppercase in the navigation menu.\
**Format Blacklist** is a blacklist for names, that shouldn't be formatted at all. In that case the name of the folder is used as is.\
`I.g. eeg.md becomes EEG and PoRiCS.md becomes PoRiCS`

## Extending and editing the page
### Generation scripts
Under `.\_assets\scritps\` all scripts for page generation and similar scripts that should be run after deployement, but before the changes go live. If scripts are added there, they either should be called in `inti_dynamics.jl` or manually added to the github action under `.\.github\workflows\Deploy.yml`.

### Custom ordering the navigation
The first level of all navigation elements can have a custom ordering, while any higher level is going to be sorted alphabeticially.
The first level is sorted like this: Any page that is specified in the custom order (see below) is sorted and inserted into the navigation as the custom order demands. Any further page that is not contained in there, will be appended at the end of the navigation. In case of multiple such pages, those are sorted alphabeticially.

In the `generate_side_nav.jl` under `.\_assets\scripts\` is a `custom_order` array, that contains all custom ordered pages in their correct order. This array can be modified to meet the demands needed. (This array might be extracted in the future, if the script is not like documented here, look for an obvious script name in the script folder)

### Custom content for TOC pages
In general the toc pages (such es Teaching Ressources or Thesis Art) are just a hub to link to the content of this group. But of course there should be some content before the grid of links. In each folder that becomes a toc page, you can add a index_content.md file. This file will be ignored by any navigation elements and the contents will be prepended to the links of the toc page.

Furthermore TOC pages now have an image preview. The images for each tile have to be added by hand. Images should have resolution of 400px x 380px. Folder structure is like: `\assets\toc-previews\sub-folder-name\Page-Name.jpg`. The image size is important in that regard, thats it both controls the image size on screen as well as the aspectio ratio of the background circles.

### Background Circles
Teammembers and TOC pages have cirles as a visual feature. These are completely made in CSS. Every box contains a 7x7 grid. With `grid-template-rows` and `grid-template-columns` are the areas defined, in which the individual circles are defined. They can overlap, but they can't start and end in the same box. The circles themself are bordered divs with rounded edges. This makes it fairly easy to make new variations of cirlce patterns. If you want to read up, have a look here: `https://css-tricks.com/snippets/css/complete-guide-grid/`

## Update Team Members
The team member page is auto generated by the contents in [\_assets\team\ ](https://github.com/s-ccs/s-ccs.github.io/tree/main/_assets/team). You can add, delete or update both current members or almunis in their respective folders. 
### Naming of the folders
The folders consist of a number and the team member's name. I.e. `001_benedikt_ehinger `
The number is for ordering purposes, the name just for readability reasons. The name used for the website is taken from the CSV file
### Folder Contents
The folder of each member needs the following things:
1. A `.jpg` image, named profile_image.jpg with a size of 360px x 360px. 
2. A `.csv` file, containing all info displayed in the member card.
#### CSV Structure
The CSV should use `;` as its delimiter and `newline` as row seperator. 
The structer of the file should look like:
|title|name|position|hobbys|contact|
|-----|----|--------|------|-------|
|Jun.-Prof. Dr.|Benedikt Ehinger|SimTech-Tenure-Track-Professur CCS|Lorem ipsum|benedikt.ehinger@vis.uni-stuttgart.de|

## Update Papers list
For now, papers are sorted by year published. Therefore for every year, there will be a CSV file in `.\_assets\papers\`
This CSV file is built like this:

|Title|Author|DOI|PDF|
|-----|------|---|---|
|name-of-publications|names-of-authors|identifier|link-to-pdf `i.g. "..\assets\papers\pdf\paper1.pdf"`|

If you want to upload the paper directly on the homepage, you can put the pdf of the paper in `..\assets\papers\pdf\`
Read below on how to update the list.

## Update dynamic content (like Navigation elements and TOC pages)
If you add any pages, they will be added to the navigation menu, whenever you push the changes to Github. Same goes for the generation of TOC pages for folderse and subfolders. If you wan't to update the nav bar etc. locally, 
just cd into the folder where you would normally start Franklin. There run
```
include("./_assets/scripts/init_dynamics.jl");
```

## Update Lunr search index
If you change any content inside the website, make sure to update the lunr search index:
1. Make sure you have Lunr and Cheerio installed with:
   1. Pkg.add(NodeJS)
   2. using NodeJS
   3. run(\`$(npm_cmd) install lunr\`); run(\`$(npm_cmd) install cheerio\`); 
2. Update the search index by calling lunr()
3. You're good to go! Now you can just run serve() as usual

## ToDo's/ Ideas on how to improve the page
- Better SEO
- Warning system, if changes are made to pages that are auto-generated and not to the generation script itself

## Licensing
This repository is licensed under the MIT license.
