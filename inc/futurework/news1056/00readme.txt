This file tells how to work with the words in this directory that are
missing in the dictionary.

The underlying data are in the news.1056.cleanfreq.txt. They contain the
svn revision 1956 or our news corpus, lemmatized and ordered according to
frequency.

The list is then checked against the smenob dicitonary of feb 19, 2011, and
divided according to part of speech. Here, the files are shown, as are the number
of words in them: 

    1625 news.1056.missing_adjs.csv
    1194 news.1056.missing_advs.csv
   43816 news.1056.missing_nouns.csv
      11 news.1056.missing_numerals.csv
       6 news.1056.missing_pronouns.csv
    3397 news.1056.missing_verbs.csv
   50049 total

(The file news.1056.cleanfreq.txt contains all words, and is there for reference)

The files are of the form:

sami<tab>POS<tab>

Todo:

Translate the words, as follows:

The simplest change is to add a translation at the end:

sami<tab>POS<tab>translation

(remember to add one tabulator sign only)

With more translations, add semicolon:

sami<tab>POS<tab>translation;translation

With examples, add both examplesentence and translationsentence

sami<tab>POS<tab>translation;translation<tab>examplesentence<tab>translationsentence




The files are ordered with the most common words at the top. Adding all the
words is no point (to that the underlying corpus is too bad), just translate
words as long as you have a feeling you are translating common and sensible words.

