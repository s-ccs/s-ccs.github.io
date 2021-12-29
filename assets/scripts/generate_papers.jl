import CSV
using CSV

page_start = 
"@def title = \"Papers\"
@def tags = [\"pdf\", \"publications\"]

# Archive of Papers\n"

page_content = ""

for csv_file in filter(f->contains(f, ".csv"), readdir("./_assets/papers"))
    header = string("## ", replace(csv_file, ".csv"=>""))

    global page_content = string(page_content, header, "\n|Title|Authors|DOI|PDF|\n|-----|-------|---|---|\n")

    row_num = 0
    csv_reader = CSV.File(string("./_assets/papers/", csv_file), delim=";")
    for row in csv_reader
        global page_content = string(page_content, "|$(row.Title)|$(row.Authors)|$(row.DOI)|[PDF]($(row.pdf))|\n")
        row_num += 1
    end

    if row_num == 0
        page_content = string(page_content, "| | | | |\n")
    end

    page_content = string(page_content, "\n")
end

page_content = string(page_start, page_content)

open("papers.md", "w") do io
    write(io, page_content)
end