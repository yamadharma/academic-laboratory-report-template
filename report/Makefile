FILES = $(patsubst %.md, %.docx, $(wildcard *.md))
FILES += $(patsubst %.md, %.pdf, $(wildcard *.md))

FILTERS =
PDF_ENGINE =
PDF_OPTIONS =
FORMAT_OPTIONS =

# FILTERS += -F pandoc-citeproc
FILTERS += -F pandoc-crossref
PDF_ENGINE += --pdf-engine=lualatex
PDF_OPTIONS += --number-sections

%.docx: %.md
	-pandoc "$<" $(FILTERS) -o "$@"

%.pdf: %.md
	-pandoc "$<" $(FILTERS) $(PDF_ENGINE) $(PDF_OPTIONS) $(FORMAT_OPTIONS) -o "$@"

all: $(FILES)
	@echo $(FILES)

clean:
	-rm $(FILES) *~
