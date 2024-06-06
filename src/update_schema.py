import re
from sys import stdin

def convert_entities(line):
    line = re.sub('&agrave;', u"\u00E0", line)
    line = re.sub('&egrave;', u"\u00E8", line)
    line = re.sub('&ograve;', u"\u00F2", line)
    line = re.sub('&ugrave;', u"\u00F9", line)


    line = re.sub('&acirc;', u"\u00E2", line)
    line = re.sub('&ocirc;', u"\u00F4", line)
    line = re.sub('&ucirc;', u"\u00FB", line)
    line = re.sub('&eacute;', u"\u00E9", line)
    line = re.sub('&auml;', u"\u00E4", line)
    line = re.sub('&euml;', u"\u00EB", line)
    line = re.sub('&iuml;', u"\u00EF", line)
    line = re.sub('&ouml;', u"\u00F6", line)

    line = re.sub('&ccedil;', u"\u1DD7", line)
    line = re.sub('&pound;', u"\u00A3", line)
    line = re.sub('&aelig;', u"\u00E6", line)
    line = re.sub('&AElig;', u"\u00C6", line)
    line = re.sub('&sect;', u"\u00A7", line)
    line = line.replace('&mdash;', u"\u2014")
    line = line.replace('&lsquo;', u"\u2018")
    line = line.replace('&rsquo;', u"\u2019")

    line = re.sub('&responsibility;', '', line)
    line = re.sub('&fund.DLI2;', '', line)
    line = re.sub('&Perseus.publish;', '<publicationStmt><p>later</p></publicationStmt>', line)
    return line


def process_line(line):
    line = convert_entities(line)
    print(line)



if __name__ == "__main__":
    start = False
    for line in stdin:
        line = line.rstrip()
        if start is False:
            if re.match(r'^.*<TEI.2>', line):
                start = True
                print("""<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.stoa.org/epidoc/schema/latest/tei-epidoc.rng" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://epidoc.stoa.org/schema/latest/tei-epidoc.rng"	schematypens="http://purl.oclc.org/dsdl/schematron"?>""")
                print("<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">")

        elif re.match(r'^.*</TEI.2>', line):
            print("</TEI>")
        else:
            process_line(line)
