.PHONY: all clean
all: efficient-gmm.pdf

PANELS := $(foreach k,1 2 3 4 5,meme-panels/panel-$(k).png)

# Crop the five 640x360 panels of the meme template
$(PANELS): meme.png
	mkdir -p meme-panels
	for k in 0 1 2 3 4; do magick meme.png -crop 640x360+0+$$((k*360)) +repage meme-panels/panel-$$((k+1)).png; done

efficient-gmm.pdf: efficient-gmm.tex $(PANELS)
	latexmk -xelatex efficient-gmm.tex

clean:
	latexmk -C efficient-gmm.tex
	rm -rf meme-panels
