# LaTeX Makefile

MAIN := main
NAME := $(notdir $(CURDIR))
TEX_FILES := settings.sty

.PHONY: all clean

all: $(NAME).pdf

clean:
	latexmk -C
	rm -rf *-SAVE-ERROR
	rm -rf $(NAME).pdf

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX_FILES)
	latexmk -shell-escape -xelatex -synctex=1 $(MAIN).tex
