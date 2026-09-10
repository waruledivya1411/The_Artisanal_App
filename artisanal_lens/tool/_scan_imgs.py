import json
import re
from pathlib import Path

text = Path("new app_details/index.html").read_text(encoding="utf-8", errors="ignore")
ids_m = re.search(r'(\[{"id":"img\d+".*?\}\])', text)
id_list = json.loads(ids_m.group(1))
print("count", len(id_list))
print("ids", [e["id"] for e in id_list])

dc = Path("new app_details/Click and Social App.dc.html").read_text(
    encoding="utf-8", errors="ignore"
)
assets = []
seen = set()
for n in re.findall(r"assets/([a-z0-9_.\-]+\.(?:jpg|png|webp))", dc):
    if n not in seen:
        seen.add(n)
        assets.append(n)
print("assets", len(assets))
for a in assets:
    print(a)

# Also search template for filename remnants
tmpl_m = re.search(r'<script type="__bundler/template">\s*(.*?)\s*</script>', text, re.S)
if tmpl_m:
    raw = tmpl_m.group(1).strip()
    try:
        tmpl = json.loads(raw)
    except Exception:
        tmpl = raw
    print("template len", len(tmpl))
    # find __resources.imgN
    refs = sorted(set(re.findall(r"__resources\.(img\d+)", tmpl)), key=lambda x: int(x[3:]))
    print("resource refs in template", len(refs), refs[:20])
