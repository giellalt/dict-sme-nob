Incoming files to the smenob dictionary.

Some of these files are entries on their way to a smenob dictionary.

The files in news1056 are the really new files. See the 00readme.txt file there.


In this directory the relevant file is inc-today.csv.

The file is already translated, __but it must be checked__.

- Errors should be corrected
- Words not relevant to the dictionary should be removed
- The rest should be sent to addition to dict








--------------------------

There is a xsl file to transform the csv file, it may be obsolete.

Just try the following:

java -Xmx2048m net.sf.saxon.Transform -it main table2xml.xsl inFile=test_t2x.csv

and after that have a look at the output

vi out/test_t2x.csv.xml


