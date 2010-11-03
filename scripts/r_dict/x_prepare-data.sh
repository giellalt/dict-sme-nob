#!/bin/sh

rm -rf outd

java -Xmx2048m net.sf.saxon.Transform -it main filter_meta-info.xsl inDir=.

echo	"removing xhtml namespace"

perl -pi -e 's/^(<r) xmlns.*(>)$/$1$2/' outd/*.xml 

