from sys import stdin
import re

counter = 0

    
    
for line in stdin:
    ln = line.rstrip()
    linep = re.compile('<l>')
    if linep.search(ln):
        counter += 1
        print(ln.replace('<l>', f"<l n='{counter}'>"))
    else:
        print(ln)
    


        

