This is a temporary directory for the work in progress at the dictinary generation and compilation.

Basically, @cip will put two different kind of lists here:
1. of lemmata that didn't get any form generated, not even the baseform
 Ex. siseanan
<result>
   <paradigm>
      <analysis ms="n_Sg_Nom">
         <wordform value="siseanan"/>
      </analysis>
   </paradigm>
   <e>
      <lg>
         <l pos="n">siseanan</l>
         <lemma_ref>siseanan</lemma_ref>
         <analysis>n_Sg_Nom</analysis>
      </lg>
   </e>
</result>

2. of lemmata that get only the baseform generated
 Ex. tunealla (uten å slå på v1-v2-mekanismus)
<result/>

There is no workable way to implement a routine with variable number of parameter
not even to know which lemmata get which v_n parameters.

To clarify with lingvisten. Moreover, the two different mechanisms hid and v1-v2
should be unified into a single implementable one. The description is counter-intuitive
and difficult to debug.


=============================================
Issues on the stack:

1. webdict update: this is not dependent on the generation, however
   there might be a tiny unbalance: the v2-v4 forms would not be
   visible (unless a native speaker codes them in the source file, no paradigm necessary)
 ==> DONE

=============================================
Issues for the smenob dict:

1. teste v1-v5 generering i hele pipeline
 ==> DONE

2. prepare the StarDict version of the smenob dict
 ==> TODO

3. filter away synonyms in the mg/tg elements as proposed by Lene (lower priority)
   - write a helping script for Trond (, whose task would be to mark those t-elements
     that should be filtered away for the smenob dict, but still kept in the dictionary
     for an eventual reversion to nobsme)
 ==> TODO

=============================================
Comments after the first test:

1. Miniparadigmer til substantiver uten allegro.
soaje	soadji+N+Sg+Gen+Allegro
soaji	soadji+N+Sg+Gen
+N+Sg+Gen+Allegro utelates fra miniparadigmer til substantiver. Bare vanlig gentiv presenteres i miniparadigmet til substantiver. Allegro skal være med som oppslagsform i ordboka.  
 
 ==> DONE 

3. Linking fungerer ikke i lemmaer med <te>, feks linken fra boaššobeale til boaššobealle er inaktiv.

 ==> dette fungerer når man inaktiverer andre ordbøker i dict-programmet og starter programmet på nytt. 
 ==> DONE 

4. Presentasjon av <te>: i smanob står alle <te> i kursiv. I smenob skal også alle <te> stå i kursiv.

 ==> DONE TODO for static

5. Fjerne komma (,) i slutten av hver <te>.
Alle <te> i smenob i dag slutter med en komma: boaššobealle: den side som vender mot boaššu, det vil si den innerste delen av telt, gamme eller hus,

 ==> DONE TODO for static

6. Use/NVD er ikke implementert: 
se feks lihkolaš i VD i dag:
komp. attr. lihkolit lihkolut lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkolit lihkolut lihkolet lihkoleabbo lihkolat lihkolabbo lihkolaččat 

Ved implementert Use/NVD skal resultatet være:
komp. attr. lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkoleabbo  lihkolabbo lihkolaččat

 ==> DONE (to test with these lemmata)

7. buresboahtin (check for other entries) og andre noun merket illpl="no" får dobbelt opp med analysetags i miniparadigmet, også pl. ill.
   sg. gen. sg. gen.
   sg. ill. sg. ill. 
 ==> TODO

8. correct mapping 
<analysis ms="Pron_Refl_Sg1_Acc/Gen">
 skal bli 1p. sg. akk./gen.

1p. sg.


iežan iehčan

 ==> TODO

9. En annen ting, bør det ikke komme fram i ordboka at Der/n og Der/eapmi  gir 'Aktio Sg. Akk'. osv. og ikke bare 'Sg Akk' som i forrige ordbok. 

En annen ting man bør se på, er hvorfor ikke verbene ikke får Actio-tag i flertall (derfor er det i verb-codes Der/n og Der/eapmi isteden), men det gjør vi etter at denne ordboka er generert. Det fungerer slik som det er nå.

 ==> TODO

10. plassering av l_ref: see email

 ==> TODO

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

