import re
from sys import stdin


for line in stdin:
    line = line.rstrip()
    line = re.sub(r"<div type=\"paragraph\".*?>", "", line)
    line = re.sub(r"</div>", '', line)
    print(line)
