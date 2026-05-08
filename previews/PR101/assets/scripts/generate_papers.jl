import CSV
using CSV

page_start = 
"@def title = \"Papers\"
@def tags = [\"pdf\", \"publications\"]

# Archive of Papers\n"

page_content = ""
try 
    reverse_file_list = sort(readdir("./_assets/papers"), rev=true)

    for csv_file in filter(f->contains(f, ".csv"), reverse_file_list)
        header = string("## ", replace(csv_file, ".csv"=>""), "\n@@doi-table")

        global page_content = string(page_content, header, "\n|Title|Authors|DOI/PDF|\n|-----|-------|------|\n")

        row_num = 0
        csv_reader = CSV.File(string("./_assets/papers/", csv_file), delim=";")
        for row in csv_reader
            global page_content = string(page_content, "|$(row.Title)|$(row.Authors)|[DOI](https://doi.org/$(row.DOI))/[PDF]($(row.pdf))|\n")
            row_num += 1
        end

        if row_num == 0
           global page_content = string(page_content, "| | | | |\n")
        end

       global page_content = string(page_content, "@@\n\n")
    end

    global page_content = string(page_start, page_content)

catch e
    @info e
    global page_content = string(page_start, "An error occured while reading the papers, please be patient, while we try to fix this issue.")
end

open("papers.md", "w") do io
    write(io, page_content)
end