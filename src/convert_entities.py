import re
from sys import stdin


def process_line(line):
    line = re.sub('&agrave;', u"U+00E0", line)
    line = re.sub('&egrave;', u"U+00E8", line)
    line = re.sub('&ograve;', u"U+00F2", line)
    line = re.sub('&ugrave;', u"U+00F9", line)


    line = re.sub('&acirc;', u"U+00E2", line)
    line = re.sub('&ocirc;', u"U+00F4", line)
    line = re.sub('&ucirc;', u"U+00FB", line)
    line = re.sub('&eacute;', u"U+00E9", line)
    line = re.sub('&auml;', u"U+00E4", line)
    line = re.sub('&euml;', u"U+00EB", line)
    line = re.sub('&iuml;', u"U+00EF", line)
    line = re.sub('&ouml;', u"U+00F6", line)

    line = re.sub('&ccedil;', u"U+1DD7", line)
    line = re.sub('&pound;', u"U+00A3", line)
    line = re.sub('&aelig;', u"U+00E6", line)
    line = re.sub('&sect;', u"U+00A7", line)
    return line


for line in stdin:
    print(process_line(line.rstrip()))
