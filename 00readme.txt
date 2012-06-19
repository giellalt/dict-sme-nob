This directory contains the following
 bin     -- 
 deliv   -- directories containing dictionaries compiled for different OSs
 dev     -- 
 inc     -- data to be included into the source files in the src directory
 scripts -- scripts and other resoures to transform data
 src     -- the dictionary files (split modulo POS)
 2011_dict -- directory for the work in progress on the planed dictionary compilation
              (lists of lemmata without paradigm generation, or with only one form, etc.)

-------

How to check whether words are in the dict:

write:

make -f make-smedict
 eller (med parameter)
# make -f make-smedict smedict.fst
# make -f make-smedict vddict.fst
# make -f make-smedict nonvddict.fst

(if the computer complains, ask Ciprian or Börre for help).

in order to check whether a list of words list.txt is in smenob-dict, do this:

cat list.txt | lookup bin/smedict.fst | grep '?'

All words marked with ? are missing in the smenob dictionary.


How to check for doubled entries?

from smenob dir go one up to the dicts dir and call the following script
java -Xmx2048m net.sf.saxon.Transform -it main scripts/check_dict_entry.xsl inDir=../smenob/src

Doubled entries are output as twins, for instance, in an output file named "test-results.xml"

   <file name="nounCommon_smenob.xml">
      <entries>
         <counter total="14586"/>
         <twins>
            <lemma>alfabehta</lemma>
         </twins>
      </entries>
   </file>
the current version of the nounCommon file contains a doubled lemma.

-------
Some other useful commandos

a. Is a word in fst?
cat inc/inc_cabbamus_iditguovssu.txt | usmeNorm | grep '?' | cut -f1 | sort

b. Is a word non-lexicalized?
cat inc/inc_cabbamus_iditguovssu.txt | usmeNorm | egrep '\+.*#.*\+'

c. Is a word lexicalized?
cat inc/inc_cabbamus_iditguovssu.txt | usmeNorm | egrep '#' | egrep -v '\+.*#.*\+' | less



--------------
Lenes notater:

(1) PrfPrc av copula mangla!! Den har jeg lagt til i det statiske paradigmet, under Prt paradigmet. Er det en ok plass? ok
   ==> done

(2) iige, inge osv er frekvente. Jeg har nå laget et Neg Foc/ge paradigme med entryer. Her må det legges til eksempler - kanskje en oppgave for Berit M?
   ==> done

(3) verb Der/n og Der/eapmi mangler Ess. Jeg har lagt til i verb-codes. Vi har bare med Sg, jeg tror at Pl også burde vært lagt til?
   ==> done

(4) "irreal" som presentasjonstag i dict for potensialis er ikke så høvelig -> "pot" er bedre
   ==> done
(5)  "ess" som presentasjonstag i dict for actio essiv er ikke så høvelig -> "aktio ess" er bedre
   ==> done
(6) Mange prop har flere meaninggroup, og det er den første som brukes som oversettelse i miniparadigmet. Det gjør at jeg bør gå gjennom denne fila og endre på rekkefølgen på noen av dem da det mest frekvente bør være med i oversettelsen. Eksempler på dette er Báhccavuotna, Romsa

(7) passiv:
- Presentasjonstag mangler - det må komme fram at det er passivform av lemmaet 
- jeg ser nå at det er fare for overgenerering. Kan vi stoppe den i genereringa (f.eks. merke de verbene som skal ha passiv i leksikonet, eller ville vi få et bra resultat ved å generere passive former bare av transitive verb?)? Eksempel på overgenering er "divvojuvvon" som peker på to verb: divvut (ok) og dievvat (ikke ok)
   ==> done
(8) ved å sjekke mot Ávvir, så blir man voldsomt inspirert til å legge til nye lemmaer/former :-)
I tillegg til det som er nevnt under punkt 1-3, er det her eksempler på lemmaer som bør legges til:
- geardde, reastaluvvat, álbmotrávdnji, veahkaváldin, suorggahahtti, eastadanbargu, bealis Po
   ==> done, unntatt álbmotrávdnji and veahkaváldin (veahkaváldi is in VD)

