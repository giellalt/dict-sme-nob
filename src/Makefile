# This is a makefile that builds the sme-nob translation parser


LEXC = lexc -utf8
XFST = xfst -utf8

# fst for the sme-nob dictionary

#Pseudocode:											    
#Make a lexc file:										    
#Print the first line: LEXICON Root						    
#Then, for each entry, make lines of the format smelemma:firstnobtranslation # ;
#Then print the result to file.
#Then make xfst read it with the command read lexc.
# The trick is that only the first <t node may be chosen, there may be several.

smenob.fst: ../bin/smenob.fst ../bin/smedic.fst
../bin/smenob.fst: smenob.xml
	@echo
	@echo "*** Building smenob.fst ***" 
	@echo
	@echo "LEXICON Root" > ../bin/sn.lexc
	@cat smenob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | sed 's/pos=/£/g' | cut -d"£" -f2 | cut -d">" -f2 | cut -d"<" -f1 | tr ' ' '_' > ../bin/n.dic
	@paste -d":" ../bin/s.dic ../bin/n.dic > ../bin/sn.list
	@cat ../sn.list | sed 's/$/ # ;/g' >> ../bin/sn.lexc
	@printf "read lexc < sn.lexc \n\
	save stack ../bin/smenob.fst \n\
	quit \n" > ../../tmp/smenob-save-script
	$(XFST) < ../../tmp/smenob-save-script
	@rm -rf ../../tmp/smenob-save-script



# fst for the Sámi words in the dictionary

#Pseudocode:
#Pick the lemmas, and print them to list
#Read the list into xfst
#Save as an automaton.

# The perlscript for glossing should use smenob.lexc or something similar.

smedic.fst: ../bin/smedic.fst
../bin/smedic.fst: smenob.xml
	@echo
	@echo "*** Building smedic.fst ***" 
	@echo
	@cat smenob.xml | grep '<l pos=' | cut -d">" -f2 | cut -d"<" -f1 > ../bin/s.dic
	@printf "read text < ../bin/s.dic \n\
	save stack ../bin/smedic.fst \n\
	quit \n" > ../../tmp/smedic-save-script
	$(XFST) < ../../tmp/smedic-save-script
	@rm -rf ../../tmp/smedic-save-script

