#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["lxml"]
# ///

"""
For each variant file in inc/varianter/ (except kaffeord.txt), find the <e>
node in src/ whose <l> text matches the first word on the line, then create
copies with the lemma replaced by each variant word. Write all variant nodes
to src/variants_smenob.xml.
"""

import copy
from pathlib import Path

from lxml import etree

REPO = Path(__file__).parent.parent

XML_HEADER = """\
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet media="screen"              title="Dictionary view"   href="../../giella-core/dicts/scripts/gt_dictionary_XXE.css"     type="text/css"?>
<?xml-stylesheet media="screen"              title="Hierarchical view" href="../../giella-core/dicts/scripts/gt_dictionary_XXE_alt.css" type="text/css" alternate="yes" ?>
<?xml-stylesheet media="print,tv,projection" title="Dictionary view"   href="../../giella-core/dicts/scripts/gt_dictionary.css"         type="text/css"?>
<?xml-stylesheet media="print,tv,projection" title="Hierarchical view" href="../../giella-core/dicts/scripts/gt_dictionary_alt.css"     type="text/css" alternate="yes" ?>
<!DOCTYPE r PUBLIC "-//DivvunGiellatekno//DTD Dictionaries//Multilingual" "../dtd/smenob.dtd">
"""

LICS_XML = """\
<lics xml:space="preserve">
      <lic xml:lang="en">
      This code is made available under a Creative Commons Attribution license
      <a>http://creativecommons.org/licenses/by/3.0/no/deed.en</a>.

      You are free to copy, distribute and adapt the work, as long as you always give
      proper attribution using the attribution text below.

      For the full license text, see the link above.
    </lic>
      <ref>
      Work by Nils Jernsletten, Giellatekno and Divvun at UiT, and members of
      the language communities. Source code available at
      <a>https://github.com/giellalt/dict-sme-nob</a>.
    </ref>
      <sourcenote>
      THIS TEXT IS THE ORIGINAL SOURCE CODE. This is NOT a fully styled and
      published dictionary. As such it can and will contain unfinished entries,
      unpublished entries, entries with objectionable translations, etc. If you
      find any errors or want to add more words, download the file, edit it, and
      send it back to <a>mailto:feedback@divvun.no</a> and
      <a>mailto:giellatekno@uit.no</a>. Please also note that the entries are
      not necessarily sorted, or could be wrongly sorted.
     </sourcenote>
   </lics>"""

VARIANT_FILES = {
    "variantadj.txt": "A_",
    "variantadverbs.txt": "Adv_",
    "variantnouns.txt": "N_",
    "variantverbs.txt": "V_",
}


def load_variants(filepath: Path) -> list[list[str]]:
    """Return list of word groups (variant spellings of the same word) from comma-separated lines."""
    result = []
    for line in filepath.read_text(encoding="utf-8").splitlines():
        words = [p.strip() for p in line.split(",") if p.strip()]
        if len(words) >= 2:
            result.append(words)
    return result


def build_lemma_index(src_dir: Path, prefix: str) -> dict[str, etree._Element]:
    """Index <e> nodes by lemma text for all XML files matching prefix."""
    index: dict[str, etree._Element] = {}
    for path in sorted(src_dir.glob(f"{prefix}*smenob.xml")):
        tree = etree.parse(str(path))
        for e in tree.getroot().iter("e"):
            l_el = e.find(".//l")
            if l_el is not None and l_el.text:
                lemma = l_el.text.strip()
                if lemma not in index:
                    index[lemma] = e
    return index


def make_variant_node(source_e: etree._Element, variant: str) -> etree._Element:
    new_e = copy.deepcopy(source_e)
    l_el = new_e.find(".//l")
    l_el.text = variant
    return new_e


def main():
    src_dir = REPO / "src"
    variant_dir = REPO / "inc" / "varianter"

    root = etree.Element("r", attrib={"id": "smenob"})
    root.set("{http://www.w3.org/XML/1998/namespace}lang", "sme")
    root.text = "\n   "

    lics = etree.fromstring(LICS_XML)
    lics.tail = "\n   "
    root.append(lics)

    total = 0
    missed = 0

    for filename, prefix in VARIANT_FILES.items():
        vpath = variant_dir / filename
        variants = load_variants(vpath)
        index = build_lemma_index(src_dir, prefix)

        for words in variants:
            source_word = next((w for w in words if w in index), None)
            if source_word is None:
                print(f"NOT FOUND [{prefix}]: {', '.join(words)}")
                missed += 1
                continue
            source_e = index[source_word]
            for word in words:
                if word == source_word:
                    continue
                node = make_variant_node(source_e, word)
                node.tail = "\n   "
                root.append(node)
                total += 1

    if len(root):
        root[-1].tail = "\n"

    out_path = src_dir / "variants_smenob.xml"
    body = etree.tostring(root, encoding="UTF-8", pretty_print=True).decode("utf-8")
    out_path.write_text(XML_HEADER + body, encoding="utf-8")
    print(f"Wrote {total} variant entries to {out_path}")
    if missed:
        print(f"{missed} lemmas not found in XML files")


if __name__ == "__main__":
    main()