(9) adjektiver: i miniparadigmet skal være med et substantiv (context) for attributtformen, f.eks. fiskes (bivttas).
Substantiveet er ikke med i denne versjonen.
   ==> done
(10) numeraler: også her mangler subtantivet, f.eks. guovttit (gápmagat) guvttiid (gápmagiid)
   ==> done
(11) vuovdi vs. vuovdi Actor
Her har vuovdi Actor fått riktig bøyningsparadigme, men ikke vuovdi som ikke er Actor. Dette gjelder ogs dikšu, lohkki osv
   ==> tested: obviously an fst issue which now has beed corrected by Trond and Lene (Takk!)
   ==> done
(12) Informasjon om geografisk område (reg) mangler på stedsnavn.
   ==> done
(13) as reported by Lene, kantuvra-like sub-forms do not show up in the compiled dict
   ==> done
(14) go-spørrepartikel til noe ordformer: Ind, Cond og Pot

(15) add 'å' to the infinitive forms of the Norwegian verbs (ongoing)

(16) adapt scripts to account for the src-attribute in the example groups

(17) improve disjunction instances in smanob: 'han eller hun', xxx/yyy', etc.
   ==> done in smenob

(18) check the files in the dir no_wordform_during_generation
     ... by the way, 'tunealla' vs. 'tunnealla' is, again, a case of lsub!
    ==> done

(19) just to be sure: there are 9 entries in the static files that don't have the vd-flag.
     why I am mentioning it? it is weird to have entries with big examples but that are not
     used in vd. Just check whether it is ok so.

s_src>grep '<e>' *.xml | wc -l 
       9
s_src>grep '<e>' *.xml 
adverb_smenob.xml:   <e>
adverb_smenob.xml:   <e>
adverb_smenob.xml:   <e>
adverb_smenob.xml:   <e>
adverb_smenob.xml:   <e>
adverb_smenob.xml:   <e>
other_stat_smenob.xml:   <e>
other_stat_smenob.xml:   <e>
other_stat_smenob.xml:   <e>

   ==> done adverbs, not other_stat_smenob.

(20) systematic check and content normalizing of te vs. re elements (but not only),
     such as 
     <te>som nettopp er nevnt</te> vs. <te>som nettopp ble nevnt</te>
     <re>om oss</re> vs. <re>om oss to</re> (if 'om oss' means 'om oss (mer enn to)' it should be clear, othewise is not consistent with 'om oss to')


(21) systematic check of punctuation in content elements, for instance:
     <te>ca. 2 år gammel</te> vs. <re>ca 4-10 stk</re>

(22) systematic check of pointers in the static files, e.g., by means of the script check_static_files.xsl
    for example, in div_statisk_smenob, the lemma "mii nu" points to 6 word forms (out="6") but the pointers from
    the word forms are not correct (in="0")

   <file name="div_statisk_smenob.xml" ls="4" ws="21">
      <ls>
         <l str="mii nu" id="mii nu_indef" out="6" in="0"/>
         <l str="oktage" id="oktage_num" out="5" in="0"/>
         <l str="vaikko mii" id="vaikko mii_indef" out="6" in="0"/>
         <l str="gii nu" id="gii nu_indef" out="6" in="0"/>
      </ls>

(23) prop_smenob.xml 
skal unifiseres, dvs at oversettelsen av dubletter legges som  <mg> under lemmaet.
Formatet skal endres - jeg foreslår slik
 
      fra      <tf pos="phrase">Storbukta (Kvalsund) (SK)</tf> skal endres til
      til      <t pos="prop" src="sk" type="plc" reg="Kvalsund">Storbukta</t>
      pga av scope for src-attributten


(24) nounRevProper_smenob.xml
Entryene i skal ha samme format som under (23), dvs at src-attributten flyttes fra <e> til <t>-elementet

