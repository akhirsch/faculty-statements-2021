export TEXINPUTS = .::$TEXMF/tex/::latex-pl-syntax

.PHONY: clean all main cleanall outlines statements
main: statements
statements: hirsch-research.pdf hirsch-teaching.pdf hirsch-diversity.pdf
outlines: research_stmt_outline.pdf
all: statements outlines

research_stmt_outline.pdf: research_stmt_outline.org
	pandoc --pdf-engine=xelatex -o research_stmt_outline.pdf research_stmt_outline.org

hirsch-research.pdf: hirsch-research.tex bibliography/main.bib
	latexmk -pdf hirsch-research.tex

hirsch-teaching.pdf: hirsch-teaching.tex
	latexmk -pdf hirsch-teaching.tex

hirsch-diversity.pdf: hirsch-diversity.tex
	latexmk -pdf hirsch-diversity.tex

ALLCLEANABLES := $(shell find . \( -name '*.aux'\
                             -o -name '\#*\#'\
			     -o -name '*.log'\
			     -o -name '*.bbl'\
                             -o -name '*.out'\
                             -o -name '*~'\
                             -o -name '*.pdf'\
                             -o -name '*.dvi'\
                             -o -name '*.synctex.gz'\
                             -o -name '*.blg'\
                             -o -name 'research_statement_outline.tex'\
                             -o -name '*.toc'\
                             -o -name '*.lot'\
			     -o -name '*.fls'\
			     -o -name '*.rip'\
			     -o -name '*.fdb_latexmk'\
			     -o -name '*.xcp'\
			     -o -name '*.xoj'\
                             -o -name '*.lof' \) -type f  -not -path "./.git/*")

CLEANABLES := $(shell find . \( -name '*.aux'\
			     -o -name '\#*\#'\
			     -o -name '*.log'\
			     -o -name '*.bbl'\
                             -o -name '*.out'\
                             -o -name '*~'\
                             -o -name '*.synctex.gz'\
                             -o -name '*.blg'\
                             -o -name 'research_statement_outline.tex'\
                             -o -name '*.toc'\
                             -o -name '*.lot'\
			     -o -name '*.fls'\
			     -o -name '*.rip'\
			     -o -name '*.fdb_latexmk'\
			     -o -name '*.xcp'\
                             -o -name '*.lof' \) -type f -not -path "./.git/*")

clean: 
	@for f in $(CLEANABLES); do \
		echo "REMOVING $$f";\
		rm $$f;\
	done

cleanall: 
	@for f in $(ALLCLEANABLES); do \
		echo "REMOVING $$f";\
		rm $$f;\
	done
