This directory contains the following
 bin     -- 
 deliv   -- directories containing dictionaries compiled for different OSs
 dev     -- 
 inc     -- data to be included into the source files in the src directory
 scripts -- scripts and other resoures to transform data
 src     -- the dictionary files (split modulo POS)

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

Doubled entries are output as twins, for instance,
   <file name="nounCommon_smenob.xml">
      <entries>
         <counter total="14586"/>
         <twins>
            <lemma>alfabehta</lemma>
         </twins>
      </entries>
   </file>
the current version of the nounCommon file contains a doubled lemma.



--------------
Lenes notater:

(1) PrfPrc av copula mangla!! Den har jeg lagt til i det statiske paradigmet, under Prt paradigmet. Er det en ok plass?

(2) iige, inge osv er frekvente. Jeg har nå laget et Neg Foc/ge paradigme med entryer. Her må det legges til eksempler - kanskje en oppgave for Berit M?

(3) verb Der/n og Der/eapmi mangler Ess. Jeg har lagt til i verb-codes. Vi har bare med Sg, jeg tror at Pl også burde vært lagt til?

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

(18) check the files in the dir no_wordform_during_generation
     ... by the way, 'tunealla' vs. 'tunnealla' is, again, a case of lsub!

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



Et lite mysterium.... 

Jeg ble overraska over at dicten kan skanne ordet VEAHKAVÁLDIN skrevet med store bokstaver som to ord. Det er jo ikke ofte at ord er skrevet med store bokstaver, så det gir begrensa effekt for brukeren. Men jeg skjønner ikke hvorfor MacDict ikke da kan skanne SKUVLAVUODJIN som to ord?  Ingen stor sak, men et lite mysterium...

Test versions:
A test version of the latest source files is downloadable at
http://divvun.no/static_files/test-20110828-smenob-mac-dictionary.tgz



