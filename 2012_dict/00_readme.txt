This is a temporary directory for the work in progress at the dictinary generation and compilation.

Basically, @cip will put two different kind of lists here:
1. of lemmata that didn't get any form generated, not even the baseform

2. of lemmata that get only the baseform generated

There is no workable way to implement a routine with variable number of parameter
not even to know which lemmata get which v_n parameters.

To clarify with lingvisten. Moreover, the two different mechanisms hid and v1-v2
should be unified into a single implementable one. The description is counter-intuitive
and difficult to debug.

=============================================
Issues for the smenob dict:

1. teste v1-v5 generering i hele pipeline

2. prepare the StarDict version of the smenob dict

3. filter away synonyms in the mg/tg elements as proposed by Lene (lower priority)
   - write a helping script for Trond (, whose task would be to mark those t-elements
     that should be filtered away for the smenob dict, but still kept in the dictionary
     for an eventual reversion to nobsme)
 ==> TODO for the next release!!!

=============================================
Comments after the first test:

1. Miniparadigmer til substantiver uten allegro.
soaje	soadji+N+Sg+Gen+Allegro
soaji	soadji+N+Sg+Gen
+N+Sg+Gen+Allegro utelates fra miniparadigmer til substantiver. Bare vanlig gentiv presenteres i miniparadigmet til substantiver. Allegro skal være med som oppslagsform i ordboka.  

3. Linking fungerer ikke i lemmaer med <te>, feks linken fra boaššobeale til boaššobealle er inaktiv.
 ==> dette fungerer når man inaktiverer andre ordbøker i dict-programmet og starter programmet på nytt. 

4. Presentasjon av <te>: i smanob står alle <te> i kursiv. I smenob skal også alle <te> stå i kursiv.

5. Fjerne komma (,) i slutten av hver <te>.
Alle <te> i smenob i dag slutter med en komma: boaššobealle: den side som vender mot boaššu, det vil si den innerste delen av telt, gamme eller hus,


6. Use/NVD er ikke implementert: 
se feks lihkolaš i VD i dag:
komp. attr. lihkolit lihkolut lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkolit lihkolut lihkolet lihkoleabbo lihkolat lihkolabbo lihkolaččat 

Ved implementert Use/NVD skal resultatet være:
komp. attr. lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkoleabbo  lihkolabbo lihkolaččat

7. buresboahtin (check for other entries) og andre noun merket illpl="no" får dobbelt opp med analysetags i miniparadigmet, også pl. ill.
   sg. gen. sg. gen.
   sg. ill. sg. ill. 

8. correct mapping 
<analysis ms="Pron_Refl_Sg1_Acc/Gen">
 skal bli 1p. sg. akk./gen.

1p. sg.

iežan iehčan


9. En annen ting, bør det ikke komme fram i ordboka at Der/n og Der/eapmi  gir 'Aktio Sg. Akk'. osv. og ikke bare 'Sg Akk' som i forrige ordbok. 

En annen ting man bør se på, er hvorfor ikke verbene ikke får Actio-tag i flertall (derfor er det i verb-codes Der/n og Der/eapmi isteden), men det gjør vi etter at denne ordboka er generert. Det fungerer slik som det er nå.

Lene:
det er muligens ikke helt som det burde være i fst
og verb-codes i forhold til det igjen
så vi vil ha det slik nå:
Der/n+N+Sg+Nom -> s. sg. nom 
Der/eapmi+N+Sg+Nom -> s. sg. nom
s = subst
Actio+Ess -> Aktio Ess
Actio+Ess -> aktio ess.
med små forbokstaver
slik som det er ellers
Der/n+N+Sg+Loc -> s. sg. lok.
osv
evt subst. istedenfor s.
dvs at du legger til subst.
leneantonsen
i tillegg til det som var før

addimin
verb → addit
å gi
Analyse: aktio ess.

addimen
verb → addit
å gi
Analyse: aktio ess.

addime
verb → addit
å gi
Analyse: aktio ess.

albmadeame
verb → albmadit
å melde til øvrigheten
Analyser: aktio ess. el. subst. ess.

=============

Der/PassL_V
test:
addojuvvot
verb → addit
å gi
Analyser: pass. inf., pass. indik. pres. 2p. sg. el. pass. indik. pres. 1p. pl.
=============

Der/PassS_V
Der/eapmi_N
Der/n_N


=============

10. plassering av l_ref: see email


11. lacking context infos (possibly because of the changed filter for vmax entries)

 Example: vissis
          attr. visses vissis
 
 before:
          attr. visses vissis (ášši)

