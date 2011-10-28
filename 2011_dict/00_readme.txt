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

