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

(if the computer complains, ask Ciprian or Börre for help).

in order to check whether a list of words list.txt is in smenob-dict, do this:

cat list.txt | lookup bin/smedict.fst | grep '?'

All words marked with ? are missing in the smenob dictionary.


--------------
Lenes notater:

1) PrfPrc av copula mangla!! Den har jeg lagt til i det statiske paradigmet, under Prt paradigmet. Er det en ok plass?

2) iige, inge osv er frekvente. Jeg har nå laget et Neg Foc/ge paradigme med entryer. Her må det legges til eksempler - kanskje en oppgave for Berit M?

3) verb Der/n og Der/eapmi mangler Ess. Jeg har lagt til i verb-codes. Vi har bare med Sg, jeg tror at Pl også burde vært lagt til?

4) "irreal" som presentasjonstag i dict for potensialis er ikke så høvelig -> "pot" er bedre
   ==> done
5)  "ess" som presentasjonstag i dict for actio essiv er ikke så høvelig -> "aktio ess" er bedre
   ==> done
6) Mange prop har flere meaninggroup, og det er den første som brukes som oversettelse i miniparadigmet. Det gjør at jeg bør gå gjennom denne fila og endre på rekkefølgen på noen av dem da det mest frekvente bør være med i oversettelsen. Eksempler på dette er Báhccavuotna, Romsa

7) passiv:
- Presentasjonstag mangler - det må komme fram at det er passivform av lemmaet 
- jeg ser nå at det er fare for overgenerering. Kan vi stoppe den i genereringa (f.eks. merke de verbene som skal ha passiv i leksikonet, eller ville vi få et bra resultat ved å generere passive former bare av transitive verb?)? Eksempel på overgenering er "divvojuvvon" som peker på to verb: divvut (ok) og dievvat (ikke ok)


8) ved å sjekke mot Ávvir, så blir man voldsomt inspirert til å legge til nye lemmaer/former :-)
I tillegg til det som er nevnt under punkt 1-3, er det her eksempler på lemmaer som bør legges til:
- geardde, reastaluvvat, álbmotrávdnji, veahkaváldin, suorggahahtti, eastadanbargu, bealis Po

9) adjektiver: i miniparadigmet skal være med et substantiv (context) for attributtformen, f.eks. fiskes (bivttas).
Substantiveet er ikke med i denne versjonen.
   ==> done
10) numeraler: også her mangler subtantivet, f.eks. guovttit (gápmagat) guvttiid (gápmagiid)
   ==> done
11) vuovdi vs vuovdi Actor
Her har vuovdi Actor fått riktig bøyningsparadigme, men ikke vuovdi som ikke er Actor. Dette gjelder ogs dikšu, lohkki osv
   ==> tested: obviously an fst issue which now has beed corrected by Trond and Lene (Takk!)
12) Informasjon om geografisk område (reg) mangler på stedsnavn.
   ==> done
13) as reported by Lene, kantuvra-like sub-forms do not show up in the compiled dict

14) go-spørrepartikel til noe ordformer

Et lite mysterium.... 

Jeg ble overraska over at dicten kan skanne ordet VEAHKAVÁLDIN skrevet med store bokstaver som to ord. Det er jo ikke ofte at ord er skrevet med store bokstaver, så det gir begrensa effekt for brukeren. Men jeg skjønner ikke hvorfor MacDict ikke da kan skanne SKUVLAVUODJIN som to ord?  Ingen stor sak, men et lite mysterium...

Wow, this is quite a lot! Why, folk, why?
no_paradigm_generation>wc -l missing_paradigm_n.txt 
      16 missing_paradigm_n.txt


