#!/bin/sh

rm -rf init_dir
#dicts/smenob/scripts/r_dict
java -Xmx2048m net.sf.saxon.Transform -it main filter_meta-info.xsl inDir=../../src

echo	"removing xhtml namespace"

perl -pi -e 's/^(<r) xmlns.*(>)$/$1$2/' init_dir/*.xml 

