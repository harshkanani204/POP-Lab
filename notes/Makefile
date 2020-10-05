GENERATED=pdf fdb_latexmk fls log aux out tex toc
.DEFAULT_GOAL=all
.PHONY: clean all setup-record setup-normal

HOSTNAME=$(shell hostname -s)
%.tex : %.org
	emacs $< --batch -f org-latex-export-to-latex --kill
%.html : %.org
	emacs $< --batch -f org-html-export-to-html --kill

transcript.pdf : transcript.tex
	latexmk -f -pdfxe transcript.tex

all: transcript.html
clean:
	rm -f $(addprefix transcript., ${GENERATED})

setup-record:
	sudo alsactl restore -f alsa-setting/${HOSTNAME}/record.conf

setup-normal:
	sudo alsactl restore -f alsa-setting/${HOSTNAME}/normal.conf
