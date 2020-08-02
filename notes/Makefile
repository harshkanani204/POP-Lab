GENERATED=pdf fdb_latexmk fls log aux out tex toc
.DEFAULT_GOAL=all
.PHONY: clean all
%.tex : %.org
	emacs $< --batch -f org-latex-export-to-latex --kill



transcript.pdf : transcript.tex
	latexmk -pdf transcript.tex
all: transcript.pdf
clean:
	rm -f $(addprefix transcript., ${GENERATED})