12. få 'src' synlig til de eksemplene som har det. F.eks. bákteolmmoš

              <x src="S. B. Johansen 2010: Sárá beaivegirji s. 20-21.">Áhčči dadjá ahte ii sáhte goassege diehtit
              makkárat bákteolbmot leat, dat dáidet eallit váikko agálaččat.</x>
              <xt src="S. B. Johansen 2010: Saras dagbok s. 18.">Pappa sier at man kan aldri vite med sånne berg-folk,
              de lever kanskje evig.</xt>
              
 ==> TODO for the next release!!!

13. re-for eksempler???

adverb_smenob.xml: <xt>Ha det bra! (til den som blir igjen)</xt>
pronRel_smenob.xml: <tf pos="phrase">hvilken av de to (om flertallsord)</tf>

<xg re="til den som blir igjen">
    <x>Báze dearvan!</x>
    <xt>Ha det bra!</xt>
</xg>

14. Adjektiver - manglende informasjon om context, se også punkt 11
I VD 1.3 mangler alle adjektiver (feks dábálaš) informasjon om context.
De eneste adjektivene som har info om context er vmax-adjektiver (feks vissis, se punkt 11) 

Eksempel fra VD 1.3:
	dábálaš
	attr. dábálaš

Eksempel fra VD 1.2:
	dábálaš
	attr. dábálaš (bivttas)
	
	 ==> TODO for the next release!!!


=============================================
Some observations while testing before compiling:

1. Static files:
 - still quite a lot of inconsistencies as for additional information:
   similar information both as <re>-element and in the translation in brackets

Example 1:
<re>om flere</re>
<re>flertall</re>
	versus
<tf pos="phrase">hvilken av de to (om flertallsord)</tf>
<tf pos="phrase">til hvilken av de to (flertall)</tf>
<tf pos="phrase">til hva slags (flertall)</tf>
<tf pos="phrase">til hva (flertall)</tf>

Example 2:
<re>som nettopp er nevnt</re>
	versus
<tf pos="phrase">de (som nettopp er nevnt)</tf>

=============================================
Some observations after release VD 1.3:

1. Ordboksprogrammet lukkes når BM prøver å søke i VD 1.3. Å søke i VD 1.2, 1.1 går helt fint.
Info om maskin: MAC OS X Server, Version 10.5.8, processor: 4x2.5 Ghz PowerPC G5, Memory: 6.5 GB DDR2 SDRAM
 ==> debugging DONE

  recompile both smanob 1.2 and smenob 1.3 with old Mac-tools: the new dict-compiling tools are buggy!!!
 ==> TODO

==============
Notes on the way of generation:

1. src>grep 'eanadoalli' *
noun-sme-lex.txt:eanadoalli+v1+CmpN/SgN+CmpN/SgG+CmpN/PlG+Hum:eana#doalli¤ ACTOR ;

eanadoalli is marked as vmax but it gets only one form.

  <l illpl="ok" pos="actor" vmax="3">eanadoalli</l>
  <tg xml:lang="nob">
     <t decl="2" gen="m" pos="n">jordbruker</t>
  </tg>

Vmax is a kind of checksum for me that the generation went ok, that means
with eanadoalli this is not the case.

==> Feilen var i noun-sme-lex, har endret lemmaet til eanadoalli også for v2 og v3. Eanadoalli skal være vmax=3.

2. real doubling or just a pseudo-twin here?

   <file name="other_stat_smenob.xml">
      <entries>
         <counter total="221"/>
         <twins>
            <lemma>vuollai</lemma>
         </twins>
      </entries>
   </file>

  ==> Sjekket! Fjernet en dobbel entry. Vuollai er nå representert to ganger i fila, en gang som po og en gang som pr.

3. debugging paradigm generation:
testing>wc -l cips_dictwords.txt 
    9635 cips_dictwords.txt
testing>ls Gen_tmp/Para_tmp/ | wc -l
    9634

 ==> [mánáid-tv     n] got not paradim file. Why?

 Aha, derfor 

mánáid-TV+N+Sg+Nom
mánáid-TV

 Also: in dict source there are both
nounCommon_smenob.xml:         <l pos="n">mánáid-tv</l>
nounCommon_smenob.xml:         <l pos="n">mánáid-TV</l>

in lexfiles only one!

  ==> Fikset!  Jeg har merket mánáid-tv med vmax="2". Fikset i acro-sme-lex, mánáid-tv er v1 og lemmaet, mens mánáid-TV er v2.
