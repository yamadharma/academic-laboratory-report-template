FILES = $(patsubst %.qmd, %.docx, $(wildcard *.qmd))
FILES += $(patsubst %.qmd, %.pdf, $(wildcard *.qmd))

FILTERS =
OPTIONS =
PDF_ENGINE =
PDF_OPTIONS =
FORMAT_OPTIONS =

### Cross references
## Use pandoc-xnos (https://github.com/tomduck/pandoc-xnos)
## Local pandoc-xnos
# FILTERS += --filter pandoc/filters/pandoc_fignos.py --filter pandoc/filters/pandoc_eqnos.py --filter pandoc/filters/pandoc_tablenos.py --filter pandoc/filters/pandoc_secnos.py
## System-wide pandoc-xnos
# FILTERS += --filter pandoc-fignos --filter pandoc-eqnos --filter pandoc-tablenos --filter pandoc-secnos
## Use pandoc-crossref (https://github.com/lierdakil/pandoc-crossref)
FILTERS += --filter pandoc-crossref
###
PDF_ENGINE += --pdf-engine=lualatex --pdf-engine-opt=--shell-escape
OPTIONS += --number-sections
BIB_OPTIONS = --citeproc
PDF_BIB_OPTIONS = --citeproc
# PDF_BIB_OPTIONS = --biblatex

%.docx: %.md
	-@pandoc "$<" $(FILTERS) $(OPTIONS) $(BIB_OPTIONS) -o "$@"

%.pdf: %.md
	-@pandoc "$<" $(FILTERS) $(PDF_ENGINE) $(PDF_OPTIONS) $(PDF_BIB_OPTIONS) $(FORMAT_OPTIONS) $(OPTIONS) -o "$@"

%.docx: %.qmd
	-@quarto render "$<" --to docx

%.pdf: %.qmd
	-@quarto render "$<" --to pdf

all: $(FILES)

clean:
	-rm $(FILES) *~

cleanall: clean
