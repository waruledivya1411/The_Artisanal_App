import json
import re
from pathlib import Path

text = Path("new app_details/index.html").read_text(encoding="utf-8", errors="ignore")
tmpl = json.loads(
    re.search(r'<script type="__bundler/template">\s*(.*?)\s*</script>', text, re.S)
    .group(1)
    .strip()
)

def imgs(s):
    return re.findall(r"\(window\.__resources\|\|\{\}\)\.(img\d+)", s)

# frameImgs default
m = re.search(r": \[(.*?makingThumb.*?)\]", tmpl, re.S)
# simpler
m = re.search(r"frameImgs = isKal\s*\n\s*\?[\s\S]{0,200}?: \[([^\]]+)\]", tmpl)
print("frameImgs", imgs(m.group(1)) if m else None)

block = re.search(r"kalFrameImgs = \{([\s\S]*?)\n\s*\};", tmpl)
print("--- kalFrameImgs ---")
print(block.group(1)[:1500] if block else "none")

print("--- makingByCluster ---")
idx = tmpl.find("makingByCluster")
print(tmpl[idx:idx+700])

print("--- makingGal ---")
idx = tmpl.find("const makingGal")
print(tmpl[idx:idx+500])

print("--- Show it in a room ---")
idx = tmpl.find("Show it in a room")
print(tmpl[idx:idx+500])

print("--- Whole piece ---")
idx = tmpl.find("Whole piece in frame")
print(tmpl[idx:idx+450])
