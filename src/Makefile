# This is a makefile that builds the sme-nob translation parser


LEXC = lexc -utf8
XFST = xfst -utf8

# fst for the Sámi words in the dictionary

# The perlscript for glossing should use smenob.lexc or something similar.

smedic.fst: ../bin/smedic.fst
../bin/smedic.fst: smenob.xml
	@echo
	@echo "*** Building smedic.fst ***" 
	@echo
	@cat smenob.xml | grep '<l pos=' | cut -d">" -f2 | cut -d"<" -f1 > ../bin/sn.dic
	@printf "read text < ../bin/sn.dic \n\
	save stack ../bin/smedic.fst \n\
	quit \n" > ../../tmp/smedic-save-script
	$(XFST) < ../../tmp/smedic-save-script
	@rm -rf ../../tmp/smedic-save-script

# fst for the sme-nob dictionary

#smenob.fst: ../bin/smenob.fst
#../bin/smenob.fst: smenob.xml
#	@echo
#	@echo "*** Building smenob.fst ***" 
#	@echo
## in here: a script extracting what is found between the <l ..>...</l> tag,
## and, for each lemma, what is found in the first <t ..>...</t>
## make an intermediate file smenob.lexc
## The point is to make a file with
#	@printf "read lexc < smenob.lexc \n\
#	save stack ../bin/smenob.fst \n\
#	quit \n" > ../../tmp/smenob-save-script
#	$(XFST) < ../../tmp/smenob-save-script
#	@rm -rf ../../tmp/smenob-save-script
#
