import json
import re
from pathlib import Path

text = Path("new app_details/index.html").read_text(encoding="utf-8", errors="ignore")
tmpl_m = re.search(r'<script type="__bundler/template">\s*(.*?)\s*</script>', text, re.S)
raw = tmpl_m.group(1).strip()
try:
    tmpl = json.loads(raw)
except Exception:
    tmpl = raw

# sample resource-ish patterns
for pat in [
    r"img\d+",
    r"__resources",
    r"ex-full-form",
    r"window\.__resources",
    r"resources\[",
    r"data:image",
]:
    hits = re.findall(pat, tmpl)
    print(pat, "count", len(hits), "sample", hits[:5])

# find url( patterns
urls = re.findall(r"url\(([^)]{0,120})\)", tmpl)
print("url samples", urls[:15])
print("unique url count", len(set(urls)))

# look near kal-framed
idx = tmpl.find("kal-framed")
print("kal-framed idx", idx)
if idx < 0:
    idx = tmpl.find("framed-dining")
    print("framed-dining", idx)
# print a window around first image-looking assignment
for m in re.finditer(r".{0,40}(img\d+|ex-|kal-|stole-|mekhela|making-).{0,40}", tmpl):
    print(m.group(0)[:120])
    break

# Check if template uses about:blank#uuid
uuids = re.findall(r"about:blank#([0-9a-f\-]{36})", tmpl)
print("about blank uuids", len(set(uuids)))

# Or src=\"uuid
src_u = re.findall(r'(?:src|url)\([\"\']?([0-9a-f\-]{36})', tmpl)
print("src uuids", len(set(src_u)))

# Find how background-image is written
for m in re.finditer(r"background-image:[^;]{0,200}", tmpl):
    print("bg", m.group(0)[:200])
    if m.start() > 5000:
        break
