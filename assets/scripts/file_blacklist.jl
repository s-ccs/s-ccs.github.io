#=
 # In this section you can exclude folders and files you don't want to be index in the nav bar,
 # as well as words you want either to be casted to uppercase or not be formatted at all.
 # md files should be stated with their full name, while folders and other file types can also just
 # contain parts of names.
 # TODO: The file black does not filter very efficiently. Could be replaced by regex
=#
##########################################################################################################
file_black_list = ["404.md", "README.md", "config.md", "search.md", "impressum.md", "index.md", "internal.md", "index_content.md"]
folder_black_list = ["_", "node_modules", ".git", "LICENSE", ".idea"]

uppercase_list = ["eeg", "glmm"]
format_blacklist = ["porics"]
##########################################################################################################