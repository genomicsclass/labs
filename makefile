RMD_FILES := $(wildcard week2/*.Rmd)
MD_FILES := $(RMD_FILES:.Rmd=.md)

all: $(MD_FILES)

%.md: %.Rmd
	cd $(dir $^); Rscript -e 'knit("$(notdir $^)")'
