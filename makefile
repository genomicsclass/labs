week1rmd := $(wildcard week1/*.Rmd)
week2rmd := $(wildcard week2/*.Rmd)
week3rmd := $(wildcard week3/*.Rmd)
week4rmd := $(wildcard week4/*.Rmd)
week5rmd := $(wildcard week5/*.Rmd)
week6rmd := $(wildcard week6/*.Rmd)
week7rmd := $(wildcard week7/*.Rmd)
week8rmd := $(wildcard week8/*.Rmd)

week1md := $(week1rmd:.Rmd=.md)
week2md := $(week2rmd:.Rmd=.md)
week3md := $(week3rmd:.Rmd=.md)
week4md := $(week4rmd:.Rmd=.md)
week5md := $(week5rmd:.Rmd=.md)
week6md := $(week6rmd:.Rmd=.md)
week7md := $(week7rmd:.Rmd=.md)
week8md := $(week8rmd:.Rmd=.md)

all: week1 week2 week3 week4 week5 week6 week7 week8 foot

week1: $(week1md)
week2: $(week2md)
week3: $(week3md)
week4: $(week4md)
week5: $(week5md)
week6: $(week6md)
week7: $(week7md)
week8: $(week8md)

%.md: %.Rmd
	cd $(dir $^); Rscript -e 'knit("$(notdir $^)")'

foot:
	Rscript footnotes.R

