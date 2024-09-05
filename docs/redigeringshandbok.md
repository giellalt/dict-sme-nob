Redigerengiehtagirji
====================

VIKTIG:

- Perfectionism is a killer, godt nok er godt nok. 
- Noen ganger gjør man suboptimale valg, det må man leve med. (Se punkt 1)
- Feir milepæler: antall ord, ferdige bokstaver, publiseringer etc.

Skriv ned her etter kvart.

# TEKNISK

# Brukergrensesnitt (css)

- Nummerer mg-ar, ikkje berre kulepunkt
- Luft mellom mg-ane
- Problem: nobsme "gi"
- det går ikkje fram at det er mange mg-ar

# Genering av flere ordbøker fra samme kildekode
Fra samme kildekode kan vi generere forskjellige ordbøker:

Tospråklige: Samisk-norsk (samisk-finsk)
Samisk definisjonsordbok
Samisk definisjonsordbok med norske (finske) oversettelser



# Redigering i XMLmind
## (Windows)
Navigering i det treet:
-     ctrl+↑ og ctrl+↓
- ctrl+J (etter)
- ctrl+H (før)

Legg til dg (definisjon) og xg (eksempel)

Husk å velge pos og xml:lang

Synonymer legges til i sg, antonymer i antg



# REDAKSJONSSPRÅK
Hvor puristisk skal ordboken være? 
F.eks: Kan amas fungere som subjunksjon (amas eai bora), eller skal vi holde på at det er nektende supinum (amasat borrat)?

**Konklusjon:**
Ordboken har vestlige former i definisjoner og eksempelsetninger. 
t.d. aktio essiv *-me*
Lemma kan være alle dialektformer.
Vi har litt konservativt språk i eksemplene

# KILDE
Kan være lurt å legge til info om hvor man har funnet en oversettelse, definisjon, etc, spesielt hvis man er litt usikker. Legges til under source, f.eks. etternavn + årstall på utgivelse.


# LEMMA

# Lemmautvalg
Gruppering? (slik at en ikke trenger logge hvert enkelt ord)

SME-> NOB viser bare den vanligste varianten (= lemma) slik som det er nå.

**Konklusjon:**
Ulike variantformer i samme oppslag,i SME feks
universitehta (subst.), universiteahtta (subst.) i samme oppslag. Legges inn som variant av lemma, med vN for å kunnne gi riktig bøysningsparadigme. v1 er default for lemma. Dvs at v1 er optional i genereringa, mens v2 osv er obligatoriske.

    <lg>
      <l pos="N">universitehta</l>
      <l var="v2" pos="N">universiteahtta</l>
    </lg>


# "Uheldige" ord


## Feil bruk av ord?
i ordbøkene oversatt som manus/manuskript, til forskjell fra giehtačála (håndskrift).
Men det er mange eksempler i korpus der det er brukt med betydninga håndskrift.


giehtačálus / giehtačála

for giehtačálus

1. definisjon av tydinga "manuskript"
2. (no og då brukt i tydinga "handskrift" -- definisjon) Geavat baicce giehtačála


Admin:
Olgešspálttas gávnnat skoviid maid sáhtát čállit olggus ja deavdit giehtačállosiin dehe deavdit njuolga dihtoris .
geavahit bustávaid ja geahččaladdat sániiguin , iežas giehtačállosiin ja dihtoriin
Oahppit sáhttet čállit fáttá birra juogo giehtačállosiin dahje dihtorii .
Čállit iešguđetlágan teavsttaid giehtačállosiin ja dihtoriin
sáhttá ávžžuhit jearahallama čađahit almmá atnit giehtačállosa veahkkin .

Non fiction:
Lea muhtumin leamaš váttis dulkot giehtačállosa, ja danin eat leat nagodan bájuhit visot ollásit .
čállit sániid dahje álkes teavstta govaide giehtačálusin dahje tastaturan

fiction: 
Mu šliettihan gieđat vuoiŋŋastedje giehtačállosa alde ja jorgaledje ain gulul dego niegus siiddu .
Lea got oaidnán ahte ii lean eatni giehtačálus?

news:
Giehtačálus reivves lea maid hui fiinnis .
De maid garvit dan ahte namat čállojit boastut go lea váttis ipmirdit giehtačállosa, ja dat dáhpáhuvva dávja .
Čáppa giehtačállosiin, fiidnámus reivebáhpiriin , son ovdanbuktá sávaldagaidis iešguđetlágan olbmuide .

**Konklusjon:**
For å markere at et ord er "uheldig": 
- element l_pref (lemma_preferred) som dukker opp i grensesnittet om 'geavat baicce' (= bruk heller)



# Avledninger

**Konklusjon:**
Vi gir informsjon om at lemma er en avledning slik i lemmagroup lg:
       <orig>borrat + suorggis -dit</orig>   (med lenke)

# Idiomatisk uttrykk og ordtak
## Ord og uttrykk som har idiomatiske versjoner på begge steder
Ordtak og idiomatisk uttryk bør stå på begge språk med den idiomatiske versjonen, td.
grav (subst.) = (subst.) hávdi

(i bibeloversetting, egentlig grop) (subst.) *roggi*
**Konklusjon:**
Her er det problemer med md-formatteringa:
      <ig>
      <i>Dat gii goaivu rokki, gahččá ieš dasa.</i>
      <id>definišuvdna...</id>
      <td>Den som graver en grav, faller selv i den.</td> 
      </ig>

## Ord og uttrykk som bare finnes i et språk

OBS: Dette må vi beskrive...

# Språklig variasjon i lemma og betydning

