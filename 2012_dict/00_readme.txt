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
+N+Sg+Gen+Allegro utelates fra miniparadigmer til substantiver. Bare
vanlig gentiv presenteres i miniparadigmet til substantiver.
Allegro skal være med som oppslagsform i ordboka.  

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
Some observations after first version of VD 1.4- 14. august 2012:

Generated VD:
SUBSTANTIVER:
1. Nøkkelformer substantiver - bare vanlig genetiv presenteres:
 ==> DONE

2.Linking fungerer ikke i lemmaer med <te>, feks linken fra boaššobeale (Sg Gen/Sg/Akk) til boaššobealle (Sg Nom) er inaktiv.
 ==> DONE

3. Linking til lemmaet fungerer ikke for bla følgende former:
 ==> DONE

ADJEKTIVER
4. Use/NVD er ikke implementert når det gjelder nøkkelformer for adjektiver: 
 ==> DONE

5. lacking context infos for adj attr  and num in nøkkelformer:
 ==> DONE

6. Linking tilbake til lemma fungerer ikke:
 ==> DONE

VERB
7. Use/NVD er ikke implementert når det gjelder nøkkelformer for verb
 ==> DONE

L_REF
8. plassering av l_ref: 
Informasjon om l_ref mangler fullstendig, og er presentert som en tom linje.
==> DONE

SRC:
9. få 'src' synlig til de eksemplene som har det. F.eks. bákteolmmoš

              <x src="S. B. Johansen 2010: Sárá beaivegirji s. 20-21.">Áhčči dadjá ahte ii sáhte goassege diehtit
              makkárat bákteolbmot leat, dat dáidet eallit váikko agálaččat.</x>
              <xt src="S. B. Johansen 2010: Saras dagbok s. 18.">Pappa sier at man kan aldri vite med sånne berg-folk,
              de lever kanskje evig.</xt>
              
==> Er ikke implementert.

VMAX-dict test results (next time, please use this document):

1. det eneste er at lsub millijuvdna fungerer ikke
 (men lsub miljun fungerer)
 ==> DONE

2. vmax-greie: lemma mihkkege: mihkke er ikke kommet med
 ==> Cip tested both with the previous and the current version of the dict-isme-norm.fst:
     there is no mihkke-form in the paradime file.



KOMMENTARER til MWE_VD 24.8.2012:

1. Nøkkelformene er OK

2. lemmaene fra mweNoun_smenob (dvs 4 lemmaer: eatni guovttos, luntta guovttos, váhnen guovttos, vieljaš guovttos): kun singularis former i ordboka. Pluralis-formene må tas bort. 
__cip__: Jeg antar at du mener i nøkkelformer, ikke i ordboka som oppslagsord.
 ==> done (manually for now) 
Not only in miniparadigm, all forms plural of the 'guovttos'-lemmata should be removed!


3. lemmaene fra mweNoun_smenob (dvs 4 lemmaer: eatni guovttos, luntta guovttos, váhnen guovttos, vieljaš guovttos): er merket som uttrykk. Kan de merkes som substantiv?
 ==> done (how nice is to follow cip's advice for marking mwe with 'phrase_POS') 

4. lemmaene fra mweProper (3 lemmaer: Ipmil Áhčči, Stuorra Británnia og Sámisoga lávlla): skal ha alle singularis formene i ordboka. Kommitativ Sg og essiv må legges til som oppslagsord.
 ==> done and tested 

5. lemmaene fra mweProper (3 lemmaer: Ipmil Áhčči, Stuorra Británnia og Sámisoga lávlla): er merket som uttrykk. Kan de merkes som egennavn?
 ==> done (how nice is to follow cip's advice for marking mwe with 'phrase_POS') 

Static files:
 change pos label from uttrykk til adv/etc.
 ==> todo

VMAX
1. guovttis substantiv (merket illpl="no") får dobbelt opp i nøkkelformene:
Nøkkelformer:	
sg. gen.			guoktá
sg. gen.			guoktá
sg. ill.			guoktái
sg. ill.			guoktái

Andre vmax merket med illpl="no" får ikke dette:
Nøkkelformer:	
sg. gen.			ođđajagemánu
sg. ill.			ođđajagemánnui
 ==> done (the cause is the Coll flag in the generation which
     generates exactly the same forms as the normal ones)

2. miljovdna (numeral) mangler context
pl. gen.			miljovnnaid
 ==> done

Generated:
1.
I nounCommon-fila har vi
<e usage="vd">
     <lg>
        <l illpl="no" pos="n">buresboahtin</l>
     </lg>
     <mg>
        <tg xml:lang="nob">
           <t decl="1" gen="n" pos="n">velkommen</t>
        </tg>
     </mg>
  </e>

Kanskje vi burde linke mellom, slik som  vi har gjort mellom vai og dahje ?

<l_ref>vai_cc</l_ref>

 ==> todo

