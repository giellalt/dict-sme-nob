#!/bin/bash

echo "Extract the sami words from the file inc-smenob-list.dic:"
cat inc-smenob-list.dic | cut -f1 | sort -u > dicat

echo "Extract the sami words from the file smenob.xml:"
cat smenob.xml | grep '<l>' | sed -e 's/      <l>//' -e 's/<\/l>//' > xmlat

echo "Gather the words not found in the xml file into the file in_dic_butnot_in_xml:"
comm -23 dicat xmlat > in_dic_butnot_in_xml

echo "Extract the lines containg the sami word and the translation from inc-smenob-list.dic into the file boadus.txt:"
for i in `cat in_dic_butnot_in_xml`; do grep $i inc-smenob-list.dic >> boadus.txt; done

echo "Format the file boadus.txt to a xml file, without header and footer:"
cat boadus.txt | sed -e 's_^_<e><lg><l>_' -e 's_$_</l><lc></lc></lg><mg><tg><t></t></tg></mg></e>_' > boadus.xml

echo "Strip header and footer from smenob.xml:"
grep -v "^<" smenob.xml > smenob.xml.header-footerless

echo "Format the header/footerless file to have one entry per line:"
cat smenob.xml.header-footerless | tr "\n" "\t" | sed  -e 's,  ,,g' -e 's,\t,,g' -e 's,</e><e>,</e>\n<e>,g' > sme-nob.xml.tmp

echo "Add a correct header:"
head -4 smenob.xml > test.xml

echo "Merge the two files:"
sort -u sme-nob.xml.tmp boadus.xml >> test.xml

echo "Add a correct footer:"
tail -2 smenob.xml >> test.xml

!rm dicat xmlat in_dic_butnot_in_xml boadus.txt boadus.xml smenob.xml.header-footerless sme-nob.xml.tmp
!mv test.xml smenob.xml
