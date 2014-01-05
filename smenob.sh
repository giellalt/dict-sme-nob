
# Dette skal bli ei makefil for å lage smenob.fst, 
# ei fst-fil som tar sme og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.

# Kommando for å lage smenob.fst

# skriv
# sh smenob.sh 
# dvs kall dette skriptet
# detetter gjer skriptet dette:


echo "Etter at dette scriptet er ferdig står du i xfst med promt [1]"
echo "Gjör då dette:"
echo "invert"
echo "save bin/smenob.fst"

echo "LEXICON Root" > bin/smenob.lexc

cat  src/*_smenob.xml | \
tr '\n' '™' | sed 's/<e/£/g;'| tr '£' '\n'| \
sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f6,16| \
tr ' ' '_'| sed 's/:/%/g;'|tr '>' ':'| \
grep -v '__'| \
grep -v 'xml-stylesheet_alternate' | \
sed 's/$/ # ;/g' >> bin/smenob.lexc

xfst -e "read lexc < bin/smenob.lexc"



