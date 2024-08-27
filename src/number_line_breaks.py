from sys import stdin
import re

counter = 0
cln = 0


    
    
for line in stdin:
    ln = line.rstrip()
    linep = re.compile('<lb/>')
    if linep.search(ln):
        counter += 1
        print(ln.replace('<lb/>', f"<lb n='{counter}'/>"))
    else:
        print(ln)
    


        