(25)
prop_smenob.xml og nounRevProper_smenob.xml slås sammen til ei fil, med navnet nounProper_smenob.xml. Dubletter fjernes.  I denne fila vil en del av entryene ha usage="vd", men langt fra alle.

(26)
nounProperPl_smenob.xml skal også ha samme format som nevnt i (23)


===========
Test phase:
===========
1. the dtd do not contain decl="m"/"n" ==> please correct

src>grep '<t ' adjective_smenob.xml | grep 'decl="m"'
            <t decl="m" pos="n">hykler</t>
            <t decl="m" pos="n">fullmåne</t>
            <t decl="m" pos="n">stedfortreder</t>
            <t decl="m" pos="a">fiendtlig</t>

src>grep '<t ' adjective_smenob.xml | grep 'decl="n"'
            <t decl="n" pos="n">kaldvær</t>

2. there is no context attribute for the elements t/tf ==> to correct

  <e usage="vd">
     <lg>
        <l pos="a">ruđalaš</l>
     </lg>
     <mg>
        <tg>
           <t context="veahkki" pos="a">finansiell</t>
           <xg>
              <x>Mis eai leat ruđalaš eaige olmmošlaš návccat dien bargui.</x>
              <xt>Vi har hverken økonomiske eller menneskelige ressurser til det arbeidet.</xt>
           </xg>
        </tg>
     </mg>
     <mg>
        <tg>
           <t context="olmmoš" pos="a">rik</t>
        </tg>
     </mg>
  </e>

src>grep '<t' adjective_smenob.xml | grep context 
            <t context="veahkki" pos="a">finansiell</t>
            <t context="olmmoš" pos="a">rik</t>
            <t context="láhtten" pos="a">høflig</t>
            <t context="návccat" pos="a">menneskelig</t>
            <t context="olmmoš" pos="a">herskesyk</t>

==> done in smenob   


3. check and correct all te-elements in the whole smenob

src>grep '<te' *.xml | cut -d ':' -f1  | sort | uniq -c | sort -nr 
  30 nounCommon_smenob.xml
  23 pronDem_smenob.xml
   5 verb_smenob.xml
   1 nounG3_smenob.xml
   
==> done in smenob   

4. data that have to get into the src files:
   inc/candidates/inc_skuvlalemmas.txt
   
==> done in smenob   




Et lite mysterium.... 

Jeg ble overraska over at dicten kan skanne ordet VEAHKAVÁLDIN skrevet med store bokstaver som to ord. Det er jo ikke ofte at ord er skrevet med store bokstaver, så det gir begrensa effekt for brukeren. Men jeg skjønner ikke hvorfor MacDict ikke da kan skanne SKUVLAVUODJIN som to ord?  Ingen stor sak, men et lite mysterium...

Test versions:
A test version of the latest source files is downloadable at
http://divvun.no/static_files/test-20110828-smenob-mac-dictionary.tgz

TODO (14.06.2012): 

1. feedback fra Sjur: pos inconsistencies (verb vs. subst.)

bargama
verb → bargat
1. å arbeide; å gjøre
Analyser: subst. sg. gen. el. subst. sg. akk.

2. reminder from BM: manglende kontekst for adj attr former
slik er det i dag:

fiinnis
 attr. fiinna
 
slik skal det være når konteksten er med: 

fiinnis
 attr. fiinna (bivttas)

 - to check whether vmax-forms get the context right (BM):
Adjektiver med vmax får kontekst for attributt-formen på riktig måte i dagens versjon, feks:

erenoamáš
 attr. erenoamáš (dáhpáhus)
 
vissis
 attr. vissis (ášši)
 
 
 - to check for other pos (BM)
for verb_smenob er kontekst kommet med i siste utgave av VD
for num_smenob mangler kontekst i siste utgave: kontekst skal knyttes til pl.nom slik at det blir:
okta
 pl. nom. ovttat (gápmagat)
 





