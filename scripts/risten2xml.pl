#!/usr/bin/perl -w

# Minimalistic perl script to move from risten input to 
# xml output.
# Using twig or something advanced would clearly be better.
# On the other hand side, this works.
# Well, what twig etc gives is contitionality. Here there is one input only.

use encoding 'utf-8';

while ($line = <> ) {
    chomp $line;
    ($sme,
     $smepos,
     $nob,
     $nobpos)
	= split /\t/, $line ;
#    print "samisk: $sme\n";
#    print "pos: $smepos\n";
    print "  <e>\n    <lg>\n      <l pos=\"$smepos\">$sme</l>\n    </lg>\n    <mg>\n      <tg>\n        <t pos=\"$nobpos\">$nob</t>\n      </tg>\n    </mg>\n  </e>\n\n" ;

}
