# This is a makefile that builds the sme-nob translation parser

# It should be rewritten with Twig or something similar instead of 
# the shellscript we have now

# =========== Tools: ============= #
LEXC = lexc #-utf8
XFST = xfst #-utf8
XSLT = ~/lib/saxon8.jar
XQL  = java net.sf.saxon.Query
JARF = -jar
SSH  = /usr/bin/ssh

# =========== Paths & files: ============= #
GTHOME      = ../../../gt
SMETESTING  = $(GTHOME)/sme/testing
SMENOBMAC   = deliv/macdict/objects
SMENOBNAME  = Nordsamisk-norsk ordbok.dictionary
SMENOBZIP   = smenob-mac.dictionary.tgz
UPLOADDIR   = sd@giellatekno.uit.no:xtdoc/sd/src/documentation/content/xdocs
DOWNLOADDIR = http://www.divvun.no/static_files
ADJ         = adjective_smenob.xml
ADV         = adverb_smenob.xml
NOUNC       = nounCommon_smenob.xml
NOUNP       = nounRevProper_smenob.xml
NOUNA		= nounActor_smenob.xml
NOUNG		= nounG3_smenob.xml
OTHER       = nounProperPl_smenob.xml
VERB        = verb_smenob.xml
SN_XML      = smenob.xml
SN_XSL      = smenob.xsl
SN_LEXC     = smenob.lexc
SN_HTML     = smenob.html
SN_FST      = smenob.fst
S_DIC       = sme.dic
S_FST       = smedic.fst
SRC         = src
BIN         = bin
SCRIPTS     = scripts
BEGIN       = @echo "*** Generating the $@-file ***"
END         = @echo "Done."

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

# Create the smenob.fst-file
$(SN_FST): $(SN_LEXC)
	@echo
	$(BEGIN)
	@echo
	@printf "read lexc < $(BIN)/$< \n\
	save $(BIN)/ismenob.fst \n\
	invert net \n\
	save $(BIN)/$@ \n\
	quit \n" > ../tmp/smenob-save-script
	$(XFST) < ../tmp/smenob-save-script
	@rm -rf ../tmp/smenob-save-script
	@echo
	$(END)
	@echo

# # fst for the Sámi words in the dictionary
# # Pseudocode:
# # Pick the lemmas, and print them to list
# # Read the list into xfst
# # Save as an automaton.
# # The perlscript for glossing should use smenob.lexc or something similar.
# #
# # Create the smedic.fst-file
$(S_FST): $(S_DIC)
	@echo
	$(BEGIN)
	@echo
	@printf "read text < $(BIN)/$< \n\
	save stack $> \n\
	quit \n" > ../tmp/smedic-save-script
	$(XFST) < ../tmp/smedic-save-script
	@rm -f ../tmp/smedic-save-script
	@rm -f $(BIN)/$<

# # Create the sme.dic file from the smenob.xml-file
$(S_DIC): $(SN_XML)
	@echo
	$(BEGIN)
	@java $(JARF) $(XSLT) $(BIN)/$(SN_XML) $(SCRIPTS)/get-lemma.xsl > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the lexc file from the smenob.xml-file (using XQuery 1.0)
$(SN_LEXC): $(SN_XML)
	@echo
	$(BEGIN)
	@$(XQL) $(SCRIPTS)/smenob-pairs.xql smenob=../$(BIN)/$< > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the lexc file from the smenob.xml-file (using XSLT 2.0, which is not as nice as XQuery)
# $(SN_LEXC): $(SN_XML)
# 	@echo
# 	$(BEGIN)
# 	@java $(JARF) $(XSLT) $(BIN)/$< $(SCRIPTS)/smenob-pairs.xsl > $(BIN)/$@
# 	@echo
# 	$(END)
# 	@echo

# Create a simple HTML file for local browsing of the whole dictionary
$(SN_HTML): $(SN_XML) $(SCRIPTS)/$(SN_XSL)
	@echo
	$(BEGIN)
	@java $(JARF) $(XSLT) $(BIN)/$(SN_XML) $(SCRIPTS)/$(SN_XSL) > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the smenob.xml-file by unifing the individual parts (using XQuery 1.0)
$(SN_XML):
	@echo
	$(BEGIN)
	@$(XQL) $(SCRIPTS)/collect-smenob-parts.xql \
	 adj=../$(SRC)/$(ADJ) adv=../$(SRC)/$(ADV) nounc=../$(SRC)/$(NOUNC) nouna=../$(SRC)/$(NOUNA) \
	 noung=../$(SRC)/$(NOUNG) nounp=../$(SRC)/$(NOUNP) other=../$(SRC)/$(OTHER) verb=../$(SRC)/$(VERB) > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the smenob.xml-file by unifing the individual parts (using XSLT 2.0, which is not as nice as XQuery)
# $(SN_XML):
# 	@echo
# 	$(BEGIN)
# 	@java $(JARF) $(XSLT) $(SCRIPTS)/dummy.xml $(SCRIPTS)/collect-smenob-parts.xsl \
# 	 adj=../$(SRC)/$(ADJ) adv=../$(SRC)/$(ADV) nounc=../$(SRC)/$(NOUNC) \
# 	 nounp=../$(SRC)/$(NOUNP) nouna=../$(SRC)/$(NOUNA) \
#	 noung=../$(SRC)/$(NOUNG) other=../$(SRC)/$(OTHER) verb=../$(SRC)/$(VERB) > $(BIN)/$@
# 	@echo
# 	$(END)
# 	@echo




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

clean:
	rm -f $(BIN)/*fst $(BIN)/*dic $(BIN)/*lexc $(BIN)/*list $(BIN)/*html $(BIN)/*xml $(BIN)/*txt

