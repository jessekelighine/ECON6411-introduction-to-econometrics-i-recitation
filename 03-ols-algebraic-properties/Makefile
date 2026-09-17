# LaTeX Makefile

MAIN := main
NAME := $(notdir $(CURDIR))
FIGURES := $(patsubst %.tex,%.pdf,$(wildcard figures/*.tex))
TEX_FILES := settings.sty references.bib

.PHONY: all clean

all: $(NAME).pdf

clean:
	latexmk -C
	cd figures && latexmk -C
	rm -rf *-SAVE-ERROR
	rm -rf $(NAME).pdf

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX_FILES) $(FIGURES)
	latexmk -shell-escape -xelatex -synctex=1 $(MAIN).tex

figures/%.pdf: figures/%.tex
	latexmk -xelatex -outdir=$(<D) $<
