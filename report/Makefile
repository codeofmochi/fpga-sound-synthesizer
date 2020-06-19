NAME = AlexandreChau_LoicDroz_FPGASoundSynthesizer

all: pdf zip

pdf:
	pandoc -V geometry:margin=2.5cm --variable urlcolor=cyan --number-sections --filter pandoc-fignos -o $(NAME).pdf $(NAME).md

zip:
	cd .. && find -iname '*.vhd' -o -iname '*.qsys' -o -iname '*.c' -o -iname '*.h' -o -iname '*.do' -o -iname '*.qsys' -o -iname '*.tcl' -o -iname '.cproject' -o -iname '.project' -o -iname 'create-this-app' -o -iname 'Makefile' -not -path './report/*'  -o -iname '*.S' -o -iname '*.py' -o -iname '*.js' -o -iname '*.json' -o -iname '*.qpf' -o -iname '*.qsf' | zip $(NAME).zip -@ && mv $(NAME).zip report/