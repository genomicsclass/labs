week1rmd := $(wildcard week1/*.Rmd)
week1md := $(week1rmd:.Rmd=.md)
week2rmd := $(wildcard week2/*.Rmd)
week2md := $(week2rmd:.Rmd=.md)

all: week1 week2

week1: $(week1md)
week2: $(week2md)

%.md: %.Rmd
	cd $(dir $^); Rscript -e 'knit("$(notdir $^)")'
