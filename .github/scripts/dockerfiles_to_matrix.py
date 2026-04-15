#!/usr/bin/env python3
"""
Reads changed Dockerfile paths from stdin (one per line) and outputs a JSON
array of { context, tag } objects for use as a GitHub Actions matrix.

Input example:
  games/terraria/vanilla/Dockerfile
  games/minecraft/papermc/Dockerfile

Output example:
  [{"context":"games/terraria/vanilla","tag":"ghcr.io/kleffio/games:terraria-vanilla"},
   {"context":"games/minecraft/papermc","tag":"ghcr.io/kleffio/games:minecraft-papermc"}]
"""

import json
import sys

entries = []

for line in sys.stdin:
    path = line.strip()
    if not path or not path.endswith("/Dockerfile"):
        continue

    # Expected layout: {category}/{id}/{version}/Dockerfile
    parts = path.split("/")
    if len(parts) != 4:
        continue

    category, crate_id, version, _ = parts
    image_tag = f"ghcr.io/kleffio/{category}:{crate_id}-{version}"
    context = "/".join(parts[:3])

    entries.append({"context": context, "tag": image_tag})

print(json.dumps(entries))
