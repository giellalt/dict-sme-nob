# print in reverse order the fields of every line
file='SGG_Eurohpa_riikkat.csv'
 #awk '{for (i=1; i<=NF; i++) printf("<p>%s</p>",$i);printf ("\n")}' $file
 awk -F '\t' 'BEGIN{print "<r>"}
      {printf ("  <e id=\""NR"\">\n" );
      for (i=1; i<=NF; i++) printf "    <p id=\""i"\">"$i"</p>\n";
      printf ("  </e>");
      printf ("\n")}
      END{print "</r>"}' $file
