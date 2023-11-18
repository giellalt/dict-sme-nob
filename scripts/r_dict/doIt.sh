#!/bin/sh


# doubling tests
# rm -f test-results.xml
# java -Xmx2048m net.sf.saxon.Transform -it main check_entry.xsl inDir=init_dir

echo	"cleaning up: removing init_dir ... "
rm -rf init_dir

#dicts/smenob/scripts/r_dict

echo	"removing meta info: license and the like"
java -Xmx2048m net.sf.saxon.Transform -it main filter_meta-info.xsl inDir=../../src

echo	"removing xhtml namespace"
perl -pi -e 's/^(<r) xmlns.*(>)$/$1$2/' init_dir/*.xml 

# revert dict dir
java net.sf.saxon.Transform -it main revert_dict_dir.xsl inDir=init_dir

#echo	"adding pos phrase to all tf"
# add pos="phrase"
#java net.sf.saxon.Transform -it main add_phrase_pos_smenob.xsl inDir=init_dir

#echo	"adding meta info like license and the like"
#java -Xmx2048m net.sf.saxon.Transform -it main add_meta-info_smenob.xsl inDir=outx

# check that properly!
#   <xhtml:script src="../../giella-core/dicts/scripts/gt_dictionary.js" type="text/javascript" xmlns:xhtml="http://www.w3.org/1999/xhtml" />
#echo    " ....... removing xhtml namespace"
#perl -pi -e 's/^(<r) xmlns:xhtml=\".*xhtml\"(.*)$/$1$2/' outxxx/*.xml 

echo	"Done!"


