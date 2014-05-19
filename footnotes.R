out <- c("---", "layout: page",
         "title: Collated footnotes for Data Analysis for Genomics",
         "---","")
dirs <- list.files(".","week*")
for (dir in dirs) {
  files <- list.files(dir, "*.Rmd")
  out <- c(out, paste0("# Week ", sub("week(.*)","\\1",dir)), "")
  for (file in files) {
    lines <- readLines(paste0(dir,"/",file))
    if (sum(grepl("## Footnotes",lines)) == 0) next 
    title <- sub("title: (.*)","\\1",grep("title:",lines,value=TRUE)[1])
    cat("writing:",dir,"/",title,"\n")
    footidx <- grep("## Footnotes", lines)
    footnotes <- lines[(footidx+1):length(lines)]
    footnotes <- footnotes[footnotes != ""]
    out <- c(out, paste0("## ",title), footnotes,"","----","")
  }
}
writeLines(out, con="footnotes.md")
