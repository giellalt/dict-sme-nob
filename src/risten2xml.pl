#!/usr/bin/perl -w

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
