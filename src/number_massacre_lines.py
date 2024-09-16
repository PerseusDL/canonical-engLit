from sys import stdin
import re

cln = 0

for line in stdin:
    ln = line.rstrip()
    if re.search(r'<div type="textpart" subtype="scene"', ln):
        cln = 0

    linep = re.compile('<l>')
    if linep.search(ln):
        cln += 1
        print(ln.replace('<l>', f"<l n='{cln}'>"))
    else:
        print(ln)
