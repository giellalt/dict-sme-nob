#!/bin/bash

# Script to pair sme and nob from the smenob.xml file
# This file is called from the makefile.

echo "LEXICON Root" > ../bin/sn.lexc

cat smenob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | sed 's/pos=/£/g' | cut -d"£" -f2 | cut -d">" -f2 | cut -d"<" -f1 | grep '[A-Za-z]' | tr ' ' '_' > ../bin/s.dic

cat smenob.xml | tr '\n' ' ' | sed 's/<e>/£/g' | tr '£' '\n' | sed 's/pos=/£/g' | cut -d"£" -f3 | cut -d">" -f2 | cut -d"<" -f1 | grep '[A-Za-z]' | tr ' ' '_' > ../bin/n.dic

paste -d":" ../bin/s.dic ../bin/n.dic > ../bin/sn.list

cat ../bin/sn.list | sed 's/$/ # ;/g' >> ../bin/sn.lexc


