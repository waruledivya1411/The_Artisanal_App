import json
import re
from pathlib import Path

text = Path("new app_details/index.html").read_text(encoding="utf-8", errors="ignore")
tmpl_m = re.search(r'<script type="__bundler/template">\s*(.*?)\s*</script>', text, re.S)
tmpl = json.loads(tmpl_m.group(1).strip())

# Find asset path -> img mappings in JS
# Common pattern: 'assets/foo.jpg' -> window.__resources.imgN
pairs = re.findall(
    r"['\"]assets/([^'\"]+\.(?:jpg|png|webp))['\"].{0,80}?__resources\.(img\d+)",
    tmpl,
    re.S,
)
print("pairs type A", len(pairs))
for p in pairs[:20]:
    print(p)

pairs_b = re.findall(
    r"__resources\.(img\d+).{0,80}?['\"]assets/([^'\"]+\.(?:jpg|png|webp))['\"]",
    tmpl,
    re.S,
)
print("pairs type B", len(pairs_b))
for p in pairs_b[:20]:
    print(p)

# Maybe assets paths are fully replaced already
# Find all assets/ mentions
assets = re.findall(r"assets/[a-z0-9_.\-]+\.(?:jpg|png|webp)", tmpl)
print("assets mentions", len(assets), "unique", len(set(assets)))
print(sorted(set(assets))[:20])

# Find assignment like frameImgs
idx = tmpl.find("frameImgs")
print("frameImgs idx", idx)
if idx >= 0:
    print(tmpl[idx : idx + 800])

idx = tmpl.find("ex-full")
print("ex-full", idx)
idx = tmpl.find("kal-framed-dining")
print("kal-framed-dining", idx)

# Maybe rewritten to only __resources — search nearby strings in shotDefs area
idx = tmpl.find("Full display")
print("Full display", idx)
if idx >= 0:
    print(tmpl[idx - 200 : idx + 500])
