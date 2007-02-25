# This is a makefile that builds the sme-nob translation parser

# Here I put in some documentation (to be moved to docu pages)
# The thing is that it still does not work, except for one-tag entries.
# The idea is to link 3 transducers:
# 
# isme.fst          biilla:biila+N+Sg+Acc
# smesmj-inter.fst         biila+N+Sg+Acc:bijlla+N+Sg+Acc
# smj.save                                bijlla+N+Sg+Acc:bijlav
# 
# and as a result get smesmj.fst, giving biilla:bijlav, boađát:kommst, etc.

# The -inter.fst file matches lexeme to lexeme and tagstring to tagstring
# On each side, we have our ordinary transducers mapping from representation
# to actual wordforms.


LEXC = lexc -utf8
XFST = xfst -utf8

smenob.fst: ../bin/smenob.fst
../bin/smenob.fst: ../bin/smenob-inter.fst ~/gt/sme/bin/sme.fst \
	~/st/nob/bin/nob.fst
	@echo
	@echo "*** Building smenob.fst ***" 
	@echo
	@printf "read regex [ [[@\"~/gt/sme/bin/sme.fst\" ] .o. \
	[@\"../bin/smenob-inter.fst\"]] .o. [@\"../bin/smenob-inter.fst\"] .o. \
	[@\"~/st/nob/bin/nob.fst\"] ] ; \n\
	save stack ../bin/smenob.fst \n\
	quit \n" > ../../tmp/smenob-save-script
	$(XFST) < ../../tmp/smenob-save-script
	@rm -rf ../../tmp/smenob-save-script

smenob-inter.fst: ../bin/smenob-inter.fst
../bin/smenob-inter.fst: smenob-lex.txt noun-smenob-lex.txt \
	verb-smenob-lex.txt adj-smenob-lex.txt conjunction-smenob-lex.txt
	@echo
	@echo "*** Building smenob-inter.fst ***" 
	@echo
	@printf "compile-source smenob-lex.txt noun-smenob-lex.txt \
	verb-smenob-lex.txt adj-smenob-lex.txt \
	conjunction-smenob-lex.txt \n\
	source-to-result \n\
	save-result ../bin/smenob-inter.fst \n\
	quit \n" > ../../tmp/smenob-inter-save-script
	$(LEXC) < ../../tmp/smenob-inter-save-script
	@rm -f ../../tmp/smenob-inter-save-script

