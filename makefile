course1rmd := $(wildcard course1/*.Rmd)
course2rmd := $(wildcard course2/*.Rmd)
course3rmd := $(wildcard course3/*.Rmd)
course4rmd := $(wildcard course4/*.Rmd)

course1md := $(course1rmd:.Rmd=.md)
course2md := $(course2rmd:.Rmd=.md)
course3md := $(course3rmd:.Rmd=.md)
course4md := $(course4rmd:.Rmd=.md)

all: course1 course2 course3 course4 foot

course1: $(course1md)
course2: $(course2md)
course3: $(course3md)
course4: $(course4md)

%.md: %.Rmd
	cd $(dir $^); Rscript -e 'knit("$(notdir $^)")'

foot:
	Rscript footnotes.R

