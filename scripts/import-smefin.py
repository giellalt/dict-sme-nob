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

def main(args):
    with open(args.sme_fin) as f:
        smefin_tree = etree.parse(f)

    with open(args.sme_nob) as f:
        smenob_tree = etree.parse(f)



if __name__ == "__main__":
    raise SystemExit(main(parse_args()))