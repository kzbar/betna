import argparse, json, re, sys
from pathlib import Path
#"C:\Users\AHMAD\StudioProjects\betna\turkishtenesapp-b336b266baf6.json"
#SETX / GOOGLE_APPLICATION_CREDENTIALS= "C:/Users/AHMAD/StudioProjects/betna/turkishtenesapp-0e6ccce90fa3.json"
# setx GOOGLE_APPLICATION_CREDENTIALS "C:/Users/AHMAD/StudioProjects/betna/turkishtenesapp-0e6ccce90fa3.json"


# python sync_translate_arb.py --arb-dir C:/Users/AHMAD/StudioProjects/betna/lib/l10n --targets ar,tr --engine gcloud
PH_RE = re.compile(r"{[^}]+}")

def load_json(p: Path):
    return json.load(p.open("r", encoding="utf-8")) if p.exists() else {}

def save_json(p: Path, data: dict):
    p.parent.mkdir(parents=True, exist_ok=True)
    with p.open("w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2); f.write("\n")

def mask_placeholders(s: str):
    tokens = PH_RE.findall(s or "")
    safe = s
    mapping = {}
    for i, ph in enumerate(tokens):
        key = f"__PH_{i}__"
        mapping[key] = ph
        safe = safe.replace(ph, key)
    return safe, mapping

def unmask_placeholders(s: str, mapping: dict):
    for k, v in mapping.items():
        s = s.replace(k, v)
    return s

def tr_googletrans(texts, lang):
    from googletrans import Translator  # pip install googletrans==4.0.0-rc1
    t = Translator()
    out = []
    for x in texts:
        out.append("" if not x else t.translate(x, dest=lang).text)
    return out

def tr_gcloud(texts, lang):
    # pip install google-cloud-translate==2.0.1
    from google.cloud import translate_v2 as translate
    client = translate.Client()
    out = []
    for x in texts:
        if not x:
            out.append("")
        else:
            res = client.translate(x, target_language=lang, format_="text")
            out.append(res["translatedText"])
    return out

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arb-dir", default="lib/l10n")
    ap.add_argument("--base", default="intl_en.arb")
    ap.add_argument("--targets", required=True, help="Comma-separated: e.g. ar,tr")
    ap.add_argument("--engine", choices=["googletrans","gcloud"], default="googletrans")
    args = ap.parse_args()

    d = Path(args.arb_dir)
    base = load_json(d / args.base)
    if not base:
        print(f"Base ARB not found or empty: {d / args.base}", file=sys.stderr); sys.exit(1)

    base_str = {k:v for k,v in base.items() if not k.startswith("@") and isinstance(v, str)}
    engine = tr_gcloud if args.engine == "gcloud" else tr_googletrans

    for loc in [x.strip() for x in args.targets.split(",") if x.strip()]:
        target_path = d / f"intl_{loc}.arb"
        target = load_json(target_path)
        target.setdefault("@@locale", loc)

        # keys to translate (missing only)
        keys, masked, maps = [], [], {}
        for k, v in base_str.items():
            if isinstance(target.get(k), str) and target[k].strip() != "":
                continue
            s, mp = mask_placeholders(v)
            keys.append(k); masked.append(s); maps[k] = mp

        if keys:
            try:
                translated = engine(masked, loc)
            except Exception as e:
                print(f"[{loc}] translation error: {e}", file=sys.stderr); sys.exit(2)
            for k, t in zip(keys, translated):
                target[k] = unmask_placeholders(t, maps.get(k, {}))
                meta = f"@{k}"
                if meta in base:
                    target[meta] = base[meta]

        save_json(target_path, target)
        print(f"✔ Synced {target_path} (added {len(keys)} new keys)")

if __name__ == "__main__":
    main()