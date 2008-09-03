# This is a makefile that builds the sme-nob translation parser

# It should be rewritten with Twig or something similar instead of 
# the shellscript we have now

# =========== Tools: ============= #
LEXC = lexc -utf8
XFST = xfst -utf8
SSH  = /usr/bin/ssh

# =========== Paths & files: ============= #
GTHOME      = ../../../gt
SMETESTING  = $(GTHOME)/sme/testing
SMENOBMAC   = deliv/macdict/objects
SMENOBNAME  = Nordsamisk-norsk ordbok.dictionary
SMENOBZIP   = smenob-mac.dictionary.tgz
UPLOADDIR   = sd@giellatekno.uit.no:xtdoc/sd/src/documentation/content/xdocs
DOWNLOADDIR = http://www.divvun.no/static_files
SRCS        = adjective_smenob.xml  \
              adverb_smenob.xml     \
              nounCommon_smenob.xml \
              nounProper_smenob.xml \
              other_smenob.xml      \
              verb_smenob.xml

# =========== Other: ============= #
DATE = $(shell date +%Y%m%d)

# fst for the sme-nob dictionary

#Pseudocode:											    
#Make a lexc file:										    
#Print the first line: LEXICON Root						    
#Then, for each entry, make lines of the format smelemma:firstnobtranslation # ;
#Then print the result to file.
#Then make xfst read it with the command read lexc.
# The trick is that only the first <t node may be chosen, there may be several.

# Target to create a fst transducer picking just the first translation of each 
# lemma. And while we're at it, we invert it as well.
smenob.fst: bin/smenob.fst bin/smedic.fst
bin/smenob.fst: smenob.xml  bin/smenob.html
	@echo
	@echo "*** Building smenob.fst ***" 
	@echo
	@echo "*** Reading shellscript smenobpairs.sh ***"

#	@script/smenobpairs.sh # is the next ten lines
# The reference here should be to the glued-together and put in ../tmp.
# Cf. forthcoming Ciprian version of scripts/collect-smenob-parts.xsl
# todo for Ciprian: make an xsl script out of the following 10 lines
    @echo "LEXICON Root" > ../bin/sn.lexc
    @cat ../src/*_smenob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | \
    sed 's/pos=/£/g' | cut -d"£" -f2 | cut -d">" -f2 | cut -d"<" -f1 | \
    grep '[A-Za-z0-9]' | tr ' ' '_' > ../bin/s.dic
    @cat ../src/*_smenob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | \
    sed 's/pos=/£/g' | cut -d"£" -f3 | cut -d">" -f2 | cut -d"<" -f1 | \
    grep '[A-Za-z0-9]' | tr ' ' '_' > ../bin/n.dic
    @paste -d":" ../bin/s.dic ../bin/n.dic > ../bin/sn.list
    @cat ../bin/sn.list | sed 's/$/ # ;/g' >> ../bin/sn.lexc

	@echo
	@echo "*** Calling xfst to compile lexc ***"
	@printf "read lexc < bin/sn.lexc \n\
	save bin/ismenob.fst \n\
	invert net \n\
	save bin/smenob.fst \n\
	quit \n" > ../tmp/smenob-save-script
	$(XFST) < ../../tmp/smenob-save-script
	@rm -rf ../tmp/smenob-save-script

# Create a simple HTML file for local browsing of the whole dictionary
smenob.html: bin/smenob.html
bin/smenob.html: src/smenob.xml scripts/smenob.xsl
	@echo
	@echo "*** Building smenob.html ***" 
	@echo
	@echo "*** Note: We now use the xsltproc tool ***"
	@xsltproc scripts/smenob.xsl $@ > bin/smenob.html

# Target to make a MacOS X/Dictionary.app compatible dictionary bundle:
macdict: macdict/smenob.xml
macdict/smenob.xml: src/smenob.xml \
					scripts/smenob2macdict.xsl \
					scripts/add-paradigm.xsl
	@echo
	@echo "*** Extracting words from dictionary file. ***"
	@echo
	grep '<l pos' $< | \
	   perl -pe 's/^.*pos="([^"]+)">(.+)<.*$$/\2	\1/' | \
	   grep '	[nav]$$' | grep -v '^-' | sort -u \
	   > $(SMETESTING)/dictwords.txt
	@echo
	@echo "*** Generating paradigms. ***"
	@echo
	cd $(SMETESTING) && ./gen-paradigms.sh dictwords.txt
	@echo
	@echo "*** Building smenob.xml for MacOS X Dictionary ***" 
	@echo
	java -Xmx1024m \
		org.apache.xalan.xslt.Process \
		-in  $< \
		-out $@.tmp \
		-xsl scripts/add-paradigm.xsl \
		-param gtpath $(SMETESTING)
	@xsltproc scripts/smenob2macdict.xsl $@.tmp > $@
	rm -f $@.tmp
	@cd deliv/macdict && make

# Target to upload a MacOSX dictionary module
upload-macdict:
	@echo
	@echo "*** TAR-ing and ZIP-ing smenob Mac dictionary ***"
	@echo
	tar -czf $(SMENOBZIP) "$(SMENOBMAC)/$(SMENOBNAME)"
	@echo
	@echo "*** Uploading smenob Mac dictionary to www.divvun.no ***"
	@echo
	@scp $(SMENOBZIP) $(UPLOADDIR)/static_files/$(DATE)-$(SMENOBZIP)
	@$(SSH) sd@divvun.no \
		"cd staticfiles/ && ln -sf $(DATE)-$(SMENOBZIP) $(SMENOBZIP)"
	@echo
	@echo "*** New zip file for smenob Mac dictionary now available at: ***"
	@echo
	@echo "$(DOWNLOADDIR)/$(DATE)-$(SMENOBZIP)"
	@echo
	@echo "*** Permlink to newest version is always: ***"
	@echo
	@echo "$(DOWNLOADDIR)/$(SMENOBZIP)"
	@echo

# fst for the Sámi words in the dictionary
# Pseudocode:
# Pick the lemmas, and print them to list
# Read the list into xfst
# Save as an automaton.
# The perlscript for glossing should use smenob.lexc or something similar.
#
smedic.fst: bin/smedic.fst
bin/smedic.fst: src/smenob.xml
	@echo
	@echo "*** Building smedic.fst ***" 
	@echo
	@cat $@ | grep '<l pos=' | cut -d">" -f2 | \
		cut -d"<" -f1 > bin/s.dic
	@printf "read text < bin/s.dic \n\
	save stack $> \n\
	quit \n" > ../tmp/smedic-save-script
	$(XFST) < ../tmp/smedic-save-script
	@rm -f ../tmp/smedic-save-script
	@rm -f bin/s.dic

clean:
	@rm -f bin/*fst bin/*dic bin/*lexc bin/*list bin/*html


