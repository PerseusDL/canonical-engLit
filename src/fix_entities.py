import re
from sys import stdin

def process_line(line):
    line = line.replace('U+00E0', u"\u00E0")
    line = line.replace('U+00E8', u"\u00E8")
    line = line.replace('U+00F2', u"\u00F2")
    line = line.replace('U+00F9', u"\u00F9")


    line = line.replace('U+00E2', u"\u00E2")
    line = line.replace('U+00F4', u"\u00F4")
    line = line.replace('U+00FB', u"\u00FB")
    line = line.replace('U+00E9', u"\u00E9")
    line = line.replace('U+00E4', u"\u00E4")
    line = line.replace('U+00EB', u"\u00EB")
    line = line.replace('U+00EF', u"\u00EF")
    line = line.replace('U+00F6', u"\u00F6")

    line = line.replace('U+1DD7', u"\u1DD7")
    line = line.replace('U+00A3', u"\u00A3")
    line = line.replace('U+00E6', u"\u00E6")
    line = line.replace('U+00C6', u"\u00C6")
    line = line.replace('U+00A7', u"\u00A7")
    return line


for line in stdin:
    print(process_line(line.rstrip()))
