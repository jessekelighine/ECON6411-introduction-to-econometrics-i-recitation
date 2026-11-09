.PHONY: all
all: iv-distribution.pdf

.PHONY: clean
clean:
	@rm -rf *.pdf *.csv

iv-distribution.pdf: simulation.R
	Rscript simulation.R
