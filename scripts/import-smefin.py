#!/usr/bin/python

import argparse
from lxml import etree
from pathlib import Path

"""
This script is used for importing and merging sme-fin dictionary files
into the existing sme-nob files to create sme-mul files. Run as follows:

python import-smefin.py <sme-fin file> <sme-nob file>

The output is written to the sme-nob file. Any uncertain cases are printed
to the terminal and left for the script runner to manually enter into the sme-nob file.
"""

def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("sme_fin", type=Path)
    parser.add_argument("sme_nob", type=Path)

    return parser.parse_args()

def merge_mgs(smenob_mg, smefin_mg):
    smefin_tg = smefin_mg.xpath("./tg")[0]
    smenob_mg.append(smefin_tg)

def merge_entries(smenob_entry, smefin_entry, smefin_id):
    # Does smefin entry contain multiple mg's?
    smefin_mgs = smefin_entry.xpath("./mg")
    if len(smefin_mgs) > 1:
        print(f"entry {smefin_id} contains multiple mg's. Please merge manually")
        return

    # Merge
    first_smenob_mg = smenob_entry.xpath("./mg")[0]
    smefin_mg = smefin_mgs[0]
    merge_mgs(first_smenob_mg, smefin_mg)


def main(args):
    with open(args.sme_fin) as f:
        smefin_tree = etree.parse(f)

    with open(args.sme_nob) as f:
        smenob_tree = etree.parse(f)

    smefin_root = smefin_tree.getroot()
    smenob_root = smenob_tree.getroot()

    new_entries = []

    # Iterate through smefin entries. Look them up by l in smenob. Try merging
    for entry in smefin_root.iter("e"):
        l = entry.xpath("./lg/l")[0]
        l_id = (l.text, l.get("pos"), l.get("type"))
        smenob_l_list = smenob_root.xpath(f'.//l[text()="{l.text}"]')
        if len(smenob_l_list) == 1:
            # Match! Merge with this entry
            smenob_entry = smenob_l_list[0].getparent().getparent()
            merge_entries(smenob_entry, entry, l_id)
        elif len(smenob_l_list) > 1:
            # Multiple matches! Try to find the correct using pos and type
            for smenob_l in smenob_l_list:
                if smenob_l.get("pos") == l.get("pos") and smenob_l.get("type") == l.get("type"):
                    smenob_entry = smenob_l.getparent().getparent()
                    merge_entries(smenob_entry, entry, l_id)
                    continue
            # If no match, print info:
            print(f"No match for {l_id}. Please merge manually")
        else: # len < 1
            # No match! Add new entry to the end of the smenob file
            new_entries.append(entry)

    # Add entries not existing in smenob to the end of the file
    for entry in new_entries:
        # Add empty smenob tg
        for mg in entry.xpath("./mg"):
            tg = etree.SubElement(mg, "tg")
            tg.set("{http://www.w3.org/XML/1998/namespace}lang", "nob")
            t = etree.SubElement(tg, "t")
            t.text = "_NOB"
        smenob_root.append(entry)

    smenob_tree.write(args.sme_nob, pretty_print=True, encoding="utf-8")




if __name__ == "__main__":
    raise SystemExit(main(parse_args()))