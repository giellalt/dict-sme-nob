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
Issues from the smenob dict meeting:

1. teste v1-v5 generering i hele pipeline
 ==> TODO (partly DONE)

2. teste Use/NVD
 ==> DONE

3. posisjon i miniparadigm
*** Nøkkelformer:
*** attr. stuora stuorra (viessu)
*** pl.nom. stuorrát
*** KOMP.ATTR. stuorit stuorát
*** komp.sg.nom. stuorit stuorát
*** superl.sg.nom. Stuorimus
** generere alt
 ==> DONE

4. compile a three-parted test version of the dict by Monday 07.11.2011:
   - a version with only the vmax-marked lemmata
  ==> TO DO

   - a version with only the static entries, i.e., entries from the following files
adjstatpar_smenob.xml
adverb_smenob.xml
div_statisk_smenob.xml
mwe_smenob.xml
other_stat_smenob.xml
pronDem_smenob.xml
pronPers_smenob.xml
pronRec_smenob.xml
pronRefl_smenob.xml
pronRel_smenob.xml
verbCop_smenob.xml
verbNeg_smenob.xml
verbSupNeg_smenob.xml
  ==> DONE

   - a versjon with only the entries (lemmata AND wordforms, if the case) from the following files
     (under exclusion of vmax-marked entries)
adjective_smenob.xml
nounActor_smenob.xml
nounCommon_smenob.xml
nounG3_smenob.xml
nounProperPl_smenob.xml
nounRevProper_smenob.xml
num_smenob.xml
pronIndef_smenob.xml
verb_smenob.xml
  ==> DONE

5. prepare the StarDict version of the smenob dict
 ==> TO DO

6. filter away synonyms in the mg/tg elements as proposed by Lene (lower priority)
   - write a helping script for Trond (, whose task would be to mark those t-elements
     that should be filtered away for the smenob dict, but still kept in the dictionary
     for an eventual reversion to nobsme)
 ==> TO DO

=============================================

=============================================
