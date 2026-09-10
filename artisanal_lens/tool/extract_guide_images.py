"""Extract Click & Social guide images with verified imgN mappings."""

from __future__ import annotations

import base64
import json
import re
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
INDEX = ROOT / "new app_details" / "index.html"
OUT = ROOT / "artisanal_lens" / "assets" / "images" / "guides"

# Verified against bundled template arrays (dc.html path ↔ imgN).
MAPPING: dict[str, str] = {
    # default frameImgs (10 thumbs + panel)
    "ex-full-form.jpg": "img9",
    "ex-close-motif.jpg": "img2",
    "ex-drape-pleats.jpg": "img5",
    "ex-border-folds.jpg": "img1",
    "ex-folded-layers.jpg": "img7",
    "ex-drape-chair-pink.jpg": "img3",
    "stole-flatlay.png": "img44",
    "ex-drape-chair.jpg": "img4",
    "stole-hung.webp": "img45",
    "ex-border-flat.jpg": "img0",
    "kal-panel-tree.jpg": "img29",
    # guide galleries
    "ex-full-dark.jpg": "img8",
    "ex-full-spread.jpg": "img10",
    "ex-folded-basket.jpg": "img6",
    "mekhela-drapes.png": "img43",
    # framed room
    "kal-framed-sofa.jpg": "img17",
    "kal-framed-dining.jpg": "img16",
    "kal-scroll-hang.jpg": "img38",
    "kal-gallery-wall.jpg": "img18",
    # makingByCluster
    "kal-making-pen.jpg": "img24",
    "kal-making-outline.jpg": "img22",
    "kal-making-painting.jpg": "img23",
    "making-assam.jpg": "img40",
    "making-jamdani-1.jpg": "img41",
    "making-jamdani-2.jpg": "img42",
    # makingGal extras
    "kal-making-intro.jpg": "img21",
    "kal-making-sketch.jpg": "img25",
    # kalFrameImgs.sari
    "kal-sari-room-full.jpg": "img36",
    "kal-fish-close.jpg": "img14",
    "kal-sari-yali.jpg": "img37",
    "kal-radha-krishna.jpg": "img31",
    "kal-folded-zari.jpg": "img15",
    "kal-saree-back.jpg": "img33",
    "kal-fish-close-2.jpg": "img13",
    "kal-model-outdoor.jpg": "img27",
    "kal-hung-rod.jpg": "img19",
    "kal-drape-close.jpg": "img12",
    # kalFrameImgs.stole (unique)
    "kal-pen-bw.jpg": "img30",
    "kal-stole-blue.jpg": "img39",
    "kal-runway.jpg": "img32",
    "kal-model-dupatta.jpg": "img26",
    # kalFrameImgs.panel
    "kal-panel-fish.jpg": "img28",
    # kalGals extras
    "kal-sari-room-close.jpg": "img35",
    "kal-kanchi-drape.jpg": "img34",  # may refine below
    "kal-saree-spread.jpg": "img20",  # may refine below
    "ex-post-card.jpg": "img11",
}


def decode(entry: dict) -> bytes:
    raw = base64.b64decode(entry["data"])
    if entry.get("compressed"):
        for wbits in (zlib.MAX_WBITS, -zlib.MAX_WBITS, 16 + zlib.MAX_WBITS):
            try:
                return zlib.decompress(raw, wbits)
            except zlib.error:
                continue
    return raw


def refine_kal_gals(tmpl: str) -> None:
    def imgs(s: str) -> list[str]:
        return re.findall(r"\(window\.__resources\|\|\{\}\)\.(img\d+)", s)

    # Dump kalGalsByProd.sari from template and map known dc paths
    idx = tmpl.find("kalGalsByProd")
    if idx < 0:
        return
    chunk = tmpl[idx : idx + 2500]
    # sari:2 = yali, kanchi-drape, saree-spread
    m = re.search(r"2:\s*\[([^\]]+)\]", chunk)
    if m:
        found = imgs(m.group(1))
        names = ["kal-sari-yali.jpg", "kal-kanchi-drape.jpg", "kal-saree-spread.jpg"]
        for name, mid in zip(names, found):
            MAPPING[name] = mid
    # sari:1 already has room-close
    m = re.search(r"1:\s*\[([^\]]+)\]", chunk)
    if m:
        found = imgs(m.group(1))
        names = ["kal-sari-room-close.jpg", "kal-fish-close.jpg", "kal-radha-krishna.jpg"]
        for name, mid in zip(names, found):
            MAPPING[name] = mid


def main() -> None:
    text = INDEX.read_text(encoding="utf-8", errors="ignore")
    manifest = json.loads(
        re.search(
            r'<script type="__bundler/manifest">\s*(\{.*?\})\s*</script>',
            text,
            re.S,
        ).group(1)
    )
    id_list = json.loads(re.search(r'(\[{"id":"img\d+".*?\}\])', text).group(1))
    id_map = {e["id"]: e["uuid"] for e in id_list if str(e["id"]).startswith("img")}
    tmpl = json.loads(
        re.search(
            r'<script type="__bundler/template">\s*(.*?)\s*</script>',
            text,
            re.S,
        )
        .group(1)
        .strip()
    )
    refine_kal_gals(tmpl)

    # Clean previous extract
    if OUT.exists():
        for p in OUT.iterdir():
            if p.is_file():
                p.unlink()
    OUT.mkdir(parents=True, exist_ok=True)

    # Detect duplicate img assignments
    by_img: dict[str, list[str]] = {}
    for name, mid in MAPPING.items():
        by_img.setdefault(mid, []).append(name)
    for mid, names in by_img.items():
        if len(names) > 1:
            print(f"NOTE shared {mid}: {names}")

    written = 0
    for name, mid in sorted(MAPPING.items()):
        uuid = id_map.get(mid)
        if not uuid or uuid not in manifest:
            print("MISSING", name, mid)
            continue
        raw = decode(manifest[uuid])
        (OUT / name).write_bytes(raw)
        written += 1
        print(f"wrote {name:28s} {mid:6s} {len(raw):8d}b")

    print(f"\nDone: {written} -> {OUT}")


if __name__ == "__main__":
    main()
