import re
from sys import stdin
import logging

def convert_entities(line):
    line = re.sub('&Agrave;', u"\u00C0", line)
    line = re.sub('&agrave;', u"\u00E0", line)
    line = re.sub('&egrave;', u"\u00E8", line)
    line = re.sub('&igrave;', u"\u00EC", line)
    line = re.sub('&ograve;', u"\u00F2", line)
    line = re.sub('&ugrave;', u"\u00F9", line)

    line = line.replace('&aacute;', u"\u00E1")
    line = line.replace('&cacute;', u"\u0107")
    line = line.replace('&Eacute;', u"\u00C9")
    line = line.replace('&eacute;', u"\u00E9")
    line = line.replace('&gacute;', u"\u01F5")
    line = line.replace('&iacute;', u"\u00ED")
    line = line.replace('&nacute;', u"\u0144")
    line = line.replace('&oacute;', u"\u00F3")
    line = line.replace('&uacute;', u"\u00FA")
    line = line.replace('&racute;', u"\u0155")
    line = line.replace('&sacute;', u"\u015B")
    line = line.replace('&yacute;', u"\u00FD")

    line = re.sub('&acirc;', u"\u00E2", line)
    line = re.sub('&ecirc;', u"\u00EA", line)
    line = re.sub('&icirc;', u"\u00EE", line)
    line = re.sub('&Ocirc;', u"\u00D4", line)
    line = re.sub('&ocirc;', u"\u00F4", line)
    line = re.sub('&ucirc;', u"\u00FB", line)

    line = re.sub('&Auml;', u"\u00C4", line)
    line = re.sub('&auml;', u"\u00E4", line)
    line = re.sub('&euml;', u"\u00EB", line)
    line = re.sub('&iuml;', u"\u00EF", line)
    line = re.sub('&ouml;', u"\u00F6", line)
    line = re.sub('&uuml;', u"\u00FC", line)
    line = re.sub('&yuml;', u"\u00FF", line)

    line = re.sub('&amacr;', u"\u0101", line)
    line = re.sub('&emacr;', u"\u0113", line)
    line = re.sub('&imacr;', u"\u012B", line)
    line = re.sub('&omacr;', u"\u014C", line)
    line = re.sub('&umacr;', u"\u016B", line)

    line = re.sub('&Amacr;', u"\u0100", line)
    line = re.sub('&ccedil;', u"\u1DD7", line)
    line = re.sub('&pound;', u"\u00A3", line)
    line = re.sub('&aelig;', u"\u00E6", line)
    line = re.sub('&oelig;', u"\u0153", line)
    line = re.sub('&OElig;', u"\u0152", line)
    line = re.sub('&AElig;', u"\u00C6", line)
    line = re.sub('&szlig;', u"\u00DF", line)

    line = re.sub('&sect;', u"\u00A7", line)
    line = line.replace('&mdash;', u"\u2014")
    line = line.replace('&lsquo;', u"\u2018")
    line = line.replace('&rsquo;', u"\u2019")

    line = line.replace('&mdash;', u"\u2014")
    line = line.replace('&ndash;', u"\u2013")
    line = line.replace('&lsquo;', u"\u2018")
    line = line.replace('&ldquo;', u"\u201C")
    line = line.replace('&rsquo;', u"\u2019")
    line = line.replace('&rdquo;', u"\u201D")

    line = line.replace('&para;', u"\u00B6")
    line = line.replace('&par;', u"\u00B6")
    line = line.replace('&nbsp;', ' ')

    line = line.replace('&atilde;', u"\u00E3")
    line = line.replace('&ntilde;', u"\u00F1")
    line = line.replace('&otilde;', u"\u00F5")
    line = line.replace('&utilde;', u"\u0169")

    line = line.replace('&aring;', u"\u00E5")
    line = line.replace('&uring;', u"\u016F")

    line = line.replace('&ecaron;', u"\u011B")

    line = line.replace('&dagger;', u"\u2020")
    line = line.replace('&thorn;', u"\u00FE")

    line = line.replace('&abreve;', u"\u0103")
    line = line.replace('&ebreve;', u"\u0115")
    line = line.replace('&ibreve;', u"\u012D")
    line = line.replace('&obreve;', u"\u014F")
    line = line.replace('&ubreve;', u"\u016D")
    

    line = re.sub('&responsibility;', '', line)
    line = re.sub('&fund.DLI2;', '', line)
    line = re.sub('&Perseus.publish;', '<publicationStmt><p>later</p></publicationStmt>', line)
    line = re.sub('&Holinshed.publicationStmt;', '<p>later</p>', line)
    line = re.sub('&Ellis.sourceDesc;', '<p>later</p>', line)
    line = re.sub('&Perseus.DE;', '<p>later</p>', line)


    # fractions
    line = line.replace('&frac12;', u"\u00BD")
    line = line.replace('&frac14;', u"\u00BC")
    line = line.replace('&frac34;', u"\u00BE")
    return line


def process_line(line):
    line = convert_entities(line)
    print(line)



if __name__ == "__main__":
    logger = logging.getLogger(__name__)
    logging.basicConfig(filename='log.log', encoding='utf-8', level=logging.DEBUG)
    start = False
    logger.debug('looking for TEI.2 element')
    for line in stdin:
        line = line.rstrip()
        if start is False:
            if re.match(r'^.*<TEI.2>', line):
                start = True
                logger.debug('found TEI.2 element')
                print("""<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="../../../../schemas/perseus_holinshed.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>""")
                print("<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">")

        elif re.match(r'^.*</TEI.2>', line):
            print("</TEI>")
        else:
            process_line(line)
