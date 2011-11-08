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
 ==> TODO (partly DONE)

2. prepare the StarDict version of the smenob dict
 ==> TODO

3. filter away synonyms in the mg/tg elements as proposed by Lene (lower priority)
   - write a helping script for Trond (, whose task would be to mark those t-elements
     that should be filtered away for the smenob dict, but still kept in the dictionary
     for an eventual reversion to nobsme)
 ==> TODO

=============================================
Comments after the first test:

From BM:

1. Soadji har to sg.gen-former: soaji, soaje. I Nøkkelformene i ordboka presenteres allegro formen først: soaje, soaji.
Kan vi ordne det slik at soaji presenteres før soaje? Dette gjelder alle lemmar som har to gen former.

 ==> vet ikke nå, kanskje.

2. 'Nøkkelformer' bør heller kalles 'Grammatikkinformasjon' siden vi av og til gir nøkkelformer, av og til bare attr-form, av og til alle former (statiske filer)

 ==> upp til dokker!

3. Linking fungerer ikke i lemmaer med <te>, feks linken fra boaššobeale til boaššobealle er inaktiv.

 ==> skal sjekke det!

4. Presentasjon av <te>: i smanob står alle <te> i kursiv, skal dette også gjøres i smenob? 

 ==> upp til dokker!

5. Fjerne komma (,) i slutten av hver <te>.
Alle <te> i smenob i dag slutter med en komma: boaššobealle: den side som vender mot boaššu, det vil si den innerste delen av telt, gamme eller hus,

 ==> skal sjekke deet!

6. Use/NVD er ikke implementert: 
se feks lihkolaš i VD i dag:
komp. attr. lihkolit lihkolut lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkolit lihkolut lihkolet lihkoleabbo lihkolat lihkolabbo lihkolaččat 

Ved implementert Use/NVD skal resultatet være:
komp. attr. lihkolet lihkolat lihkolaččat
komp. sg. nom. lihkoleabbo  lihkolabbo lihkolaččat

 ==> Jeg har ventet på et slikt eksempel!

From Lene:
Jeg foreslår at vi utelater soaje fra miniparadigmet (vi utelot allegro-formene tidligere også, se tidligere ordbokskompileringer, bortsett fra den siste som ikke inneholdt Allegro-former overhodet)

soaje	soadji+N+Sg+Gen+Allegro
soaji	soadji+N+Sg+Gen

pga Allegro-tagen er den lett å filtrere bort, men det kan hende at Ciprian har noe annet i pipe-linen, fordi jeg mener å huske at han fikk til å filtrere dem bort fra miniparadigmet allerede _før_ jeg hadde lagt til Allegro-tagen.

Men Allegro skal være med i ordboka.

From Trond:


Kan vi ordne det slik at soaji presenteres før soaje? Dette gjelder alle lemmar som har to gen former.
Ja, allegro først er ikkje så bra. Det er betre utan allegro enn med allegro først... Miniparadigmer utan allegro (men sjølvsagt allegro i ordboka, med peikar til nominativ), er mitt syn. 

 ==> uten Allegro-former er letter å implementere (skal se på det)
 
Eg ser no Cip sitt siste brev. Altså:

Allegroformene skal vere oppslagsformer __i ordboka__.
Men __i miniparadigmet__ som er knytt til lemma-artikkelen skal vi ikkje ha allegroformer, berre vanleg genitiv.

 ==> nå er det klar!

2. 'Nøkkelformer' bør heller kalles 'Grammatikkinformasjon' siden vi av og til gir nøkkelformer, av og til bare attr-form, av og til alle former (statiske filer)

"Grammatikkinformasjon" er veldig langt, og eigentleg misvisande. Eg går for "Bøyingsformer" eller evt. held vi på "Nøkkelformer" (ulike nøklar til ulike dører). Så eg er eigentleg for "Nøkkelformer", kjenner eg.

 ==> Schlüssel-Schloss-Prinzip wie bei den Proteinen (like greit for meg)

3. Linking fungerer ikke i lemmaer med <te>, feks linken fra boaššobeale til boaššobealle er inaktiv.
aha, derfor er det! Eg har også sett former utan linking.

4. Presentasjon av <te>: i smanob står alle <te> i kursiv, skal dette også gjøres i smenob? 
Ja, syns eg.

 ==> ok!

5. buresboahtin (check for other entries)
   sg. gen. sg. gen.
   sg. ill. sg. ill. 
 ==> TODO

6. correct mapping 
<analysis ms="Pron_Refl_Sg1_Acc/Gen">
 skal bli 1p. sg. akk./gen.

1p. sg.


iežan iehčan

=============================================