**Konklusjon:**
Vi bruker to parametre, som attributter:
- Dialektvariasjon (østlig, vestlig, tornesamisk, sjøsamisk)
- Variasjon mellom ulike administrative organisasjoner (land Norge, Sverige, Finland)

Vi må bli enige om attributtene


# Tallord-artikler
- čieža = vuođđolohku 7; sju
- Diibmu lea čieža. = Klokka er sju.
- osb.
- Eksempel med alder, klokke og liknende

# Referere til andre ord
For eksempel jamfør og til forskjell fra... på norsk, 

På samisk geahča eller gč., evt.jamfør = vrd. + komitatiiva (= veardádala)

Eller legge til i l_ref?

mii earuha + LOK (til forskjell fra) ??
evt. mii fas earuha + AKK + LOK

Eks: 
.. mii fas earuha giehtasealggi giehtaváimmus

motsatt...f.eks. høyre/venstre - nuppegežiid?

som forledd/etterledd (mearusoassi/vuođđooassi) i ord som ... 





# DEFINISJONER

**Konklusjon:**
Realdefinisjon + eventuelle synonym
- Unngå 2.person i definisjonene
- Unngå skråstrek 

## parentes
har bestemte roller for å framheve strukturen (f.eks. i re)
kan bruke parentes i definisjoner, f.eks:
*(njealječiegat) breahtta dahje pláhta mii geavahuvvo lávdespeallamii*

# EKSEMPELSETNINGER

## Formelt
**Konklusjon:**
- Fullstendige setninger starter med stor bokstav, avsluttes med tegnsetting (punktum, spørretegn)
- Ufullstendige setninger med liten bokstav, uten tegnsetting
- unngå parentes i eksempelsetninger
- Eksempelsetningene bør være selvstendige setninger, ikke peke til noe utenfor setningen.
F.eks.: *De álggii nieida vuoiddadit. => Nieida álggii vuoiddadit.*


## Språkleg
**Konklusjon:**
- Gjerne autentiske, men de bør kuttes ned, fjerne 'støy' i setninga
- Første eksempelsetning bør være typisk bruk av ordet
- Vis reksjon, bruk substantiv for å vise kasusbruk
- Bruk generiske substantiv (gutten, dama...) og pronomen, ikkje eigennamn
- Bør være nøytrale: Unngå stedsnavn, religion, visse grupper - stigmatisering, stereotyper, etc
- for man/en: bruk f.eks. *olmmoš, dievdoolmmoš, nissonolmmoš*

# FLERE BETYDNINGER (mg)

## I hvilken rekkefølge skal ulike betydninger være?  

**Konklusjon:**
Etter semantikk, grunnbetydninga først, med mindre den er misvisende for brukeren

# OVERSETTINGER


## Hvor idiomatiske skal oversettelsene være?

*Son guovlala giikkáriin oidnojit go lottit.* Hvordan oversette? 

- Hun ser i kikkerten om det er fugler å se. - idiomatisk oversettelse
- Hun ser i kikkerten om fuglene er synlige - nær samiske setning 
- Hun ser i kikkerten om fuglene vises. - nær samiske setning

Duorastaga dievai kulturviessu maŋimuš stullui. 
- På torsdag var det ikke et ledig sete i kulturhuset.
- På torsdag fyltes kulturhuset til siste sete.

**Konklusjon:**

- I samisk-norsk ordbok bør nob-oversettelsen være nært den samiske setninga, men likevel fungere på norsk.
- Vi bør ha noen til å korrekturlese den norske oversettelsen.


## juhkaluvvat: 

leahkit alkohola váikkuhusa vuolde? (påvirket?)
**Konklusjon:**
bra



## idiomer?: 
- áddjá, eadni, jna.
- eadni: eatnibellodat, eatniorganisašuvdna,

**Konklusjon:**
(hvis produktivt): brukt som forledd..., pluss eks

áddjá: guovža (buddosnamma - tabuord)
**Konklusjon:**
    áddjá: guovža som egen <mg>

# SLEKTSKAPSTERMER


##  vilbealle, oambealle: vuosttaš, nubbi, goalmmát – hvor skal disse forklaringene legges? 

ig? xg?



sivjjot (svigerinne): eamida oabbá (= konas søster)
(jus lea dievdu) vielja eamit (= (og hvis man er mann) brorens kone)

Naba oappá eamit? mo dalle? (= hva med søsters kone? bruker man samme ord da?)

**Konklusjon:**
må spørre noen som vet

máhka, spile....

## Kjønnsspesifikke eller -uspesifikke termer

- eatni dahje áhči - váhnema?
- eamida dahje isida - beallelačča/náittosguoimmi/eallinguoimmi?

**Konklusjon:**
váhnen og eallinguoibmi

## DIVERSE NOTATER, bør redigeres eller fjernes
Ášši lea čielggas, vrd. (veardit) sámedikki dieđáhusain.</x>
Alimusriekti juohkásii eanetlohkun ja unnitlohkun (9–6).</x>

Dan gal lean vajálduhttán.
Det har jeg (virkelig) glemt.


čuohtenáre - virker som det er brukt både om "ca 100" og "hundrevis", men ca. 100 ser ut til å være den primære bruken

Jiehkit, uđđasat ja eará geologalaš proseassat leat čuohtenáre duháhiid jagiid mielde hábmen eanadaga.
Ealli guollebivdohápman čuohtenáre jagiid
Biedjovákkeguovllus ledje gottit duháhiid jagiid ja (lojes) bohccot fas leat leamašan čuohtenáre jagiid.
Eará videoid, maid Evelina láve juohkit, leat sullii čuohtenáre olbmo geahččan,
Vuosttaš logenáre jagiid geavahedje dáid dietnasiid eanaš dađistaga jahkásaš






