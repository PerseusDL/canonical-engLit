from sys import stdin
import re

cln = 0
in_scene = False

start_scenep = re.compile('<div2')
end_scenep = re.compile('</div2')


    
    
for line in stdin:
    ln = line.rstrip()
    if start_scenep.search(ln):
        in_scene = True
        cln = 0
    if end_scenep.search(ln):
        in_scene = False

    linep = re.compile('<l>')
    if linep.search(ln):
        cln += 1
        print(ln.replace('<l>', f"<l n='{cln}'>"))
    else:
        print(ln)
    


        

