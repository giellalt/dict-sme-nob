
# Dette skal bli ei makefil for å lage smenob.fst, 
# ei fst-fil som tar sme og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage smenob.fst

# sh smenob.sh 

echo 
echo "Etter at dette scriptet er ferdig står du i xfst med promten"
echo "xfst[1]"
echo 
echo "Gjör då dette:"
echo "invert"
echo "save bin/smenob.fst"
echo "quit"
echo ""
echo "LEXICON Root" > bin/smenob.lexc

cat  src/*_smenob.xml | \
egrep -v '<(lc|lsub|analysis)>' | \
egrep -v '<lemma_ref' | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'| \
grep -v 'xml-stylesheet_alternate' | \
sed 's/$/ # ;/g' >> bin/smenob.lexc

xfst -e "read lexc < bin/smenob.lexc"



